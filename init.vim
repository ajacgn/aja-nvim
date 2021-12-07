" UNCOMMENT TO ENABLE .vimrc
" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath=&runtimepath
" source ~/.vimrc

" ---- VIM-PLUG SETUP  ----
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" -------------- ALE -------------------------------
"
"ALE settings

nmap <silent> <C-e> <Plug>(ale_next_wrap)

" don’t lint on open files
let g:ale_lint_on_enter = 0

" lint on save
let g:ale_lint_on_save = 1

" make it prettier
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '●'
augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

let g:ale_linter_aliases = {
            \ 'jsx': ['css', 'javascript'],
            \ 'vue': ['eslint', 'vls']
            \}

let g:ale_linters = {
            \ 'jsx': ['stylelint', 'eslint'],
            \ 'vim': ['vint'],
            \ 'zsh': ['shell', 'shellcheck'],
            \ 'markdown': ['md', 'txt'],
            \}


let g:ale_fixers = {
            \ 'javascript': ['eslint', 'prettier'],
            \ 'css': ['css'],
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \}

" let g:ale_fix_on_save = 1

let g:ale_sign_column_always = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_on_insert_leave = 1
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_open_list = 0
let g:ale_list_window_size = 5

let g:ale_disable_lsp = 1

" -------------- ALE -------------------------------

" -------- END VIM-PLUG SETUP ----

set nocompatible

call plug#begin('~/.config/nvim/plugged')

" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'mattn/emmet-vim'

" Sensible default 
Plug 'tpope/vim-sensible'

" Color schemes
Plug 'sainnhe/edge'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" File Explorer
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'

Plug 'airblade/vim-gitgutter'

Plug 'unblevable/quick-scope'

Plug 'itchyny/lightline.vim'

Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'ryanoasis/vim-devicons'
Plug 'andymass/vim-matchup'
Plug 'nathanaelkane/vim-indent-guides'

Plug 'dense-analysis/ale'

" Track the engine.
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

call plug#end()

" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<c-s-u>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

if has('termguicolors')
  set termguicolors
endif

let g:edge_style = 'neon'
let g:edge_enable_italic = 1
let g:edge_disable_italic_comment = 1
let g:edge_cursor = 'auto'

colorscheme edge

"" REMAP LEADER KEY
let mapleader = ' '

syntax enable
filetype plugin indent on

set nu rnu
set completeopt=longest,menuone,noinsert,noselect
set shortmess+=c
set cmdheight=2
set updatetime=100
set encoding=UTF-8
set splitright
set splitbelow
set number
set relativenumber
set hlsearch
set hidden
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set shiftround
set expandtab
set smartindent
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set noshowmode
set ignorecase
set smartcase
set title
set showmatch
set matchtime=3
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" DISPLAY ALL MATCHING FILES WHEN WE TAB COMPLETE
set wildmenu

" Ignore files
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*

"" SPELL-CHECK
"" https://thoughtbot.com/blog/vim-spell-checking
"" https://www.linux.com/training-tutorials/using-spell-checking-vim/
"" ]s - Jump to thee next misspelled word
"" [s - Jump to the previous misspelled word
"" z= - Bring up the suggested replacements
"" zg - Good word: Add the word under the cursor to the dictionary
"" zw - Woops! Undo and remove the word from the dictionary
" setlocal spell 
setlocal spelllang=en_us,de_de
set spellfile=~/.vim/spell/en.utf-8.add
set complete+=kspell

set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch

"" Whitespace characters
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

noremap <F7> :set list!<CR>
inoremap <F7> <C-o>:set list!<CR>
cnoremap <F7> <C-c>:set list!<CR>

"" use alt+hjkl to move between split/vsplit panels
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


"" Move line one down alt-j, alt-k
nnoremap º :m .+1<CR>==
nnoremap ∆ :m .-2<CR>==
inoremap º <Esc>:m .+1<CR>==gi
inoremap ∆ <Esc>:m .-2<CR>==gi
vnoremap º :m '<-2<CR>gv=gv
vnoremap ∆ :m '>+1<CR>gv=gv

"" Update a buffer's contents on focus if it changed outside of Vim.
au FocusGained,BufEnter * :checktime
"" Save all buffers on focusLost event
au FocusLost * :wa

nnoremap <Leader>+ :vertical resize +10<CR>
nnoremap <Leader>- :vertical resize -10<CR>

"" copy text to primary and secondary clipboard
noremap <Leader>y "*y
"" noremap <Leader>p "*p
noremap <Leader>Y "+y
"" noremap <Leader>P "+p

"" Set file type
" autocmd BufRead,BufNewFile *.tag set filetype=jsp

"" https://vim.fandom.com/wiki/Search_and_replace_the_word_under_the_cursor
:nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>

"" Keep cursor at the bottom of the visual selection after you yank it.
vmap y ygv<Esc>

"" Toggle spell check.
map <F5> :setlocal spell!<CR>

"" Toggle relative line numbers and regular line numbers.
"" nmap <F6> :set invrelativenumber<CR>
"nmap <F6> :setlocal spell spelllang=de_de<CR>
"nmap <Leader><F6> :setlocal spell spelllang=en_us<CR>

" --------------- quick-scope --------------------

" Trigger a highlight in the appropriate direction when pressing these keys.
let g:qs_highlight_on_keys=['f', 'F', 't', 'T']

" Only underline the highlights instead of using custom colors.
highlight QuickScopePrimary gui=underline cterm=underline
highlight QuickScopeSecondary gui=underline cterm=underline

" --------------- quick-scope --------------------

"" Clear search highlights.
map <Leader><Space> :let @/=''<CR>

nnoremap <Leader>ev :tab drop ~/.config/nvim/init.vim<CR>

"" Source Vim config file.
nnoremap <Leader>sv :source ~/.config/nvim/init.vim<CR>

augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

" ------------------ COC --------------------------------
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()

  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Change current directory to open file directory
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Code actions
nmap <leader>do <Plug>(coc-codeaction)

" ------------------ COC --------------------------------


" ----------------- TELESCOPE ---------------------------

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>bb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fl <cmd>Telescope git_files<cr>
nnoremap <leader>f* <cmd>Telescope grep_string<cr>

lua <<EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    file_ignore_patterns = {'node_modules/.*'},
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}
EOF

" ----------------- TELESCOPE ---------------------------
"
" -------------- TREESITTER ---------------------------

" lua <<EOF
" require'nvim-treesitter.configs'.setup {
"     highlight = {
"         enable = true
"     },
" }
" EOF

" -------------- TREESITTER ---------------------------

" -------------- FILE EXPLORER -----------------------
nnoremap <leader>tt :NvimTreeToggle<CR>
nnoremap <leader>tr :NvimTreeRefresh<CR>
nnoremap <leader>tf :NvimTreeFindFile<CR>

let g:nvim_tree_indent_markers = 1

lua <<EOF
require'nvim-tree'.setup()
EOF

" NvimTreeOpen and NvimTreeClose are also available if you need them
" -------------- FILE EXPLORER -----------------------

" -------------- EMMET -------------------------------

let g:user_emmet_leader_key=','

" -------------- EMMET -------------------------------
"
" -------------- NERDTREE ----------------------------
" <alt-shift-b>
nnoremap <silent> ‹ :NERDTreeFind<CR>
" <alt-b>
nnoremap <silent> ∫ :NERDTreeToggle<CR>

let NERDTreeDirArrows = 0
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['.gitconfig', '.DS_Store']
let g:NERDTreeStatusline = ''
let g:NERDTreeWinSize=45

" -------------- NERDTREE ----------------------------
"
" -------------- LIGHTLINE  ----------------------------

let g:lightline = {
      \ 'colorscheme': 'edge',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" -------------- LIGHTLINE  ----------------------------

" -------------- COC ----------------------------------

let g:coc_global_extensions = ['coc-css', 'coc-html', 'coc-json', 'coc-tsserver', 'coc-snippets', 'coc-highlight', 'coc-vetur' ]

" coc-tsserver        " javascript/typescript server - completion, refactor etc
" coc-tslint-plugin   " javascript/tyescript linting
" coc-snippets        " provides snippets engine as in vscode (see my previous article)
" coc-highlight       " provides basic highlight of words selected
" coc-emmet           " emmet! works as in vscode
" coc-marketplace     " marketplace to simplify search and installation of coc extensions
" coc-html            " html - completion, refactor etc
" coc-json            " json - completion, refactor etc
" coc-vetur           " famous vscode plugin - completion,refactor,linting and much more
" coc-css             " css
" -------------- COC ----------------------------------
"
"
" Buffer
" Buffer delete: alt - w
nnoremap ∑ :bd<CR>

" --------------- AUTO CLOSE -----------------------

" https://alldrops.info/posts/vim-drops/2018-05-15_understand-vim-mappings-and-create-your-own-shortcuts/
" https://medium.com/vim-drops/custom-autoclose-mappings-1ff90f45c6f5

"autoclose and position cursor to write text inside
inoremap ' ''<left>
inoremap ` ``<left>
inoremap " ""<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><left>
"autoclose with ; and position cursor to write text inside
inoremap '; '';<left><left>
inoremap `; ``;<left><left>
inoremap "; "";<left><left>
inoremap (; ();<left><left>
inoremap [; [];<left><left>
inoremap {; {};<left><left>
"autoclose with , and position cursor to write text inside
inoremap ', '',<left><left>
inoremap `, ``,<left><left>
inoremap ", "",<left><left>
inoremap (, (),<left><left>
inoremap [, [],<left><left>
inoremap {, {},<left><left>
"autoclose and position cursor after
inoremap '<tab> ''
inoremap `<tab> ``
inoremap "<tab> ""
inoremap (<tab> ()
inoremap [<tab> []
inoremap {<tab> {}
"autoclose with ; and position cursor after
inoremap ';<tab> '';
inoremap `;<tab> ``;
inoremap ";<tab> "";
inoremap (;<tab> ();
inoremap [;<tab> [];
inoremap {;<tab> {};
"autoclose with , and position cursor after
inoremap ',<tab> '',
inoremap `,<tab> ``,
inoremap ",<tab> "",
inoremap (,<tab> (),
inoremap [,<tab> [],
inoremap {,<tab> {},
"autoclose 2 lines below and position cursor in the middle
inoremap '<CR> '<CR>'<ESC>O
inoremap `<CR> `<CR>`<ESC>O
inoremap "<CR> "<CR>"<ESC>O
inoremap (<CR> (<CR>)<ESC>O
inoremap [<CR> [<CR>]<ESC>O
inoremap {<CR> {<CR>}<ESC>O
"autoclose 2 lines below adding ; and position cursor in the middle
inoremap ';<CR> '<CR>';<ESC>O
inoremap `;<CR> `<CR>`;<ESC>O
inoremap ";<CR> "<CR>";<ESC>O
inoremap (;<CR> (<CR>);<ESC>O
inoremap [;<CR> [<CR>];<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
"autoclose 2 lines below adding , and position cursor in the middle
inoremap ',<CR> '<CR>',<ESC>O
inoremap `,<CR> `<CR>`,<ESC>O
inoremap ",<CR> "<CR>",<ESC>O
inoremap (,<CR> (<CR>),<ESC>O
inoremap [,<CR> [<CR>],<ESC>O
inoremap {,<CR> {<CR>},<ESC>O

" --------------- AUTO CLOSE -----------------------

" --------------- GIT GUTTER -----------------------
let g:gitgutter_map_keys = 0
" --------------- GIT GUTTER -----------------------
"
"  -------------- UPPERCASE COMMANDS ----------------

:command! -bar -bang Q quit<bang>
:command! -bar -bang W write<bang>

"  -------------- UPPERCASE COMMAND ----------------
