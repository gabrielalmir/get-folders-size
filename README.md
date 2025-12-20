# 👽 Get Folders Size

A simple, fast, and beautiful desktop application to calculate the size of folders on your computer. Built with Tauri, React, TypeScript, and Tailwind CSS. Rewritten version of the original PowerShell script.

## Features

- 🚀 **Blazing Fast**: Uses Rust for efficient file system traversal.
- 💅 **Simple UI**: Clean and beautiful interface built with React and Tailwind CSS.
- 📊 **Detailed Stats**: View folder size in both GB and exact bytes.
- 🛡️ **Safe**: Runs locally on your machine with no data collection.
- ⚡ **Responsive**: Non-blocking folder analysis keeps the UI smooth.

## Tech Stack

- **Core**: [Tauri](https://tauri.app/) (Rust)
- **Frontend**: [React](https://react.dev/)
- **Language**: [TypeScript](https://www.typescriptlang.org/)
- **Styling**: [Tailwind CSS v4](https://tailwindcss.com/)
- **Bundler**: [Vite](https://vitejs.dev/)

## Prerequisites

Before running the application, ensure you have the following installed:

- **Node.js** (v22 or newer)
- **Rust** (latest stable)
- **System Dependencies** (Linux only):
  ```bash
  sudo apt-get update
  sudo apt-get install -y pkg-config libglib2.0-dev libgtk-3-dev libsoup-3.0-dev libwebkit2gtk-4.1-dev
  ```

## Getting Started

1.  **Clone the repository**
    ```bash
    git clone https://github.com/yourusername/get-folders-size.git
    cd get-folders-size
    ```

2.  **Install dependencies**
    ```bash
    npm install
    ```

3.  **Run in development mode**
    ```bash
    npm run tauri dev
    ```

4.  **Build for production**
    ```bash
    npm run tauri build
    ```
    The executable will be located in `src-tauri/target/release/bundle`.

## Usage

1.  Launch the application.
2.  Enter the absolute path of the folder you want to analyze (e.g., `/home/user/Documents`).
3.  Click **Analyze**.
4.  View the size calculation results instantly.

## License

This project is licensed under the MIT License.
