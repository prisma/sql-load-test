mod ser_date;
mod user;
mod post;

pub use user::*;
pub use post::*;

use chrono::{DateTime, Utc};
use derive_builder::Builder;
use serde_derive::Serialize;

#[derive(Debug, Builder, Serialize)]
#[serde(rename_all = "camelCase")]
#[builder(setter(into))]
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

#[derive(Debug, Builder, Serialize)]
#[serde(rename_all = "camelCase")]
#[builder(setter(into))]
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

#[derive(Debug, Builder, Serialize)]
#[serde(rename_all = "camelCase")]
#[builder(setter(into))]
pub struct Group {
    description: Option<String>,
    id: usize,
    topic: String,
    #[serde(with = "ser_date")]
    created_at: DateTime<Utc>,
    #[serde(with = "ser_date")]
    updated_at: DateTime<Utc>,
}
