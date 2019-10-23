mod schema;

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

const USER_COUNT: usize = 10_000;
const POST_COUNT: usize = 10 * USER_COUNT;

fn main() -> crate::Result<()> {
    let m = MultiProgress::new();

    let style = ProgressStyle::default_bar().progress_chars("##-");

    {
        let pb = m.add(ProgressBar::new(USER_COUNT as u64));

        let style = style
            .clone()
            .template("generating users: {spinner:.green} [{elapsed_precise}] {bar:40.cyan/blue} {pos:>7}/{len:7}");

        pb.set_style(style);

        let _: JoinHandle<Result<()>> = thread::spawn(move || {
            let file = File::create("./output/users.csv")?;
            schema::User::generate(file, USER_COUNT, pb, schema::UserContext)?;
            Ok(())
        });
    }

    {
        let pb = m.add(ProgressBar::new(POST_COUNT as u64));

        let style = style
            .clone()
            .template("generating posts: {spinner:.green} [{elapsed_precise}] {bar:40.cyan/blue} {pos:>7}/{len:7}");

        pb.set_style(style);

        let _: JoinHandle<Result<()>> = thread::spawn(move || {
            let file = File::create("./output/posts.csv")?;
            schema::Post::generate(file, POST_COUNT, pb, schema::PostContext::new(USER_COUNT))?;
            Ok(())
        });
    }

    m.join_and_clear().unwrap();

    Ok(())
}
