use super::ser_date;
use crate::Generator;
use chrono::{DateTime, Utc};
use csv::WriterBuilder;
use rand::seq::SliceRandom;
use serde_derive::Serialize;
use std::io::Write;
use indicatif::ProgressBar;

#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Like {
    id: usize,
    comment: Option<usize>,
    post: Option<usize>,
    user: Option<usize>,
    #[serde(with = "ser_date")]
    created_at: DateTime<Utc>,
    #[serde(with = "ser_date")]
    updated_at: DateTime<Utc>,
}

#[derive(Debug, Clone, Copy)]
pub struct LikeContext {
    max_user: usize,
    max_post: usize,
    max_comment: usize,
}

impl LikeContext {
    pub fn new(max_user: usize, max_post: usize, max_comment: usize) -> Self {
        Self {
            max_user,
            max_post,
            max_comment,
        }
    }
}

#[derive(Debug, Clone, Copy)]
enum LikeChoice {
    User,
    Post,
    Comment
}

impl Default for Like {
    fn default() -> Self {
        Self {
            id: 0,
            user: None,
            comment: None,
            post: None,
            created_at: Utc::now(),
            updated_at: Utc::now(),
        }
    }
}

impl Generator for Like {
    type Context = LikeContext;

    fn generate<W>(writer: W, count: usize, pb: ProgressBar, ctx: Self::Context) -> crate::Result<()>
    where
        W: Write,
    {
        let mut wtr = WriterBuilder::new()
            .has_headers(true)
            .delimiter(b';')
            .from_writer(writer);

        let mut rng = rand::thread_rng();
        let user_choices: Vec<usize> = (1..=ctx.max_user).collect();
        let post_choices: Vec<usize> = (1..=ctx.max_post).collect();
        let comment_choices: Vec<usize> = (1..=ctx.max_comment).collect();

        let like_choices = [LikeChoice::User, LikeChoice::Post, LikeChoice::Comment];

        for id in 1..=count {
            let mut like = Like::default();
            like.id = id;

            match *like_choices.choose(&mut rng).unwrap() {
                LikeChoice::User => like.user = Some(*user_choices.choose(&mut rng).unwrap()),
                LikeChoice::Post => like.post = Some(*post_choices.choose(&mut rng).unwrap()),
                LikeChoice::Comment => like.comment = Some(*comment_choices.choose(&mut rng).unwrap()),
            }

            wtr.serialize(like)?;
            pb.inc(1);
        }

        wtr.flush()?;

        pb.finish_with_message("waiting...");

        Ok(())
    }
}
