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
pub struct Post {
    content: String,
    #[serde(with = "ser_date")]
    created_at: DateTime<Utc>,
    id: usize,
    #[serde(with = "ser_date")]
    updated_at: DateTime<Utc>,
    author: usize,
}

#[derive(Debug, Clone, Copy)]
pub struct PostContext {
    max_author: usize,
}

impl PostContext {
    pub fn new(max_author: usize) -> Self {
        Self { max_author }
    }
}

impl Default for Post {
    fn default() -> Self {
        let mut gen = NameGenerator::with_naming(Name::Plain);

        let content: Vec<String> = (1..50)
            .map(|_| gen.next().unwrap().replace('-', " ").to_string())
            .collect();

        Self {
            id: 0,
            author: 0,
            created_at: Utc::now(),
            updated_at: Utc::now(),
            content: content.join(" "),
        }
    }
}

impl Generator for Post {
    type Context = PostContext;

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

        for id in 1..=count {
            let mut post = Post::default();
            post.id = id;
            post.author = *author_choices.choose(&mut rng).unwrap();

            wtr.serialize(post)?;
            pb.inc(1);
        }

        wtr.flush()?;

        pb.finish_with_message("waiting...");

        Ok(())
    }
}
