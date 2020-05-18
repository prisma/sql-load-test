use super::ser_date;
use crate::Generator;
use chrono::{DateTime, Utc};
use csv::WriterBuilder;
use indicatif::ProgressBar;
use names::{Generator as NameGenerator, Name};
use rand::seq::SliceRandom;
use serde_derive::Serialize;
use std::io::Write;

#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Comment {
    content: String,
    id: usize,
    author: usize,
    post: usize,
    #[serde(with = "ser_date")]
    created_at: DateTime<Utc>,
    #[serde(with = "ser_date")]
    updated_at: DateTime<Utc>,
}

#[derive(Debug, Clone, Copy)]
pub struct CommentContext {
    max_author: usize,
    max_post: usize,
}

impl CommentContext {
    pub fn new(max_author: usize, max_post: usize) -> Self {
        Self {
            max_author,
            max_post,
        }
    }
}

impl Default for Comment {
    fn default() -> Self {
        let mut gen = NameGenerator::with_naming(Name::Plain);

        let content: Vec<String> = (1..10)
            .map(|_| gen.next().unwrap().replace('-', " ").to_string())
            .collect();

        Self {
            id: 0,
            author: 0,
            post: 0,
            created_at: Utc::now(),
            updated_at: Utc::now(),
            content: content.join(" "),
        }
    }
}

impl Generator for Comment {
    type Context = CommentContext;

    fn generate<W>(
        writer: W,
        count: usize,
        pb: ProgressBar,
        ctx: Self::Context,
    ) -> crate::Result<()>
    where
        W: Write,
    {
        let mut wtr = WriterBuilder::new()
            .has_headers(true)
            .delimiter(b';')
            .from_writer(writer);

        let mut rng = rand::thread_rng();
        let author_choices: Vec<usize> = (1..=ctx.max_author).collect();
        let post_choices: Vec<usize> = (1..=ctx.max_post).collect();

        for id in 1..=count {
            let mut comment = Comment::default();
            comment.id = id;
            comment.author = *author_choices.choose(&mut rng).unwrap();
            comment.post = *post_choices.choose(&mut rng).unwrap();

            wtr.serialize(comment)?;
            pb.inc(1);
        }

        wtr.flush()?;

        pb.finish_with_message("waiting...");

        Ok(())
    }
}
