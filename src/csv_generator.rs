use super::{schema, Generator};
use console::{pad_str, Alignment};
use indicatif::{MultiProgress, ProgressBar, ProgressStyle};
use std::{
    fs::File,
    thread::{self, JoinHandle},
};

pub struct CsvGenerator {
    users: usize,
    posts: usize,
    comments: usize,
    likes: usize,
    progress: MultiProgress,
}

impl CsvGenerator {
    pub fn new(opts: &super::Generate) -> Self {
        Self {
            users: opts.users(),
            posts: opts.posts(),
            comments: opts.comments(),
            likes: opts.likes(),
            progress: MultiProgress::new(),
        }
    }

    pub fn generate(&self) -> crate::Result<()> {
        self.generate_users();
        self.generate_posts();
        self.generate_comments();
        self.generate_likes();
        self.progress.join_and_clear()?;

        Ok(())
    }

    fn generate_users(&self) -> JoinHandle<crate::Result<()>> {
        let users = self.users;

        let file = File::create("./output/users.csv").unwrap();
        let pb = self.progress.add(ProgressBar::new(users as u64));

        pb.set_style(Self::progress_style("generating users"));

        thread::spawn(move || schema::User::generate(file, users, pb, schema::UserContext))
    }

    fn generate_posts(&self) -> JoinHandle<crate::Result<()>> {
        let posts = self.posts;
        let users = self.users;

        let file = File::create("./output/posts.csv").unwrap();
        let pb = self.progress.add(ProgressBar::new(posts as u64));
        pb.set_style(Self::progress_style("generating posts"));

        thread::spawn(move || {
            schema::Post::generate(file, posts, pb, schema::PostContext::new(users))
        })
    }

    fn generate_comments(&self) -> JoinHandle<crate::Result<()>> {
        let users = self.users;
        let posts = self.posts;
        let comments = self.comments;

        let file = File::create("./output/comments.csv").unwrap();
        let pb = self.progress.add(ProgressBar::new(comments as u64));
        pb.set_style(Self::progress_style("generating comments"));

        thread::spawn(move || {
            schema::Comment::generate(
                file,
                comments,
                pb,
                schema::CommentContext::new(users, posts),
            )
        })
    }

    fn generate_likes(&self) -> JoinHandle<crate::Result<()>> {
        let users = self.users;
        let posts = self.posts;
        let comments = self.comments;
        let likes = self.likes;

        let file = File::create("./output/likes.csv").unwrap();
        let pb = self.progress.add(ProgressBar::new(likes as u64));
        pb.set_style(Self::progress_style("generating likes"));

        thread::spawn(move || {
            schema::Like::generate(
                file,
                likes,
                pb,
                schema::LikeContext::new(users, posts, comments),
            )
        })
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
}
