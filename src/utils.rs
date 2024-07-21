use std::{fs, path::Path};

use serde::{Deserialize, Serialize};
use walkdir::WalkDir;

#[derive(Serialize, Deserialize, Debug)]
pub struct Locations {
    pub localhost: Option<Vec<String>>
}

pub fn parse_locations(file_path: &str) -> Locations {
    let file_content = fs::read_to_string(file_path).expect("Falha ao ler o arquivo JSON.");
    let locations: Locations = serde_json::from_str(&file_content).expect("Falha ao parsear o arquivo JSON.");
    locations
}

pub fn get_folders_size(folders: Vec<String>) {
    for folder in folders {
        println!("Iniciando o processo em {}...", folder);
        let path = Path::new(&folder);
        if path.exists() {
            let mut total_size = 0;
            for entry in WalkDir::new(&folder).into_iter().filter_map(|e| e.ok()) {
                if entry.metadata().unwrap().is_file() {
                    total_size += entry.metadata().unwrap().len();
                }
            }
            println!("Pasta: {}, Tamanho: {:.2} GB", folder, total_size as f64 / 1_073_741_824.0);
        } else {
            println!("Pasta {} não encontrada.", folder);
        }
    }
    println!("Processo concluído.");
}
