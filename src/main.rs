mod schema;

use clap::{App, Arg};
use indicatif::{MultiProgress, ProgressBar, ProgressStyle};
use std::{
    error::Error,
    fs::File,
    io::Write,
    thread::{self, JoinHandle},
};

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
        .template(&format!("{}: {{spinner:.green}} [{{elapsed_precise}}] {{wide_bar:.white/blue}} {{pos:>7}}/{{len:7}} ({{eta}})", name))
}

fn main() -> crate::Result<()> {
    let matches = App::new("Test Data Generator")
        .version(env!("CARGO_PKG_VERSION"))
        .arg(
            Arg::with_name("num_users")
                .short("u")
                .long("users")
                .value_name("num_users")
                .help("The number of generated users.")
                .takes_value(true),
        )
        .arg(
            Arg::with_name("num_posts")
                .short("p")
                .long("posts")
                .value_name("num_posts")
                .help("The number of generated posts.")
                .takes_value(true),
        )
        .arg(
            Arg::with_name("num_comments")
                .short("c")
                .long("comments")
                .value_name("num_comments")
                .help("The number of generated comments.")
                .takes_value(true),
        )
        .arg(
            Arg::with_name("num_likes")
                .short("l")
                .long("likes")
                .value_name("num_likes")
                .help("The number of generated likes.")
                .takes_value(true),
        )
        .get_matches();

    let user_count = matches
        .value_of("num_users")
        .and_then(|p| p.parse::<usize>().ok())
        .unwrap_or(10_000);

    let post_count = matches
        .value_of("num_posts")
        .and_then(|p| p.parse::<usize>().ok())
        .unwrap_or(user_count * 10);

    let comment_count = matches
        .value_of("num_comments")
        .and_then(|p| p.parse::<usize>().ok())
        .unwrap_or(user_count * 10);

    let like_count = matches
        .value_of("num_likes")
        .and_then(|p| p.parse::<usize>().ok())
        .unwrap_or(user_count * 50);

    let m = MultiProgress::new();

    {
        let pb = m.add(ProgressBar::new(user_count as u64));
        pb.set_style(progress_style("   generating users"));

        let _: JoinHandle<Result<()>> = thread::spawn(move || {
            let file = File::create("./output/users.csv")?;
            schema::User::generate(file, user_count, pb, schema::UserContext)?;
            Ok(())
        });
    }

    {
        let pb = m.add(ProgressBar::new(post_count as u64));
        pb.set_style(progress_style("   generating posts"));

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
        pb.set_style(progress_style("   generating likes"));

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
