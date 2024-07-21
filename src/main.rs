use std::time::Instant;

mod utils;

fn main() {
    let start_time = Instant::now();
    let locations = utils::parse_locations("locations.json");

    if let Some(localhost) = locations.localhost {
        utils::get_folders_size(localhost);
    } else {
        eprintln!("Nenhuma pasta foi encontrada.");
    }

    let elapsed_time = start_time.elapsed();
    println!("=============================");
    println!("Tempo Total: {:.2?}", elapsed_time);
    println!("=============================");
}
