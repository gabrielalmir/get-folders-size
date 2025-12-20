import { useState } from 'react';
import { invoke } from '@tauri-apps/api/core';

interface FolderInfo {
  path: string;
  size_bytes: number;
  size_gb: number;
  status: string;
}

function App() {
  const [folderPath, setFolderPath] = useState('');
  const [folderInfo, setFolderInfo] = useState<FolderInfo | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function handleCheckSize() {
    if (!folderPath) return;
    
    setLoading(true);
    setError(null);
    setFolderInfo(null);

    try {
      const info = await invoke<FolderInfo>('get_folder_size', { path: folderPath });
      setFolderInfo(info);
    } catch (err) {
      setError(String(err));
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="min-h-screen bg-gray-900 text-white flex flex-col items-center justify-center p-4">
      <div className="w-full max-w-2xl bg-gray-800 rounded-xl shadow-2xl p-8 border border-gray-700">
        <h1 className="text-4xl font-bold mb-8 text-center bg-gradient-to-r from-blue-400 to-purple-500 bg-clip-text text-transparent">
          Folder Size Analyzer
        </h1>
        
        <div className="flex gap-4 mb-8">
          <input
            type="text"
            value={folderPath}
            onChange={(e) => setFolderPath(e.target.value)}
            placeholder="Enter folder path (e.g., /home/user/documents)"
            className="flex-1 px-4 py-3 rounded-lg bg-gray-700 border border-gray-600 focus:outline-none focus:border-blue-500 transition-colors"
          />
          <button
            onClick={handleCheckSize}
            disabled={loading || !folderPath}
            className={`px-6 py-3 rounded-lg font-semibold transition-all duration-200 
              ${loading || !folderPath 
                ? 'bg-gray-600 cursor-not-allowed opacity-50' 
                : 'bg-blue-600 hover:bg-blue-500 active:bg-blue-700 hover:shadow-lg hover:shadow-blue-500/20'
              }`}
          >
            {loading ? 'Analyzing...' : 'Analyze'}
          </button>
        </div>

        {error && (
          <div className="bg-red-900/50 border border-red-500 text-red-200 px-4 py-3 rounded-lg mb-6">
            <p className="font-semibold">Error:</p>
            <p>{error}</p>
          </div>
        )}

        {folderInfo && (
          <div className="bg-gray-700/50 rounded-lg p-6 animate-fade-in">
            <div className="grid grid-cols-2 gap-4">
              <div className="col-span-2">
                <p className="text-gray-400 text-sm">Path</p>
                <p className="font-mono text-lg break-all">{folderInfo.path}</p>
              </div>
              
              <div>
                <p className="text-gray-400 text-sm">Status</p>
                <p className={`font-semibold ${
                  folderInfo.status === 'Success' ? 'text-green-400' : 'text-yellow-400'
                }`}>
                  {folderInfo.status}
                </p>
              </div>

              <div>
                <p className="text-gray-400 text-sm">Size (GB)</p>
                <p className="text-3xl font-bold text-blue-400">
                  {folderInfo.size_gb.toFixed(2)} <span className="text-lg text-gray-500">GB</span>
                </p>
              </div>

              <div className="col-span-2">
                <p className="text-gray-400 text-sm">Raw Size (Bytes)</p>
                <p className="font-mono text-gray-300">
                  {folderInfo.size_bytes.toLocaleString()} bytes
                </p>
              </div>
            </div>
          </div>
        )}
      </div>
      
      <p className="mt-8 text-gray-500 text-sm">
        Built with Tauri + React + Tailwind
      </p>
    </div>
  );
}

export default App;
