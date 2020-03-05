use crate::Generator;
use csv::WriterBuilder;
use indicatif::ProgressBar;
use rand::seq::SliceRandom;
use serde_derive::Serialize;
use std::{collections::HashSet, io::Write};

#[derive(Default, Debug, Serialize, PartialEq, Eq, Hash)]
#[serde(rename_all = "UPPERCASE")]
pub struct Friendship {
    a: usize,
    b: usize,
}

#[derive(Default, Debug, Clone, Copy)]
pub struct FriendshipContext {
    max_user: usize,
}

impl FriendshipContext {
    pub fn new(max_user: usize) -> Self {
        Self { max_user }
    }
}

impl Generator for Friendship {
    type Context = FriendshipContext;

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

        let user_choices: Vec<usize> = (1..=ctx.max_user).collect();
        let mut taken: HashSet<Friendship> = HashSet::new();

        for _ in 1..=count {
            loop {
                let mut friendship = Friendship::default();
                friendship.a = *user_choices.choose(&mut rng).unwrap();
                friendship.b = *user_choices.choose(&mut rng).unwrap();

                if !taken.contains(&friendship) {
                    wtr.serialize(&friendship)?;
                    taken.insert(friendship);

                    pb.inc(1);

                    break;
                }
            }
        }

        wtr.flush()?;

        pb.finish_with_message("waiting...");

        Ok(())
    }
}
