use indicatif::{MultiProgress, ProgressBar, ProgressStyle};
use postgres::NoTls;
use r2d2::Pool;
use r2d2_postgres::PostgresConnectionManager;
use std::{
    fs::File,
    thread::{self, JoinHandle},
};

pub struct Importer {
    pool: Pool<PostgresConnectionManager<NoTls>>,
    progress: MultiProgress,
    schema: String,
}

impl Importer {
    pub fn new(opts: &super::ImportPostgres) -> crate::Result<Self> {
        let conn_string = format!(
            "host={} port={} user={} password={} dbname={}",
            opts.db_hostname(),
            opts.db_port(),
            opts.db_user(),
            opts.db_password(),
            opts.db_name(),
        );

        let manager = PostgresConnectionManager::new(conn_string.parse()?, NoTls);
        let pool = r2d2::Pool::builder()
            .max_size(4)
            .test_on_check_out(false)
            .build(manager)?;
        let progress = MultiProgress::new();
        let schema = opts.db_schema().to_string();

        Ok(Self {
            pool,
            progress,
            schema,
        })
    }

    pub fn import(&self) -> crate::Result<()> {
        let tables = vec![
            (
                "User",
                vec![
                    "age",
                    "createdAt",
                    "email",
                    "firstName",
                    "id",
                    "lastName",
                    "password",
                    "updatedAt",
                ],
            ),
            (
                "Post",
                vec!["content", "createdAt", "id", "updatedAt", "author"],
            ),
            (
                "Comment",
                vec!["content", "id", "author", "post", "createdAt", "updatedAt"],
            ),
            (
                "Like",
                vec!["id", "comment", "post", "user", "createdAt", "updatedAt"],
            ),
            ("_FriendShip", vec!["A", "B"]),
        ];

        let mut handles = Vec::with_capacity(tables.len());

        for (table, columns) in tables {
            handles.push(self.copy_table(table, columns))
        }

        self.progress.join_and_clear()?;

        for handle in handles {
            handle.join().unwrap()?;
        }

        Ok(())
    }

    fn copy_table(
        &self,
        table: &'static str,
        columns: Vec<&'static str>,
    ) -> JoinHandle<crate::Result<()>> {
        let pool = self.pool.clone();
        let schema = self.schema.clone();

        let pb = self.progress.add(ProgressBar::new(0));
        let spinner_style = ProgressStyle::default_spinner()
            .tick_chars("⠁⠂⠄⡀⢀⠠⠐⠈ ")
            .template("{prefix:.bold.dim} {spinner} {wide_msg}");

        pb.set_style(spinner_style);

        thread::spawn(move || {
            let mut client = pool.get()?;

            client.execute(format!("SET search_path = \"{}\"", schema).as_str(), &[])?;
            client.execute(
                format!("ALTER TABLE \"{}\" DISABLE TRIGGER ALL", table).as_str(),
                &[],
            )?;

            {
                pb.set_message(format!("Deleting old {}s", table.to_lowercase()).as_str());
                client.execute(format!("DELETE FROM \"{}\"", table).as_str(), &[])?;
            }

            {
                pb.set_message(format!("Copying {}s", table.to_lowercase()).as_str());

                let col_names: Vec<String> =
                    columns.into_iter().map(|c| format!("\"{}\"", c)).collect();

                let query = format!(
                    "
                    COPY \"{}\"({})
                    FROM STDIN
                    DELIMITER ';' CSV HEADER
                ",
                    table,
                    col_names.join(",")
                );

                let mut f = File::open(
                    format!("./output/{}s.csv", table.to_lowercase().replace('_', "")).as_str(),
                )?;

                let mut writer = client.copy_in(&*query)?;
                std::io::copy(&mut f, &mut writer)?;
                writer.finish()?;
            }

            client.execute("ALTER TABLE \"User\" ENABLE TRIGGER ALL", &[])?;

            Ok(())
        })
    }
}
