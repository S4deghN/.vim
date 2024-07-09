vim9script

set nocompatible ttimeout ttimeoutlen=0     # timeout for key sequences of terminal like esc and such

set history=10000
set noswapfile undofile undodir=/tmp # Undo file shouldn't replace version control

# speed things up
set hidden
set notitle
# g:loaded_matchparen = 1

set mouse=ar                   # mouse support
g:mapleader = " "

set completeopt=menu,menuone,noinsert
set pumheight=5 previewheight=10
set wildmenu wildignorecase wildmode=longest:list      # behave like bash

set signcolumn=yes
set ruler
set laststatus=2
set showcmd showcmdloc=statusline
set shortmess=aoOFtT

set splitbelow splitright

set incsearch hlsearch
set ignorecase
set smartcase

set smartindent
set nosmarttab
set expandtab shiftwidth=4 tabstop=4
set backspace=indent,eol,start
set foldmethod=marker
set textwidth=90

set showbreak=>
set fillchars+=diff:╱

if executable('rg')
    set grepprg=rg\ -H\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

set nomodeline                 # would cause problem with keil project files
# g:c_comment_strings = 1
match CursorLine '\s\+$'       # mark trailing spaces as errors using highlight group CursorLine
filetype plugin indent on
syntax on
set termguicolors
set background=dark
color arc-green
hi Normal guibg=NONE
hi NormalFloat guibg=#242424

# -----------------------------------------------
# --- plugins ---
# -----------------------------------------------
plug#begin()
Plug 'junegunn/vim-easy-align'
xnoremap ga <plug>(EasyAlign)
nnoremap ga <plug>(EasyAlign)

Plug 'tpope/vim-commentary'
nmap gcA gcc^dWA <C-r>"
nmap gcH <cmd>r ~/.config/nvim/snips/Hcomment<cr>gc2j=2jjf-ela
nmap gch <cmd>r ~/.config/nvim/snips/hcomment<cr>gcc=lf-ela
nmap gcd yygccp

Plug 'airblade/vim-rooter'
g:rooter_silent_chdir = 1

# this is slow!
# Plug 'pgdouyon/vim-evanesco'
# this is not slow but flickers, calls StartHL() on every cursor move though!
Plug 's4deghN/vim-cool'

Plug 'ton/vim-alternate'
nnoremap go <cmd>Alternate<cr>
g:AlternatePaths = ['../itf', '../source', '../include', '../inc', '../src', '.', '..']
g:AlternateExtensionMappings = [
    {'.c': '.h', '.h': '.c'},
    {'.cpp': '.h', '.h': '.cpp'},
    {'.cpp': '.hxx', '.hxx': '.cpp'},
    {'.cpp': '.hpp', '.hpp': '.cpp'},
]

Plug 'tpope/vim-fugitive'

Plug 'junegunn/gv.vim'

Plug 'girishji/scope.vim'
noremap  <leader>f        <cmd>Scope File<cr>
noremap  <leader>B        <cmd>Scope Buffer<cr>
noremap  <leader>l        <cmd>Scope  LspDocumentSymbol<cr>
noremap  <leader>h        <cmd>Scope  Help<cr>
noremap  <leader>H        <cmd>Scope  HelpFilesGrep<cr>
nnoremap <leader>w        <cmd>Scope Grep <cword><cr>
xnoremap <leader>s        y:Scope Grep <C-R>"<cr>
nnoremap <leader>s        <cmd>Scope Grep<cr>

# Plug 'girishji/vimcomplete'

Plug 'yegappan/lsp'
def LspOnAttach()
    set completeopt=menu,menuone,noinsert

    noremap <buffer> gd  <cmd>LspGotoDefinition<cr>
    noremap <buffer> gD  <cmd>LspGotoDeclaration<cr>
    noremap <buffer> gI  <cmd>LspGotoImplementation<cr>
    noremap <buffer> gR  <cmd>LspRename<cr>
    noremap <buffer> gr  <cmd>LspShowRefrences<cr>
    noremap <buffer> gh  <cmd>LspDiagCurrent<cr>
    noremap <buffer> ]d  <cmd>LspDiagNext<cr>
    noremap <buffer> [d  <cmd>LspDiagPrev<cr>
    noremap <buffer> K   <cmd>LspHover<cr>
    noremap <buffer> gla <cmd>LspCodeAction<cr>
    noremap <buffer> glf <cmd>LspFormat<cr>
enddef

plug#end()

packadd vim-shout

t:shout_cmd = "cc"
command! -nargs=1 -bang -complete=file Sh shout#CaptureOutput(<q-args>, empty(<q-bang>) ? true : false)
nnoremap co :Sh<space>
nnoremap cc :Sh <C-r>=expand(t:shout_cmd)<cr>


var lspOpts = { # {{{
    semanticHighlight: false,
    aleSupport: false,
    autoHighlight: false,
    autoHighlightDiags: true,
    autoPopulateDiags: false,
    autoComplete: true,
    completionMatcher: 'icase',
    completionMatcherValue: 1,
    omniComplete: false,
    noNewlineInCompletion: false,
    completionTextEdit: true,
    useBufferCompletion: true,
    bufferCompletionTimeout: 100,
    customCompletionKinds: true,
    completionKinds: {
        Text:          "Text",
        Method:        "Method",
        Function:      "Function",
        Constructor:   "Constructor",
        Field:         "Field",
        Variable:      "Variable",
        Class:         "Class",
        Interface:     "Interface",
        Module:        "Module",
        Property:      "Property",
        Unit:          "Unit",
        Value:         "Value",
        Enum:          "Enum",
        Keyword:       "Keyword",
        Snippet:       "Snippet",
        Color:         "Color",
        File:          "File",
        Reference:     "Reference",
        Folder:        "Folder",
        EnumMember:    "EnumMember",
        Constant:      "Constant",
        Struct:        "Struct",
        Event:         "Event",
        Operator:      "Operator",
        TypeParameter: "TypeParameter",
        Buffer:        "Buffer",
    },
    filterCompletionDuplicates: false,
    diagSignErrorText: '•',
    diagSignHintText: '•',
    diagSignInfoText: '•',
    diagSignWarningText: '•',
    echoSignature: false,
    hideDisabledCodeActions: false,
    highlightDiagInline: false,
    hoverInPreview: false,
    ignoreMissingServer: true,
    keepFocusInDiags: false,
    keepFocusInReferences: true,
    showDiagWithVirtualText: false,
    diagVirtualTextAlign: 'after',
    diagVirtualTextWrap: 'truncate',
    outlineOnRight: false,
    outlineWinSize: 20,
    showDiagInBalloon: true,
    showDiagInPopup: true,
    showDiagOnStatusLine: false,
    showDiagWithSign: true,
    showInlayHints: false,
    showSignature: true,
    snippetSupport: false,
    ultisnipsSupport: false,
    usePopupInCodeAction: false,
    useQuickfixForLocations: true,
    vsnipSupport: false,
} # }}}

var lspServers = [ # {{{
    {
        name: 'clangd',
        filetype: ['c', 'cpp'],
        path: 'clangd',
        args: [
            '--background-index',
            "--malloc-trim",
            "--enable-config",
            "--all-scopes-completion=true",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--header-insertion=iwyu",
            "--header-insertion-decorators",
        ]
    },
    # {
    #     name: 'ccls',
    #     filetype: ['c', 'cpp'],
    #     path: 'ccls',
    #     args: [],
    #     index: {
    #             onChange: true,
    #             threads: 0,
    #     },
    #     highlight: {
    #             lsRanges: true
    #     },
    # },
    {
        name: 'rust-analyzer',
        filetype: ['rust'],
        path: 'rustup',
        args: [ "run", "nightly", "rust-analyzer", ],
        syncInit: true
    },
] # }}}

autocmd User LspSetup call LspOptionsSet(lspOpts)
autocmd User LspSetup call LspAddServer(lspServers)
autocmd User LspAttached call LspOnAttach()


# -----------------------------------------------
# --- keymaps ---
# -----------------------------------------------
cmap <C-x>f <C-r>=expand('%:p')<cr>
cmap <C-x>d <C-r>=expand('%:p:h').'/'<cr>
cmap <C-x>r redir<space>@l\|<space>\|redir<space>end<C-left><C-left>

tmap <C-]> <C-\><C-n>

# if not using terminal
inoremap <C-S-v> <C-r>+
xnoremap <C-S-v> <C-r>+

inoremap <C-f> <C-y>
inoremap <C-^> <esc><C-^>

map p ]p
map P [p

noremap '      `
noremap Y      y$
noremap gy     "+y
noremap gY     "+Y
noremap gp     "+]p
noremap gP     "+]P
# noremap L    $
# noremap H    ^
noremap n      nzz
noremap N      Nzz
noremap Q      @q
noremap <C-j>  <cmd>cn<cr>
noremap <C-k>  <cmd>cp<cr>
noremap gV     V`]
noremap gj     kddpkJ0
noremap gk     K
noremap gd     [<C-I>
noremap gn     ]<C-I>
noremap gz     1z=
noremap zs     :%s/\s\+$//e<cr>''
noremap <C-g>  1<C-g>
noremap <C-h>  :tabp<cr>
noremap <C-l>  :tabn<cr>
noremap <C-w>t :belowright term<cr>
noremap <M-a>  'A
noremap <M-s>  'S
noremap <M-d>  'D
noremap <M-f>  'F

nmap <leader>d :bn\|bd #<cr>
nmap <leader>b :b<space>
nmap <leader>e :e<space><C-x>d
nmap <leader>E :Exp<cr>
# nmap <leader>h :vert h<space>

# CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
# so that you can undo CTRL-U after inserting a line break.
# Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

# using 'pgdouyon/vim-evanesco' instead
nnoremap *       *N
xnoremap *       y/\V<C-R>"<cr>N
nnoremap #       #N
xnoremap #       y?\V<C-R>"<cr>N

# -----------------------------------------------
# --- auto cmds ---
# -----------------------------------------------
augroup autoCommands
    autocmd!
    # Mark `"` is the position when last exiting the current buffer.
    autocmd BufReadPost *
                \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
                \ |   exe "normal! g`\"zz"
                \ | endif

    # autocmd BufEnter * call feedkeys("\<C-g>")

    autocmd Filetype tex,text,markdown,gitcommit setlocal spell
    # autocmd Filetype cpp,rust setlocal matchpairs+=<:>
    autocmd Filetype netrw NetrwConfig()
    autocmd Filetype qf nmap <buffer> <Esc> ZQ
    autocmd Filetype qf wincmd L
    autocmd BufAdd .clang* set filetype=yaml
    autocmd BufAdd /tmp/bash* set filetype=sh # for the v command in bash vi mode

    autocmd BufWritePost */.vim/**/*.vim,.vimrc,vimrc source %

    autocmd CmdwinEnter * nmap <buffer> <Esc> :q<cr>
    autocmd CmdwinEnter * nmap <buffer> <C-c> :q<cr>

    # autocmd VimResume,BufEnter,WinEnter,VimEnter * TmuxApplyTitle()
    # autocmd VimLeave,VimSuspend * TmuxResetTitle()
augroup end

# -----------------------------------------------
# --- cmds ---
# -----------------------------------------------
# Convenient command to see the difference between the current buffer and the
# file it was loaded from, thus the changes you made.
command! DiffOrig vert new | set bt=nofile | r ++edit %% | 0d_ | diffthis | wincmd p | diffthis


# -----------------------------------------------
# --- functions ---
# -----------------------------------------------
def TmuxApplyTitle()
    system("tmux rename-window \"[" .. expand("%:t") .. "]\"")
enddef

def TmuxResetTitle()
     system("tmux set-window-option automatic-rename on")
enddef

# Get highlight groups of word under cursor in Vim
export def Syn()
    for id in synstack(line("."), col("."))
        echo synIDattr(id, "name")
    endfor
enddef


# -----------------------------------------------
# --- netrw ---
# -----------------------------------------------
# netrw sucks!
g:netrw_keepdir = 0 # change dir as browsing dir changes

export def NetrwDel()
    normal! 0y$
    system("mv \"" .. getreg('@0') .. "\" /tmp/")
enddef

export def NetrwConfig()
    setlocal cursorlineopt=line

    g:netrw_banner = 0
    nmap <buffer> h -^
    nmap <buffer> <Left> -^
    nmap <buffer> l <cr>
    nmap <buffer> <Right> <cr>
    nmap <buffer> . gh
    nmap <buffer> P <C-w>z

    # TODO: changing permissions with `gp` doesn't work

    # TODO: add and delete and undo function.
    # the idea is to have a netrw undo file in /tmp and `mv` deleted
    # file/directory to it with directory information so that we can move theme
    # back to the correct place in system with undo function.
    # g:netrw_keepdir has to be unset so we change directory as we borows.

    # delete file/directory under cursor recursively
    nmap <buffer> D :call NetrwDel()<cr><C-l>
    # retrieve the last deleted file
    # nmap <buffer> u
enddef

defcompile
