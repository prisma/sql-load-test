mod schema;

use console::{pad_str, Alignment};
use indicatif::{MultiProgress, ProgressBar, ProgressStyle};
use std::{
    error::Error,
    fs::File,
    io::Write,
    thread::{self, JoinHandle},
};
use structopt::StructOpt;
use postgres::{Client, NoTls};
use indoc::indoc;

pub type Result<T> = std::result::Result<T, Box<dyn Error + Send + Sync + 'static>>;

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

fn progress_style(name: &str) -> ProgressStyle {
    ProgressStyle::default_bar()
        .progress_chars("##-")
        .template(
            &format!(
                "{}: {{spinner:.green}} [{{elapsed_precise}}] {{wide_bar:.white/blue}} {{pos:>7}}/{{len:7}} ({{eta}})",
                pad_str(name, 19, Alignment::Right, None),
            )
        )
}

#[derive(Debug, StructOpt)]
/// Prisma Test Data Generator
struct Opt {
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

impl Opt {
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

    fn db_user(&self) -> &str {
        self.db_user.as_ref().map(|s| s.as_str()).unwrap_or_else(|| "postgres")
    }

    fn db_password(&self) -> &str {
        self.db_password.as_ref().map(|s| s.as_str()).unwrap_or_else(|| "prisma")
    }

    fn db_name(&self) -> &str {
        self.db_name.as_ref().map(|s| s.as_str()).unwrap_or_else(|| "postgres")
    }

    fn db_hostname(&self) -> &str {
        self.db_hostname.as_ref().map(|s| s.as_str()).unwrap_or_else(|| "localhost")
    }

    fn db_schema(&self) -> &str {
        self.db_schema.as_ref().map(|s| s.as_str()).unwrap_or_else(|| "sql_load_test")
    }

    fn db_port(&self) -> u16 {
        self.db_port.unwrap_or(5432)
    }
}

fn generate_csv_data(opts: &Opt) -> crate::Result<()> {
    let user_count = opts.users();
    let post_count = opts.posts();
    let comment_count = opts.comments();
    let like_count = opts.likes();

    let m = MultiProgress::new();

    {
        let pb = m.add(ProgressBar::new(user_count as u64));
        pb.set_style(progress_style("generating users"));

        let _: JoinHandle<Result<()>> = thread::spawn(move || {
            let file = File::create("./output/users.csv")?;
            schema::User::generate(file, user_count, pb, schema::UserContext)?;
            Ok(())
        });
    }

    {
        let pb = m.add(ProgressBar::new(post_count as u64));
        pb.set_style(progress_style("generating posts"));

        let _: JoinHandle<Result<()>> = thread::spawn(move || {
            let file = File::create("./output/posts.csv")?;
            schema::Post::generate(file, post_count, pb, schema::PostContext::new(user_count))?;
            Ok(())
        });
    }

    {
        let pb = m.add(ProgressBar::new(comment_count as u64));
        pb.set_style(progress_style("generating comments"));

        let _: JoinHandle<Result<()>> = thread::spawn(move || {
            let file = File::create("./output/comments.csv")?;
            schema::Comment::generate(
                file,
                comment_count,
                pb,
                schema::CommentContext::new(user_count, post_count),
            )?;
            Ok(())
        });
    }

    {
        let pb = m.add(ProgressBar::new(like_count as u64));
        pb.set_style(progress_style("generating likes"));

        let _: JoinHandle<Result<()>> = thread::spawn(move || {
            let file = File::create("./output/likes.csv")?;
            schema::Like::generate(
                file,
                like_count,
                pb,
                schema::LikeContext::new(user_count, post_count, comment_count),
            )?;
            Ok(())
        });
    }

    m.join_and_clear()?;

    Ok(())
}

fn import_data_to_psql(opts: &Opt) -> crate::Result<()> {
    let conn_string = format!(
        "host={} port={}, user={} password={} dbname={}",
        opts.db_hostname(),
        opts.db_port(),
        opts.db_user(),
        opts.db_password(),
        opts.db_name(),
    );

    let mut client = Client::connect(&conn_string, NoTls)?;

    let q = format!("SET search_path = \"{}\"", opts.db_schema());
    client.execute(q.as_str(), &[])?;

    let pb = ProgressBar::new(8);
    let spinner_style = ProgressStyle::default_spinner()
        .tick_chars("⠁⠂⠄⡀⢀⠠⠐⠈ ")
        .template("{prefix:.bold.dim} {spinner} {wide_msg}");

    pb.set_style(spinner_style);

    pb.set_message("Deleting old likes");
    pb.inc(1);
    client.execute("DELETE FROM \"Like\"", &[])?;

    pb.set_message("Deleting old comments");
    pb.inc(1);
    client.execute("DELETE FROM \"Comment\"", &[])?;

    pb.set_message("Deleting old posts");
    pb.inc(1);
    client.execute("DELETE FROM \"Post\"", &[])?;

    pb.set_message("Deleting old users");
    pb.inc(1);
    client.execute("DELETE FROM \"User\"", &[])?;

    {
        pb.set_message("Copying users");
        pb.inc(1);
        let mut f = File::open("./output/users.csv")?;

        let query = indoc!("
            COPY \"User\"(age,\"createdAt\",email,\"firstName\",id,\"lastName\",password,\"updatedAt\")
            FROM STDIN
            DELIMITER ';' CSV HEADER
        ");

        client.copy_in(&*query, &[], &mut f)?;
    }

    {
        pb.set_message("Copying posts");
        pb.inc(1);
        let mut f = File::open("./output/posts.csv")?;

        let query = indoc!("
            COPY \"Post\"(content,\"createdAt\",id,\"updatedAt\",author)
            FROM STDIN
            DELIMITER ';' CSV HEADER
        ");

        client.copy_in(&*query, &[], &mut f)?;
    }

    {
        pb.set_message("Copying comments");
        pb.inc(1);
        let mut f = File::open("./output/comments.csv")?;

        let query = indoc!("
            COPY \"Comment\"(content,id,author,post,\"createdAt\",\"updatedAt\")
            FROM STDIN
            DELIMITER ';' CSV HEADER
        ");

        client.copy_in(&*query, &[], &mut f)?;
    }

    {
        pb.set_message("Copying likes");
        pb.inc(1);
        let mut f = File::open("./output/likes.csv")?;

        let query = indoc!("
            COPY \"Like\"(\"id\",\"comment\",\"post\",\"user\",\"createdAt\",\"updatedAt\")
            FROM STDIN
            DELIMITER ';' CSV HEADER
        ");

        client.copy_in(&*query, &[], &mut f)?;
    }

    Ok(())
}

fn main() -> crate::Result<()> {
    let opts = Opt::from_args();

    generate_csv_data(&opts)?;
    import_data_to_psql(&opts)?;

    Ok(())
}
