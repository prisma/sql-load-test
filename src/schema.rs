mod ser_date;

use chrono::{DateTime, Utc};
use serde_derive::Serialize;
use derive_builder::Builder;

#[derive(Debug, Builder, Serialize)]
#[serde(rename_all = "camelCase")]
#[builder(setter(into))]
pub struct User {
    age: u8,
    #[serde(with = "ser_date")]
    created_at: DateTime<Utc>,
    email: String,
    first_name: String,
    id: usize,
    last_name: String,
    password: String,
    #[serde(with = "ser_date")]
    updated_at: DateTime<Utc>,
}

#[derive(Debug, Builder, Serialize)]
#[serde(rename_all = "camelCase")]
#[builder(setter(into))]
pub struct Post {
    content: String,
    #[serde(with = "ser_date")]
    created_at: DateTime<Utc>,
    id: usize,
    #[serde(with = "ser_date")]
    updated_at: DateTime<Utc>,
    author: usize,
}

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
