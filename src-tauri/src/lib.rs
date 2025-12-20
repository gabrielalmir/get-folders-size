use std::path::Path;
use walkdir::WalkDir;
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Debug)]
pub struct FolderInfo {
    path: String,
    size_bytes: u64,
    size_gb: f64,
    status: String,
}

#[tauri::command]
async fn get_folder_size(path: String) -> Result<FolderInfo, String> {
    let folder_path = Path::new(&path);
    if !folder_path.exists() {
        return Ok(FolderInfo {
            path: path.clone(),
            size_bytes: 0,
            size_gb: 0.0,
            status: "Not Found".to_string(),
        });
    }

    let path_clone = path.clone();

    let total_size = match tauri::async_runtime::spawn_blocking(move || {
        let mut size: u64 = 0;
        for entry in WalkDir::new(&path_clone).into_iter().filter_map(|e| e.ok()) {
            if let Ok(metadata) = entry.metadata() {
                if metadata.is_file() {
                    size += metadata.len();
                }
            }
        }
        size
    }).await {
        Ok(s) => s,
        Err(e) => return Err(format!("Task failed: {}", e)),
    };

    let size_gb = total_size as f64 / 1_073_741_824.0;

    Ok(FolderInfo {
        path: path.clone(),
        size_bytes: total_size,
        size_gb,
        status: "Success".to_string(),
    })
}

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    tauri::Builder::default()
        .setup(|app| {
            if cfg!(debug_assertions) {
                app.handle().plugin(
                    tauri_plugin_log::Builder::default()
                        .level(log::LevelFilter::Info)
                        .build(),
                )?;
            }
            Ok(())
        })
        .invoke_handler(tauri::generate_handler![get_folder_size])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
