" ============================================
" Configuración básica de Neovim
" ============================================

" Mostrar números de línea
set number
set relativenumber          " Números relativos para navegación

" Indentación
set tabstop=2               " Tamaño del tab visual
set shiftwidth=2            " Tamaño de indentación
set expandtab               " Convertir tabs a espacios
set smartindent             " Indentación inteligente
set autoindent              " Auto-indentación

" Búsqueda
set ignorecase              " Ignorar mayúsculas en búsqueda
set smartcase               " Sensible a mayúsculas si usas mayúsculas
set hlsearch                " Highlight resultados de búsqueda
set incsearch               " Búsqueda incremental

" Interfaz
set mouse=a                 " Habilitar mouse
set cursorline              " Resaltar línea actual
set showmatch               " Mostrar paréntesis/corchetes correspondientes
set termguicolors           " Colores true color
set signcolumn=yes          " Columna para signos (git, errores)
set scrolloff=8             " Mantener 8 líneas arriba/abajo del cursor
set colorcolumn=80          " Línea guía en columna 80

" Sistema
set noswapfile              " No crear archivos .swp
set nobackup                " No crear backups
set undofile                " Persistir historial de deshacer
set undodir=~/.config/nvim/undodir  " Directorio para undo
set clipboard=unnamedplus   " Usar clipboard del sistema

" Rendimiento
set updatetime=300          " Tiempo para escribir swap (ms)
set timeoutlen=500          " Tiempo para secuencias de teclas

" Splits
set splitright              " Split vertical a la derecha
set splitbelow              " Split horizontal abajo

" Archivos
set encoding=utf-8          " Encoding UTF-8
set fileencoding=utf-8      " Encoding de archivos

" ============================================
" Atajos de teclado (keymaps)
" ============================================

" Leader key
let mapleader = " "         " Espacio como leader key

" Guardar archivo
nnoremap <leader>w :w<CR>

" Salir
nnoremap <leader>q :q<CR>

" Salir sin guardar
nnoremap <leader>Q :q!<CR>

" Limpiar highlight de búsqueda
nnoremap <leader>h :nohlsearch<CR>

" Navegar entre splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize splits
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" Mover líneas arriba/abajo
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Mantener selección al indentar
vnoremap < <gv
vnoremap > >gv

" Copiar hasta el final de la línea (como D, C)
nnoremap Y y$

" Mejor navegación en modo insert
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" ============================================
" Auto-comandos
" ============================================

" Crear directorio undodir si no existe
if !isdirectory($HOME."/.config/nvim/undodir")
    call mkdir($HOME."/.config/nvim/undodir", "p", 0700)
endif

" Remover espacios en blanco al guardar
autocmd BufWritePre * :%s/\s\+$//e

" Resaltar al copiar (yank)
autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=200}

" ============================================
" Colorscheme
" ============================================

" Usar esquema de colores por defecto (puedes cambiar)
colorscheme desert
