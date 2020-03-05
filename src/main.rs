mod csv_generator;
mod psql_importer;
mod schema;

use csv_generator::CsvGenerator;
use indicatif::ProgressBar;
use psql_importer::Importer;
use std::io::Write;
use structopt::StructOpt;

pub type Result<T> = std::result::Result<T, anyhow::Error>;

pub trait Generator {
    type Context;

    fn generate<W>(writer: W, count: usize, pb: ProgressBar, ctx: Self::Context) -> Result<()>
    where
        W: Write;
}

pub fn namify(s: String) -> String {
    let mut v: Vec<char> = s.chars().collect();
    v[0] = v[0].to_uppercase().nth(0).unwrap();

    v.into_iter().collect()
}

#[derive(Debug, StructOpt, Clone)]
/// Prisma Test Data Generator
pub enum Opt {
    /// Generate sample data as CSV.
    #[structopt(name = "generate")]
    Generate(Generate),
    /// Import the generated CSVs into postgres.
    #[structopt(name = "import-postgres")]
    ImportPostgres(ImportPostgres),
}

#[derive(Debug, StructOpt, Clone)]
pub struct Generate {
    #[structopt(short, long)]
    /// Number of users to generate in the system. (default: 10k)
    users: Option<usize>,
    #[structopt(short, long)]
    /// Number of posts to generate in the system. (default: users * 10)
    posts: Option<usize>,
    #[structopt(short, long)]
    /// Number of comments to generate in the system. (default: users * 10)
    comments: Option<usize>,
    #[structopt(short, long)]
    /// Number of likes to generate in the system. (default: users * 50)
    likes: Option<usize>,
    #[structopt(short, long)]
    /// Number of friendships to generate in the system. (default: users * 10)
    friendships: Option<usize>,
}

#[derive(Debug, StructOpt, Clone)]
pub struct ImportPostgres {
    #[structopt(long)]
    /// Login name to the PostgreSQL database.
    db_user: Option<String>,
    #[structopt(long)]
    /// Password to the PostgreSQL database.
    db_password: Option<String>,
    #[structopt(long)]
    /// Name of the PostgreSQL database.
    db_name: Option<String>,
    #[structopt(long)]
    /// Hostname of the PostgreSQL database.
    db_hostname: Option<String>,
    #[structopt(long)]
    /// Schema name in the PostgreSQL database.
    db_schema: Option<String>,
    #[structopt(long)]
    /// Port of the PostgreSQL database.
    db_port: Option<u16>,
}

impl ImportPostgres {
    fn db_user(&self) -> &str {
        self.db_user
            .as_ref()
            .map(|s| s.as_str())
            .unwrap_or_else(|| "postgres")
    }

    fn db_password(&self) -> &str {
        self.db_password
            .as_ref()
            .map(|s| s.as_str())
            .unwrap_or_else(|| "prisma")
    }

    fn db_name(&self) -> &str {
        self.db_name
            .as_ref()
            .map(|s| s.as_str())
            .unwrap_or_else(|| "postgres")
    }

    fn db_hostname(&self) -> &str {
        self.db_hostname
            .as_ref()
            .map(|s| s.as_str())
            .unwrap_or_else(|| "localhost")
    }

    fn db_schema(&self) -> &str {
        self.db_schema
            .as_ref()
            .map(|s| s.as_str())
            .unwrap_or_else(|| "sql_load_test")
    }

    fn db_port(&self) -> u16 {
        self.db_port.unwrap_or(5432)
    }
}

impl Generate {
    fn users(&self) -> usize {
        self.users.unwrap_or(10_000)
    }

    fn posts(&self) -> usize {
        self.posts.unwrap_or(self.users() * 10)
    }

    fn comments(&self) -> usize {
        self.comments.unwrap_or(self.users() * 10)
    }

    fn likes(&self) -> usize {
        self.likes.unwrap_or(self.users() * 50)
    }

    fn friendships(&self) -> usize {
        self.friendships.unwrap_or(self.users() * 10)
    }
}

fn main() -> crate::Result<()> {
    let opts = Opt::from_args();

    match opts {
        Opt::Generate(generate) => CsvGenerator::new(&generate).generate(),
        Opt::ImportPostgres(import_postgres) => Importer::new(&import_postgres)?.import(),
    }
}
