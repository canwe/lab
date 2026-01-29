/**
 * GitHub ZIP Repository Viewer
 * With browser history and URL routing support
 */

class GitHubZipViewer {
    constructor(config) {
        this.config = config;
        this.zip = null;
        this.fileTree = {};
        this.currentPath = '';
        this.history = [];
        this.historyIndex = -1;
        this.currentFile = null;
        this.fileCount = 0;
        this.folderCount = 0;
        this.totalSize = 0;

        this.initMarked();

        // Parse initial URL on startup
        this.parseUrlHash();

        // Initialize when DOM is ready
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', () => this.init());
        } else {
            this.init();
        }
    }

    initMarked() {
        if (typeof marked !== 'undefined') {
            marked.setOptions({
                gfm: true,
                breaks: true,
                pedantic: false,
                sanitize: false,
                smartLists: true,
                smartypants: true,
                xhtml: false
            });
        }
    }

    init() {
        this.cacheElements();
        this.bindEvents();
        this.updateUIFromConfig();
        this.loadRepository();

        // Listen for browser back/forward buttons
        window.addEventListener('popstate', (e) => {
            this.handleBrowserNavigation(e);
        });
    }

    // Parse URL hash to get initial path
    parseUrlHash() {
        const hash = window.location.hash.substring(1);
        if (hash) {
            try {
                const state = JSON.parse(decodeURIComponent(hash));
                if (state.path !== undefined) {
                    this.currentPath = state.path;
                }
                if (state.file !== undefined) {
                    this.currentFile = state.file;
                }
                console.log('Parsed URL hash:', state);
            } catch (e) {
                console.log('Could not parse URL hash, using default path');
            }
        }
    }

    // Update URL in browser address bar
    updateBrowserUrl(path, file = null) {
        const state = {
            path: path || '',
            file: file
        };

        const hash = encodeURIComponent(JSON.stringify(state));
        const url = window.location.pathname + '#' + hash;

        // Update URL without reloading page
        history.pushState(state, '', url);

        // Update page title
        const titlePath = path ? `/${path}` : '';
        document.title = `canwe/slackirx${titlePath} - GitHub`;

        console.log('Updated browser URL:', url);
    }

    // Handle browser back/forward navigation
    handleBrowserNavigation(event) {
        console.log('Browser navigation:', event.state);

        if (event.state) {
            const { path, file } = event.state;

            // Update current path
            this.currentPath = path || '';

            // Update history tracking
            this.history = this.history.slice(0, this.historyIndex + 1);
            this.history.push(this.currentPath);
            this.historyIndex = this.history.length - 1;

            // Update UI
            this.updateNavigationButtons();
            this.updateBreadcrumb(this.currentPath);
            this.renderFileList(this.currentPath);

            // Load README for current directory
            if (this.config.showReadme) {
                this.loadReadmeForCurrentDirectory();
            }

            // If there was a file in state, open it
            if (file && file.path) {
                this.viewFile(file.path, file.name);
            }
        }
    }

    cacheElements() {
        console.log('Caching DOM elements...');

        this.elements = {
            // Loading
            loadingOverlay: document.getElementById('loadingOverlay'),

            // Navigation
            navBack: document.getElementById('navBack'),
            navForward: document.getElementById('navForward'),
            refreshBtn: document.getElementById('refreshBtn'),
            breadcrumbPath: document.querySelector('#breadcrumbPath'),

            // File explorer
            fileExplorer: document.getElementById('fileExplorer'),
            fileList: document.getElementById('fileList'),

            // File viewer
            fileViewer: document.getElementById('fileViewer'),
            fileViewerTitle: document.getElementById('fileViewerTitle'),
            fileContent: document.getElementById('fileContent'),
            backToExplorer: document.getElementById('backToExplorer'),
            rawFileBtn: document.getElementById('rawFileBtn'),
            downloadFileBtn: document.getElementById('downloadFileBtn'),

            // README - будет скрыта по умолчанию
            readmeSection: document.getElementById('readmeSection'),
            readmeContent: document.getElementById('readmeContent'),

            // Stats
            watchCount: document.getElementById('watchCount'),
            starCount: document.getElementById('starCount'),
            forkCount: document.getElementById('forkCount'),
            fileStats: document.getElementById('fileStats'),
            lastUpdated: document.getElementById('lastUpdated'),

            // Code dropdown
            downloadBtn: document.getElementById('downloadBtn'),
            codeDropdownToggle: document.getElementById('codeDropdownToggle'),
            codeDropdown: document.getElementById('codeDropdown'),
            downloadZipLink: document.getElementById('downloadZipLink'),

            // Video showcase
            showcaseVideoBtn: document.getElementById('showcaseVideoBtn'),
            videoModal: document.getElementById('videoModal'),
            showcaseVideoPlayer: document.getElementById('showcaseVideoPlayer'),
            videoSource: document.getElementById('videoSource'),
            closeVideoModal: document.getElementById('closeVideoModal'),
            playVideoBtn: document.getElementById('playVideoBtn'),
            pauseVideoBtn: document.getElementById('pauseVideoBtn'),
            downloadVideoBtn: document.getElementById('downloadVideoBtn'),
        };

        // Breadcrumb items
        const breadcrumbItems = document.querySelectorAll('.breadcrumb-item');
        if (breadcrumbItems.length > 0) {
            this.elements.breadcrumbRoot = breadcrumbItems[0];
        }
    }

    bindEvents() {
        console.log('Binding events...');

        // Video showcase button
        if (this.elements.showcaseVideoBtn) {
            this.elements.showcaseVideoBtn.addEventListener('click', (e) => {
                e.preventDefault();
                this.openShowcaseVideo();
            });
        }

        // Video modal controls
        if (this.elements.closeVideoModal) {
            this.elements.closeVideoModal.addEventListener('click', () => {
                this.closeShowcaseVideo();
            });
        }

        if (this.elements.playVideoBtn) {
            this.elements.playVideoBtn.addEventListener('click', () => {
                if (this.elements.showcaseVideoPlayer) {
                    this.elements.showcaseVideoPlayer.play();
                }
            });
        }

        if (this.elements.pauseVideoBtn) {
            this.elements.pauseVideoBtn.addEventListener('click', () => {
                if (this.elements.showcaseVideoPlayer) {
                    this.elements.showcaseVideoPlayer.pause();
                }
            });
        }

        if (this.elements.downloadVideoBtn) {
            this.elements.downloadVideoBtn.addEventListener('click', () => {
                this.downloadShowcaseVideo();
            });
        }

        // Close modal when clicking outside
        if (this.elements.videoModal) {
            this.elements.videoModal.addEventListener('click', (e) => {
                if (e.target === this.elements.videoModal) {
                    this.closeShowcaseVideo();
                }
            });
        }

        // Close modal with Escape key
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && this.elements.videoModal.style.display === 'flex') {
                this.closeShowcaseVideo();
            }
        });

        // Navigation
        if (this.elements.navBack) {
            this.elements.navBack.addEventListener('click', () => this.navigateBack());
        }
        if (this.elements.navForward) {
            this.elements.navForward.addEventListener('click', () => this.navigateForward());
        }
        if (this.elements.refreshBtn) {
            this.elements.refreshBtn.addEventListener('click', () => this.refresh());
        }
        if (this.elements.breadcrumbRoot) {
            this.elements.breadcrumbRoot.addEventListener('click', (e) => {
                e.preventDefault();
                this.navigateTo('');
            });
        }

        // File viewer
        if (this.elements.backToExplorer) {
            this.elements.backToExplorer.addEventListener('click', () => this.showFileExplorer());
        }
        if (this.elements.rawFileBtn) {
            this.elements.rawFileBtn.addEventListener('click', () => this.viewRawFile());
        }
        if (this.elements.downloadFileBtn) {
            this.elements.downloadFileBtn.addEventListener('click', () => this.downloadCurrentFile());
        }

        // Code dropdown
        if (this.elements.downloadBtn) {
            this.elements.downloadBtn.addEventListener('click', (e) => {
                e.preventDefault();
                this.toggleCodeDropdown(e.target);
            });
        }

        if (this.elements.codeDropdownToggle) {
            this.elements.codeDropdownToggle.addEventListener('click', (e) => {
                e.preventDefault();
                e.stopPropagation();
                this.toggleCodeDropdown(this.elements.downloadBtn);
            });
        }

        if (this.elements.downloadZipLink) {
            this.elements.downloadZipLink.addEventListener('click', (e) => {
                e.preventDefault();
                this.downloadZip();
            });
        }

        // Close dropdown when clicking outside
        document.addEventListener('click', (e) => {
            if (!e.target.closest('.BtnGroup') && this.elements.codeDropdown) {
                this.elements.codeDropdown.style.display = 'none';
            }
        });

        // Handle Ctrl+Click and Middle-click for opening in new tab
        document.addEventListener('click', (e) => {
            // Check if click is on a file or directory link
            const link = e.target.closest('a[data-path]');
            if (link && (e.ctrlKey || e.metaKey || e.button === 1)) {
                e.preventDefault();
                const path = link.getAttribute('data-path');
                const type = link.getAttribute('data-type');
                const name = link.getAttribute('data-name');

                // Open in new tab/window
                const state = {
                    path: type === 'directory' ? path : this.getParentPath(path),
                    file: type === 'file' ? { path, name } : null
                };

                const hash = encodeURIComponent(JSON.stringify(state));
                const newUrl = window.location.origin + window.location.pathname + '#' + hash;

                window.open(newUrl, '_blank');
            }
        });
    }

    updateUIFromConfig() {
        console.log('Updating UI from config...');

        try {
            // Update stats
            if (this.elements.watchCount) {
                this.elements.watchCount.textContent = this.config.stats.watches;
            }
            if (this.elements.starCount) {
                this.elements.starCount.textContent = this.config.stats.stars;
            }
            if (this.elements.forkCount) {
                this.elements.forkCount.textContent = this.config.stats.forks;
            }

            // Update file stats
            if (this.elements.fileStats) {
                this.elements.fileStats.textContent = 'Loading...';
            }
            if (this.elements.lastUpdated) {
                this.elements.lastUpdated.textContent = 'just now';
            }

            // Update download link
            if (this.elements.downloadZipLink) {
                this.elements.downloadZipLink.href = this.config.zipUrl;
            }

            console.log('UI updated successfully');
        } catch (error) {
            console.error('Error updating UI:', error);
        }
    }

    toggleCodeDropdown(button) {
        if (!this.elements.codeDropdown) return;

        const dropdown = this.elements.codeDropdown;
        const rect = button.getBoundingClientRect();

        dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
        dropdown.style.top = (rect.bottom + window.scrollY) + 'px';
        dropdown.style.left = (rect.left + window.scrollX) + 'px';
    }

    async loadRepository() {
        try {
            this.showLoading(true);
            await this.loadZipFile();
            this.buildFileTree();
            this.updateStats();

            // Navigate to initial path (from URL or root)
            this.navigateTo(this.currentPath || '');

            this.showLoading(false);

        } catch (error) {
            console.error('Error loading repository:', error);
            this.showError(`Failed to load repository: ${error.message}`);
            this.showLoading(false);
        }
    }

    async loadZipFile() {
        console.log('Loading ZIP file from:', this.config.zipUrl);

        try {
            const response = await fetch(this.config.zipUrl);

            if (!response.ok) {
                throw new Error(`Failed to fetch ZIP: ${response.status} ${response.statusText}`);
            }

            const arrayBuffer = await response.arrayBuffer();

            if (arrayBuffer.byteLength === 0) {
                throw new Error('ZIP file is empty');
            }

            console.log('ZIP file loaded, size:', arrayBuffer.byteLength, 'bytes');
            this.zip = await JSZip.loadAsync(arrayBuffer);
            console.log('ZIP parsed successfully, files:', Object.keys(this.zip.files).length);

        } catch (error) {
            console.error('ZIP loading error:', error);
            if (error.message.includes('CORS')) {
                throw new Error('CORS error. Try using a CORS proxy in config.js');
            }
            throw error;
        }
    }

    buildFileTree() {
        console.log('Building file tree...');

        this.fileTree = {};
        this.fileCount = 0;
        this.folderCount = 0;
        this.totalSize = 0;

        Object.keys(this.zip.files).forEach(filePath => {
            const file = this.zip.files[filePath];

            // Skip macOS metadata
            if (filePath.includes('__MACOSX/') || filePath.endsWith('.DS_Store')) {
                return;
            }

            const parts = filePath.split('/').filter(p => p !== '');
            let currentLevel = this.fileTree;

            for (let i = 0; i < parts.length; i++) {
                const part = parts[i];

                if (i === parts.length - 1 && !file.dir) {
                    // File
                    currentLevel[part] = {
                        type: 'file',
                        path: filePath,
                        name: part,
                        size: file._data.uncompressedSize || 0,
                        isDirectory: false
                    };
                    this.fileCount++;
                    this.totalSize += file._data.uncompressedSize || 0;

                } else {
                    // Directory
                    if (!currentLevel[part]) {
                        currentLevel[part] = {
                            type: 'directory',
                            name: part,
                            path: parts.slice(0, i + 1).join('/'),
                            children: {},
                            isDirectory: true
                        };
                        if (i < parts.length - 1 || file.dir) {
                            this.folderCount++;
                        }
                    }
                    currentLevel = currentLevel[part].children;
                }
            }
        });

        console.log('File tree built:', {
            files: this.fileCount,
            folders: this.folderCount,
            totalSize: this.totalSize
        });
    }

    updateStats() {
        if (this.elements.fileStats) {
            this.elements.fileStats.textContent = `${this.fileCount} file${this.fileCount !== 1 ? 's' : ''}`;
        }
    }

    navigateTo(path, updateHistory = true) {
        path = path || '';
        console.log('Navigating to:', path, 'updateHistory:', updateHistory);

        // Update internal history
        if (this.history[this.historyIndex] !== path) {
            this.history = this.history.slice(0, this.historyIndex + 1);
            this.history.push(path);
            this.historyIndex++;
        }

        this.currentPath = path;
        this.updateNavigationButtons();
        this.updateBreadcrumb(path);
        this.renderFileList(path);

        // Update browser URL
        if (updateHistory) {
            this.updateBrowserUrl(path);
        }

        // Load README for current directory
        if (this.config.showReadme) {
            this.loadReadmeForCurrentDirectory();
        }
    }

    navigateBack() {
        if (this.historyIndex > 0) {
            this.historyIndex--;
            const path = this.history[this.historyIndex];
            this.currentPath = path;
            this.updateNavigationButtons();
            this.updateBreadcrumb(path);
            this.renderFileList(path);

            // Update browser URL
            this.updateBrowserUrl(path);

            // Load README for current directory
            if (this.config.showReadme) {
                this.loadReadmeForCurrentDirectory();
            }
        }
    }

    navigateForward() {
        if (this.historyIndex < this.history.length - 1) {
            this.historyIndex++;
            const path = this.history[this.historyIndex];
            this.currentPath = path;
            this.updateNavigationButtons();
            this.updateBreadcrumb(path);
            this.renderFileList(path);

            // Update browser URL
            this.updateBrowserUrl(path);

            // Load README for current directory
            if (this.config.showReadme) {
                this.loadReadmeForCurrentDirectory();
            }
        }
    }

    updateNavigationButtons() {
        if (this.elements.navBack) {
            this.elements.navBack.disabled = this.historyIndex <= 0;
        }
        if (this.elements.navForward) {
            this.elements.navForward.disabled = this.historyIndex >= this.history.length - 1;
        }
    }

    updateBreadcrumb(path) {
        if (!this.elements.breadcrumbPath) return;

        const parts = path ? path.split('/').filter(p => p) : [];
        let html = '';

        parts.forEach((part, index) => {
            const partialPath = parts.slice(0, index + 1).join('/');
            html += `
                <span class="breadcrumb-separator">/</span>
                <a href="#" data-path="${partialPath}" class="breadcrumb-item">
                    ${part}
                </a>
            `;
        });

        this.elements.breadcrumbPath.innerHTML = html;

        // Add click handlers with URL support
        this.elements.breadcrumbPath.querySelectorAll('a').forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                const targetPath = link.getAttribute('data-path');
                this.navigateTo(targetPath);
            });

            // Set href for context menu "Copy link address"
            const state = { path: link.getAttribute('data-path') };
            const hash = encodeURIComponent(JSON.stringify(state));
            link.href = '#' + hash;
        });
    }

    renderFileList(path) {
        if (!this.elements.fileExplorer || !this.elements.fileList) return;

        this.elements.fileExplorer.style.display = 'block';
        if (this.elements.fileViewer) {
            this.elements.fileViewer.style.display = 'none';
        }

        const contents = this.getContentsAtPath(path);

        if (contents.length === 0) {
            this.elements.fileList.innerHTML = `
                <div class="Box-row">
                    <div class="col-12 text-center py-6">
                        <p class="color-fg-muted mb-0">This directory is empty</p>
                    </div>
                </div>
            `;
            return;
        }

        // Sort: directories first, then files
        const sortedContents = [...contents].sort((a, b) => {
            if (a.isDirectory && !b.isDirectory) return -1;
            if (!a.isDirectory && b.isDirectory) return 1;
            return a.name.localeCompare(b.name);
        });

        let html = '';

        // Add parent directory if not at root
        if (path !== '') {
            const parentPath = this.getParentPath(path);
            const parentState = { path: parentPath };
            const parentHash = encodeURIComponent(JSON.stringify(parentState));

            html += `
                <div class="Box-row d-flex flex-items-center">
                    <div class="mr-2">
                        📁
                    </div>
                    <div class="flex-auto">
                        <a href="#${parentHash}" data-path="${parentPath}" data-type="directory" class="d-flex flex-items-center">
                            <span class="color-fg-muted">..</span>
                        </a>
                    </div>
                </div>
            `;
        }

        // Render contents
        sortedContents.forEach(item => {
            const icon = item.isDirectory ? '📁' : '📄';
            const size = item.size ? this.config.formatFileSize(item.size) : '';

            // Create URL for this item
            const itemState = {
                path: item.isDirectory ? item.path : this.getParentPath(item.path),
                file: !item.isDirectory ? { path: item.path, name: item.name } : null
            };
            const itemHash = encodeURIComponent(JSON.stringify(itemState));

            html += `
                <div class="Box-row d-flex flex-items-center">
                    <div class="mr-2">
                        ${icon}
                    </div>
                    <div class="flex-auto">
                        <a href="#${itemHash}"
                           data-path="${item.isDirectory ? item.path : item.path}"
                           data-type="${item.isDirectory ? 'directory' : 'file'}"
                           data-name="${item.name}"
                           class="d-flex flex-items-center">
                            <span class="color-fg-default">${item.name}</span>
                        </a>
                    </div>
                    ${item.size ? `<div class="color-fg-muted text-right">${size}</div>` : ''}
                </div>
            `;
        });

        this.elements.fileList.innerHTML = html;

        // Add click handlers
        this.elements.fileList.querySelectorAll('a').forEach(link => {
            link.addEventListener('click', async (e) => {
                e.preventDefault();
                const targetPath = link.getAttribute('data-path');
                const type = link.getAttribute('data-type');
                const name = link.getAttribute('data-name');

                if (type === 'directory') {
                    this.navigateTo(targetPath);
                } else {
                    await this.viewFile(targetPath, name);
                }
            });
        });
    }

    getContentsAtPath(path) {
        let currentLevel = this.fileTree;
        const parts = path ? path.split('/').filter(p => p) : [];

        // Navigate to directory
        for (const part of parts) {
            if (currentLevel[part] && currentLevel[part].isDirectory) {
                currentLevel = currentLevel[part].children;
            } else {
                return [];
            }
        }

        // Get contents
        return Object.entries(currentLevel)
            .filter(([name, data]) => name !== 'type' && name !== 'path' && name !== 'children' && name !== 'name' && name !== 'size')
            .map(([name, data]) => ({
                name: data.name,
                path: data.path,
                size: data.size || 0,
                isDirectory: data.isDirectory
            }));
    }

    getParentPath(path) {
        if (!path) return '';
        const parts = path.split('/').filter(p => p);
        parts.pop();
        return parts.join('/');
    }

    // === README METHODS ===

    findReadmeInDirectory(directoryPath = '') {
        console.log(`🔍 Searching for README in directory: "${directoryPath}"`);

        const allFiles = Object.keys(this.zip.files);
        const readmePatterns = [
            /^readme\.md$/i,
            /^readme\.txt$/i,
            /^readme\.markdown$/i,
            /^readme$/i,
            /^readme\.rst$/i,
            /^readme\.adoc$/i
        ];

        // If directoryPath is not empty, add slash for comparison
        const dirPath = directoryPath ? `${directoryPath}/` : '';

        // Look for README files in current directory
        for (const filePath of allFiles) {
            const file = this.zip.files[filePath];

            // Skip directories
            if (file.dir) continue;

            // Check if file is in current directory
            if (!filePath.startsWith(dirPath)) continue;

            // Get relative path from current directory
            const relativePath = directoryPath ?
                filePath.substring(dirPath.length) : filePath;

            // Skip files in subdirectories
            if (relativePath.includes('/')) continue;

            // Check filename against README patterns
            const fileName = relativePath;

            for (const pattern of readmePatterns) {
                if (pattern.test(fileName)) {
                    console.log(`✅ Found README at path: ${filePath}`);
                    return {
                        file: file,
                        path: filePath,
                        name: fileName,
                        directory: directoryPath
                    };
                }
            }
        }

        console.log(`❌ No README found in directory: "${directoryPath}"`);
        return null;
    }

    async loadReadmeForCurrentDirectory() {
        try {
            console.log(`📁 Loading README for directory: "${this.currentPath}"`);

            // Check if README element exists
            if (!this.elements.readmeSection) {
                console.log('❌ README section element not found');
                return;
            }

            // First hide README section
            this.elements.readmeSection.style.display = 'none';

            // Find README in current directory
            const readmeInfo = this.findReadmeInDirectory(this.currentPath);

            // If no README found - don't show section
            if (!readmeInfo) {
                console.log(`🚫 No README in current directory, keeping section hidden`);
                return;
            }

            // Read README content
            console.log(`📖 Reading README: ${readmeInfo.path}`);
            let readmeContent;
            try {
                readmeContent = await readmeInfo.file.async('text');
                console.log(`✅ README read successfully, ${readmeContent.length} characters`);
            } catch (readError) {
                console.error('❌ Error reading README file:', readError);
                return;
            }

            // Check if file is not empty
            if (!readmeContent || readmeContent.trim().length === 0) {
                console.log('⚠️ README file is empty');
                return;
            }

            // Determine file type by extension
            const extension = readmeInfo.name.toLowerCase().split('.').pop();
            console.log(`📄 README extension: .${extension}`);

            // Render content based on file type
            let htmlContent = '';

            if (['md', 'markdown', 'mdown', 'mkdn', 'mkd', 'mdwn', 'mdt', 'mdtext'].includes(extension)) {
                // Markdown file
                console.log('🎨 Rendering as Markdown...');
                if (typeof marked !== 'undefined') {
                    try {
                        htmlContent = marked.parse(readmeContent);
                        console.log('✅ Markdown rendered successfully');
                    } catch (mdError) {
                        console.error('❌ Markdown parsing error:', mdError);
                        htmlContent = `<pre class="readme-plain">${this.escapeHtml(readmeContent)}</pre>`;
                    }
                } else {
                    console.log('⚠️ marked.js not available, rendering as plain text');
                    htmlContent = `<pre class="readme-plain">${this.escapeHtml(readmeContent)}</pre>`;
                }
            } else {
                // Any other file - show as plain text
                console.log('📝 Rendering as plain text...');
                htmlContent = `<pre class="readme-plain">${this.escapeHtml(readmeContent)}</pre>`;
            }

            // Update README content
            this.elements.readmeContent.innerHTML = htmlContent;

            // Apply syntax highlighting to code blocks
            if (this.config.enableSyntaxHighlighting && typeof Prism !== 'undefined') {
                console.log('🌈 Applying syntax highlighting...');
                const codeBlocks = this.elements.readmeContent.querySelectorAll('pre code');
                console.log(`Found ${codeBlocks.length} code blocks to highlight`);

                codeBlocks.forEach((block, index) => {
                    try {
                        Prism.highlightElement(block);
                        console.log(`✅ Highlighted code block ${index + 1}`);
                    } catch (highlightError) {
                        console.warn(`⚠️ Could not highlight code block ${index + 1}:`, highlightError);
                    }
                });
            }

            // Update README title with filename
            const readmeTitle = document.querySelector('#readmeSection .Box-title');
            if (readmeTitle) {
                readmeTitle.innerHTML = `
                    <svg class="octicon octicon-book mr-2" width="16" height="16">
                        <path d="M0 1.75A.75.75 0 0 1 .75 1h4.253c1.227 0 2.317.59 3 1.501A3.744 3.744 0 0 1 11.006 1h4.245a.75.75 0 0 1 .75.75v10.5a.75.75 0 0 1-.75.75h-4.507a2.25 2.25 0 0 0-1.591.659l-.622.621a.75.75 0 0 1-1.06 0l-.622-.621A2.25 2.25 0 0 0 5.258 13H.75a.75.75 0 0 1-.75-.75V1.75Zm8.755 3a2.25 2.25 0 0 1 2.25-2.25H14.5v9h-3.757c-.71 0-1.4.201-1.992.572l.004-7.322Zm-1.504 7.324a2.25 2.25 0 0 0-1.992-1.572H1.5V2.75h3.757a2.25 2.25 0 0 1 2.25 2.25l-.004 7.322Z"></path>
                    </svg>
                    ${readmeInfo.name}
                `;
            }

            // Show README section
            console.log('👁️ Showing README section');
            this.elements.readmeSection.style.display = 'block';

        } catch (error) {
            console.error('💥 Critical error in loadReadmeForCurrentDirectory:', error);
            // Don't show section on critical error
            if (this.elements.readmeSection) {
                this.elements.readmeSection.style.display = 'none';
            }
        }
    }

    // === FILE VIEWER METHODS ===

    async viewFile(filePath, fileName) {
        try {
            this.currentFile = { path: filePath, name: fileName };

            const file = this.zip.file(filePath);
            if (!file) {
                throw new Error('File not found');
            }

            // Check file size
            if (file._data.uncompressedSize > this.config.maxFileSizeToPreview) {
                if (!confirm(`File is ${this.config.formatFileSize(file._data.uncompressedSize)}. Continue loading?`)) {
                    return;
                }
            }

            // Determine content type
            const extension = fileName.substring(fileName.lastIndexOf('.')).toLowerCase();
            const language = this.config.getLanguageFromExtension(fileName);

            let content;
            let isBinary = false;

            // Try to read as text first
            try {
                content = await file.async('text');

                // Check if it's binary by looking for null characters
                if (content.includes('\x00')) {
                    isBinary = true;
                    throw new Error('Binary file');
                }

            } catch (textError) {
                // If text fails, treat as binary
                isBinary = true;
                const blob = await file.async('blob');
                content = URL.createObjectURL(blob);
            }

            // Update UI
            if (this.elements.fileViewerTitle) {
                this.elements.fileViewerTitle.textContent = fileName;
            }
            if (this.elements.fileExplorer) {
                this.elements.fileExplorer.style.display = 'none';
            }
            if (this.elements.fileViewer) {
                this.elements.fileViewer.style.display = 'block';
            }

            // Hide README when viewing a file
            if (this.elements.readmeSection) {
                this.elements.readmeSection.style.display = 'none';
            }

            // Update browser URL for file view
            this.updateBrowserUrl(this.getParentPath(filePath), { path: filePath, name: fileName });

            // Render content
            if (isBinary) {
                if (['.png', '.jpg', '.jpeg', '.gif', '.svg'].includes(extension)) {
                    // Display image
                    if (this.elements.fileContent) {
                        this.elements.fileContent.innerHTML = `
                            <div class="text-center">
                                <img src="${content}" alt="${fileName}" style="max-width: 100%; max-height: 500px;">
                                <p class="color-fg-muted mt-3">${fileName}</p>
                            </div>
                        `;
                    }
                } else {
                    // Show download prompt for other binary files
                    if (this.elements.fileContent) {
                        this.elements.fileContent.innerHTML = `
                            <div class="text-center py-6">
                                <svg class="octicon octicon-file-binary" width="48" height="48" style="color: var(--color-fg-muted);">
                                    <path d="M3 1.75C3 .784 3.784 0 4.75 0h6.586c.464 0 .909.184 1.237.513l2.914 2.914c.329.328.513.773.513 1.237v9.586A1.75 1.75 0 0 1 14.25 15H4.75A1.75 1.75 0 0 1 3 13.25V1.75ZM4.75 1.5a.25.25 0 0 0-.25.25v11.5c0 .138.112.25.25.25h9.5a.25.25 0 0 0 .25-.25V4.664a.25.25 0 0 0-.073-.177l-2.914-2.914a.25.25 0 0 0-.177-.073H4.75ZM6 5.5a.75.75 0 0 1 .75-.75h2.5a.75.75 0 0 1 0 1.5h-2.5A.75.75 0 0 1 6 5.5Zm.75 2.25a.75.75 0 0 0 0 1.5h1.5a.75.75 0 0 0 0-1.5h-1.5ZM6 11.25a.75.75 0 0 1 .75-.75h2.5a.75.75 0 0 1 0 1.5h-2.5a.75.75 0 0 1-.75-.75Z"></path>
                                </svg>
                                <h3 class="h3 mt-3">Binary File</h3>
                                <p class="color-fg-muted mb-3">This file cannot be displayed in the browser.</p>
                                <button class="btn btn-primary" id="downloadBinaryBtn">Download ${fileName}</button>
                            </div>
                        `;

                        const downloadBtn = document.getElementById('downloadBinaryBtn');
                        if (downloadBtn) {
                            downloadBtn.addEventListener('click', () => {
                                this.downloadCurrentFile();
                            });
                        }
                    }
                }
            } else {
                // Text file
                if (this.elements.fileContent) {
                    if (this.config.enableSyntaxHighlighting && language !== 'text' && typeof Prism !== 'undefined') {
                        try {
                            const highlighted = Prism.highlight(
                                content,
                                Prism.languages[language] || Prism.languages.text,
                                language
                            );
                            this.elements.fileContent.innerHTML = `<pre><code class="language-${language}">${highlighted}</code></pre>`;
                        } catch (highlightError) {
                            this.elements.fileContent.textContent = content;
                        }
                    } else {
                        this.elements.fileContent.textContent = content;
                    }
                }
            }

        } catch (error) {
            console.error('Error viewing file:', error);
            if (this.elements.fileContent) {
                this.elements.fileContent.innerHTML = `
                    <div class="text-center py-6">
                        <p class="color-fg-danger">Error loading file: ${error.message}</p>
                        <button class="btn btn-outline mt-2" onclick="window.repositoryViewer.showFileExplorer()">Back to files</button>
                    </div>
                `;
            }
        }
    }

    showFileExplorer() {
        if (this.elements.fileExplorer) {
            this.elements.fileExplorer.style.display = 'block';
        }
        if (this.elements.fileViewer) {
            this.elements.fileViewer.style.display = 'none';
        }

        // Update browser URL when returning to explorer
        this.updateBrowserUrl(this.currentPath);

        // Load README for current directory when returning to file explorer
        if (this.config.showReadme) {
            this.loadReadmeForCurrentDirectory();
        }

        this.currentFile = null;
    }

    // Open showcase video modal
    openShowcaseVideo() {
        if (!this.elements.videoModal || !this.elements.showcaseVideoPlayer) {
            console.error('Video modal elements not found');
            return;
        }

        // URL вашего видео файла (замените на реальный)
        const videoUrl = './showcase.mov';

        // Set video source
        this.elements.videoSource.src = videoUrl;
        this.elements.showcaseVideoPlayer.load();

        // Show modal
        this.elements.videoModal.style.display = 'flex';
        document.body.style.overflow = 'hidden'; // Prevent scrolling

        console.log('Opening showcase video:', videoUrl);
    }

    // Close showcase video modal
    closeShowcaseVideo() {
        if (!this.elements.videoModal || !this.elements.showcaseVideoPlayer) {
            return;
        }

        // Pause video
        this.elements.showcaseVideoPlayer.pause();

        // Hide modal
        this.elements.videoModal.style.display = 'none';
        document.body.style.overflow = ''; // Restore scrolling

        // Reset video
        this.elements.videoSource.src = '';
        this.elements.showcaseVideoPlayer.load();
    }

    // Download showcase video
    downloadShowcaseVideo() {
        const videoUrl = 'https://your-domain.com/showcase.mov';
        const a = document.createElement('a');
        a.href = videoUrl;
        a.download = 'showcase.mov';
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
    }

    async viewRawFile() {
        if (!this.currentFile) return;

        const file = this.zip.file(this.currentFile.path);
        if (!file) return;

        try {
            const content = await file.async('text');
            const blob = new Blob([content], { type: 'text/plain' });
            const url = URL.createObjectURL(blob);

            window.open(url, '_blank');

            setTimeout(() => URL.revokeObjectURL(url), 1000);
        } catch (error) {
            console.error('Error viewing raw file:', error);
            alert('Could not view raw file');
        }
    }

    async downloadCurrentFile() {
        if (!this.currentFile) return;

        const file = this.zip.file(this.currentFile.path);
        if (!file) return;

        try {
            const blob = await file.async('blob');
            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = this.currentFile.name;
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            URL.revokeObjectURL(url);
        } catch (error) {
            console.error('Error downloading file:', error);
            alert('Could not download file');
        }
    }

    downloadZip() {
        // The download link is already set in the anchor tag
        // This just closes the dropdown
        if (this.elements.codeDropdown) {
            this.elements.codeDropdown.style.display = 'none';
        }
    }

    refresh() {
        this.loadRepository();
    }

    showLoading(show) {
        if (!this.elements.loadingOverlay) return;

        if (show) {
            this.elements.loadingOverlay.style.display = 'flex';
        } else {
            setTimeout(() => {
                if (this.elements.loadingOverlay) {
                    this.elements.loadingOverlay.style.display = 'none';
                }
            }, 300);
        }
    }

    showError(message) {
        if (!this.elements.fileList) return;

        this.elements.fileList.innerHTML = `
            <div class="Box-row">
                <div class="text-center py-6">
                    <svg class="octicon octicon-alert" width="24" height="24" style="color: var(--color-danger-fg); margin-bottom: 12px;">
                        <path d="M6.457 1.047c.659-1.234 2.427-1.234 3.086 0l6.082 11.378A1.75 1.75 0 0 1 14.082 15H1.918a1.75 1.75 0 0 1-1.543-2.575Zm1.763.707a.25.25 0 0 0-.44 0L1.698 13.132a.25.25 0 0 0 .22.368h12.164a.25.25 0 0 0 .22-.368Zm.53 3.996v2.5a.75.75 0 0 0 1.5 0v-2.5a.75.75 0 0 0-1.5 0ZM9 11a1 1 0 1 1-2 0 1 1 0 0 1 2 0Z"></path>
                    </svg>
                    <p class="color-fg-danger mb-2">${message}</p>
                    <button class="btn btn-outline" onclick="window.repositoryViewer.refresh()">Try Again</button>
                </div>
            </div>
        `;
    }

    escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }
}

// Initialize when page loads
document.addEventListener('DOMContentLoaded', () => {
    console.log('DOM loaded, initializing GitHubZipViewer...');
    try {
        window.repositoryViewer = new GitHubZipViewer(CONFIG);
        console.log('GitHubZipViewer initialized successfully');
    } catch (error) {
        console.error('Failed to initialize GitHubZipViewer:', error);
        alert('Failed to initialize repository viewer: ' + error.message);
    }
});