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
}

fn main() -> crate::Result<()> {
    let opts = Opt::from_args();

    let user_count = opts.users.unwrap_or(10_000);
    let post_count = opts.posts.unwrap_or(user_count * 10);
    let comment_count = opts.posts.unwrap_or(user_count * 10);
    let like_count = opts.posts.unwrap_or(user_count * 10);

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

    m.join_and_clear().unwrap();

    Ok(())
}
