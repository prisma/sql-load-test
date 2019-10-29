use super::{schema, Generator, Opt};
use console::{pad_str, Alignment};
use indicatif::{ProgressBar, ProgressStyle};
use std::{fs::File, thread};

#[derive(Clone, Copy, Debug)]
pub struct CsvGenerator {
    users: usize,
    posts: usize,
    comments: usize,
    likes: usize,
}

impl CsvGenerator {
    pub fn new(opts: &Opt) -> Self {
        Self {
            users: opts.users(),
            posts: opts.posts(),
            comments: opts.comments(),
            likes: opts.likes(),
        }
    }

    pub fn generate(self) -> crate::Result<()> {
        self.generate_users()?;
        self.generate_posts()?;
        self.generate_comments()?;
        self.generate_likes()?;

        Ok(())
    }

    fn generate_users(self) -> crate::Result<()> {
        let pb = ProgressBar::new(self.users as u64);
        pb.set_style(Self::progress_style("generating users"));

        let mut handles = Vec::new();
        let cpu_count = num_cpus::get();
        let mut total_users = self.users;

        if total_users < cpu_count {
            let file = File::create("./output/users/0.csv")?;
            schema::User::generate(file, total_users, pb, schema::UserContext)?;
            return Ok(());
        } else {
            let mut users_per_cpu = total_users / cpu_count;

            for i in 0..cpu_count {
                if total_users >= users_per_cpu {
                    total_users -= users_per_cpu;
                } else {
                    users_per_cpu = total_users;
                }

                let pb = pb.clone();

                let handle = thread::spawn(move || {
                    let file = File::create(format!("./output/users/{}.csv", i).as_str())?;
                    schema::User::generate(file, users_per_cpu, pb, schema::UserContext)
                });

                handles.push(handle);
            }
        }

        for handle in handles {
            handle.join().unwrap()?;
        }

        Ok(())
    }

    fn generate_posts(self) -> crate::Result<()> {
        let pb = ProgressBar::new(self.posts as u64);
        pb.set_style(Self::progress_style("generating posts"));

        let mut handles = Vec::new();
        let cpu_count = num_cpus::get();
        let mut total_posts = self.posts;

        if total_posts < cpu_count {
            let file = File::create("./output/posts/0.csv")?;
            schema::Post::generate(file, total_posts, pb, schema::PostContext::new(self.users))?;
            return Ok(());
        } else {
            let mut posts_per_cpu = total_posts / cpu_count;

            for i in 0..cpu_count {
                if total_posts >= posts_per_cpu {
                    total_posts -= posts_per_cpu;
                } else {
                    posts_per_cpu = total_posts;
                }

                let pb = pb.clone();

                let handle = thread::spawn(move || {
                    let file = File::create(format!("./output/posts/{}.csv", i).as_str())?;
                    schema::Post::generate(
                        file,
                        posts_per_cpu,
                        pb,
                        schema::PostContext::new(self.users),
                    )
                });

                handles.push(handle);
            }
        }

        for handle in handles {
            handle.join().unwrap()?;
        }

        Ok(())
    }

    fn generate_comments(self) -> crate::Result<()> {
        let pb = ProgressBar::new(self.comments as u64);
        pb.set_style(Self::progress_style("generating comments"));

        let mut handles = Vec::new();
        let cpu_count = num_cpus::get();
        let mut total_comments = self.comments;

        if total_comments < cpu_count {
            let file = File::create("./output/comments/0.csv")?;

            schema::Comment::generate(
                file,
                total_comments,
                pb,
                schema::CommentContext::new(self.users, self.posts),
            )?;

            return Ok(());
        } else {
            let mut comments_per_cpu = total_comments / cpu_count;

            for i in 0..cpu_count {
                if total_comments >= comments_per_cpu {
                    total_comments -= comments_per_cpu;
                } else {
                    comments_per_cpu = total_comments;
                }

                let pb = pb.clone();

                let handle = thread::spawn(move || {
                    let file = File::create(format!("./output/comments/{}.csv", i).as_str())?;

                    schema::Comment::generate(
                        file,
                        comments_per_cpu,
                        pb,
                        schema::CommentContext::new(self.users, self.posts),
                    )
                });

                handles.push(handle);
            }
        }

        for handle in handles {
            handle.join().unwrap()?;
        }

        Ok(())
    }

    fn generate_likes(self) -> crate::Result<()> {
        let pb = ProgressBar::new(self.likes as u64);
        pb.set_style(Self::progress_style("generating likes"));

        let mut handles = Vec::new();
        let cpu_count = num_cpus::get();
        let mut total_likes = self.likes;

        if total_likes < cpu_count {
            let file = File::create("./output/likes/0.csv")?;

            schema::Like::generate(
                file,
                total_likes,
                pb,
                schema::LikeContext::new(self.users, self.posts, self.comments),
            )?;

            return Ok(());
        } else {
            let mut likes_per_cpu = total_likes / cpu_count;

            for i in 0..cpu_count {
                if total_likes >= likes_per_cpu {
                    total_likes -= likes_per_cpu;
                } else {
                    likes_per_cpu = total_likes;
                }

                let pb = pb.clone();

                let handle = thread::spawn(move || {
                    let file = File::create(format!("./output/likes/{}.csv", i).as_str())?;

                    schema::Like::generate(
                        file,
                        likes_per_cpu,
                        pb,
                        schema::LikeContext::new(self.users, self.posts, self.comments),
                    )
                });

                handles.push(handle);
            }
        }

        for handle in handles {
            handle.join().unwrap()?;
        }

        Ok(())
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
