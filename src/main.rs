mod schema;

use chrono::Utc;
use csv::WriterBuilder;
use schema::UserBuilder;

fn main() {
    let mut wtr = WriterBuilder::new()
        .has_headers(true)
        .delimiter(b';')
        .from_path("foo.csv")
        .unwrap();

    let user = UserBuilder::default()
        .id(1usize)
        .age(35)
        .first_name("Musti")
        .last_name("Naukio")
        .password("pawpawmeowmeow")
        .email("musti@nauk.io")
        .created_at(Utc::now())
        .updated_at(Utc::now())
        .build()
        .unwrap();

    wtr.serialize(user).unwrap();
    wtr.flush().unwrap();
}
