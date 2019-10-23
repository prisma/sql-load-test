use serde::ser;
use chrono::{DateTime, Utc};

pub fn serialize<S>(data: &DateTime<Utc>, serializer: S) -> Result<S::Ok, S::Error>
where
    S: ser::Serializer,
{
    let date = format!("{}", data.format("%Y-%m-%d %H:%M:%S"));
    serializer.serialize_str(&date)
}
