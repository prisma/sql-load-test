mod ser_date;
mod user;
mod post;
mod comment;
mod like;

pub use user::*;
pub use post::*;
pub use comment::*;
pub use like::*;

use chrono::{DateTime, Utc};
use derive_builder::Builder;
use serde_derive::Serialize;

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
