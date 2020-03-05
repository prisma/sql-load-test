use super::ser_date;
use crate::Generator;
use chrono::{DateTime, Utc};
use csv::WriterBuilder;
use indicatif::ProgressBar;
use names::{Generator as NameGenerator, Name};
use rand::{distributions::Alphanumeric, Rng};
use serde_derive::Serialize;
use std::io::Write;

#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct User {
    age: u8,
    #[serde(with = "ser_date")]
    created_at: DateTime<Utc>,
    email: String,
    first_name: String,
    id: usize,
    unique: usize,
    last_name: String,
    password: String,
    #[serde(with = "ser_date")]
    updated_at: DateTime<Utc>,
}

#[derive(Debug, Clone, Copy)]
pub struct UserContext;

impl Default for User {
    fn default() -> Self {
        let mut gen = NameGenerator::with_naming(Name::Plain);
        let mut rng = rand::thread_rng();

        let mut name: Vec<String> = gen
            .next()
            .unwrap()
            .split('-')
            .map(|s| s.to_string())
            .collect();

        let first_name = name.pop().unwrap();
        let last_name = name.pop().unwrap();
        let password = rng.sample_iter(&Alphanumeric).take(32).collect();
        let age: u8 = rng.gen();

        Self {
            id: 0,
            unique: 0,
            email: format!("{}.{}@prisma.io", first_name, last_name),
            created_at: Utc::now(),
            updated_at: Utc::now(),
            age,
            first_name: crate::namify(first_name),
            last_name: crate::namify(last_name),
            password,
        }
    }
}

impl Generator for User {
    type Context = UserContext;

    fn generate<W>(writer: W, count: usize, pb: ProgressBar, _: Self::Context) -> crate::Result<()>
    where
        W: Write,
    {
        let mut wtr = WriterBuilder::new()
            .has_headers(true)
            .delimiter(b';')
            .from_writer(writer);

        for id in 1..=count {
            let mut user = User::default();
            user.id = id;
            user.unique = count - id;

            wtr.serialize(user)?;
            pb.inc(1);
        }

        wtr.flush()?;

        pb.finish_with_message("waiting...");

        Ok(())
    }
}
