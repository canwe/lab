// GitHub-like ZIP Repository Configuration
const CONFIG = {
    // Repository information
    repoOwner: "canwe",
    repoName: "slackirx",
    repoDescription: "A Slack <-> IRC relay",

    // ZIP file URL (with CORS proxy)
    zipUrl: './slackirx.zip',

    // Repository stats
    stats: {
        watches: 42,
        stars: 125,
        forks: 31
    },

    // Features
    showReadme: true,
    enableFilePreview: true,
    enableSyntaxHighlighting: true,
    showFileIcons: true,

    // UI Settings
    maxFileSizeToPreview: 1024 * 1024, // 1MB

    // File extension to language mapping
    fileExtensions: {
        '.js': 'javascript',
        '.jsx': 'jsx',
        '.ts': 'typescript',
        '.tsx': 'tsx',
        '.py': 'python',
        '.rb': 'ruby',
        '.java': 'java',
        '.c': 'c',
        '.cpp': 'cpp',
        '.cs': 'csharp',
        '.go': 'go',
        '.rs': 'rust',
        '.php': 'php',
        '.html': 'html',
        '.htm': 'html',
        '.css': 'css',
        '.scss': 'scss',
        '.less': 'less',
        '.json': 'json',
        '.xml': 'xml',
        '.yml': 'yaml',
        '.yaml': 'yaml',
        '.md': 'markdown',
        '.sh': 'bash',
        '.bash': 'bash',
        '.sql': 'sql',
        '.txt': 'text'
    }
};

// Helper functions
CONFIG.getLanguageFromExtension = function(filename) {
    const ext = filename.substring(filename.lastIndexOf('.')).toLowerCase();
    return this.fileExtensions[ext] || 'text';
};

CONFIG.formatFileSize = function(bytes) {
    if (bytes === 0) return '0 Bytes';
    const k = 1024;
    const sizes = ['Bytes', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(1)) + ' ' + sizes[i];
};