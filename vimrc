" vim: fdm=marker
" vim: foldlevel=0
" --------------------------
" | rygwdn's vimrc         |
" | Version 1.0            |
" --------------------------


" init ---------------------------------------- {{{
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
    finish
endif
" ------------------------------------------- }}}

" Load bundles ---------------------------------------- {{{

runtime vundle
call vundle#rc()

" Deps
Bundle 'L9'

" Colorschemes
Bundle "candycode.vim"
Bundle "blackboard.vim"

" Programming
Bundle "git://github.com/tpope/vim-ragtag.git"
Bundle "DoxygenToolkit.vim"
Bundle "FSwitch"
"Bundle "UltiSnips"
Bundle "git://github.com/rygwdn/ultisnips.git"
Bundle "git://github.com/rygwdn/vim-ipython.git"
Bundle "git://github.com/rygwdn/vim-pylint.git"
Bundle "git://github.com/rygwdn/latexbox-rubber.git"


" Filetypes
Bundle "LaTeX-Box"
Bundle "jQuery"
Bundle "pdc.vim"
Bundle "git://github.com/tpope/vim-rails.git"
Bundle "git://github.com/tpope/vim-cucumber.git"
Bundle "git://github.com/vim-ruby/vim-ruby.git"
Bundle "git://github.com/msanders/cocoa.vim.git"
Bundle "git://github.com/sukima/xmledit.git"
Bundle "git://github.com/Rip-Rip/clang_complete.git"
Bundle "git://github.com/Raimondi/vimoutliner.git"
Bundle "git://github.com/nvie/vim-rst-tables.git"
Bundle "git://github.com/ingydotnet/yaml-vim.git"

" Git stuff
Bundle "git://github.com/tpope/vim-fugitive.git"
Bundle "git://github.com/tpope/vim-git.git"

" Search
Bundle "IndexedSearch"
Bundle "git://github.com/mileszs/ack.vim.git"
Bundle "git://github.com/gmarik/vim-visual-star-search.git"

" Open files
Bundle "FuzzyFinder"
Bundle "git://github.com/scrooloose/nerdtree.git"

" Movement
Bundle "matchit.zip"
Bundle "camelcasemotion"
Bundle "git://github.com/kana/vim-operator-user.git"

" Navigation
Bundle "Marks-Browser"
Bundle "taglist.vim"

" Operations
Bundle "operator-camelize"
Bundle "git://github.com/tpope/vim-repeat.git"
Bundle "git://github.com/tpope/vim-surround.git"
Bundle "git://github.com/michaeljsmith/vim-indent-object.git"

" Utility
Bundle "VOoM"
Bundle "ZoomWin"
Bundle "YankRing.vim"
Bundle "netrw.vim"
Bundle "tlib"
Bundle "bufkill.vim"
Bundle "CmdlineCompl.vim"
Bundle "session.vim--Odding"
Bundle "git://github.com/sjl/gundo.vim.git"
Bundle "git://github.com/tsaleh/vim-align.git"
Bundle "git://github.com/panozzaj/vim-autocorrect.git"
Bundle "git://github.com/ervandew/supertab.git"
Bundle "git://github.com/rygwdn/vim-conque.git"
Bundle "https://github.com/gregsexton/VimCalc.git"

" ---------------------------------------- }}}}

" Run pathogen ---------------------------------------- {{{

filetype indent plugin off
filetype off
" setup runtime path using the excellent vim-pathogen:
" http://github.com/tpope/vim-pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#runtime_prepend_subdirectories('~/.vim/manual')
call pathogen#runtime_prepend_subdirectories('~/.vim/pre')
call pathogen#helptags()
filetype on
filetype indent plugin on


" ------------------------------------------- }}}

" mark ---------------------------------------- {{{

let g:cur_marks="marking.otl"
au BufWinEnter */sc/ta*.txt source ~/projects/vim/marking-help/fuz.vim
au BufWinEnter */sc/ta*.txt set completeopt-=longest
au BufWinEnter */sc/ta*.txt set completefunc=CompleteMarks
au BufWinEnter */sc/ta*.txt set omnifunc=CompleteMarks
au BufWinEnter */sc/ta*.txt YRToggle(0)
au BufWinEnter */sc/ta*.txt set colorcolumn=88
au BufWinEnter */sc/ta*.txt set list
au BufWinEnter */sc/ta*.txt set listchars=tab:>-
au BufWinEnter */sc/ta*.txt runtime syntax/c.vim
"au BufWinEnter */sc/ta*.txt set acd
au BufWinEnter */sc/ta*.txt set indentexpr=

" ------------------------------------------- }}}

" Operational settings -------------------------------------- {{{
set nocompatible    "Vim rocks! this must be first to avoid side effects.

syntax on                       " syntax on
filetype on                     " automatic file type detection
set autoread                    " watch for file changes by other programs
set visualbell                  " visual beep
set noautowrite                 " don't automatically write on :next, etc
set scrolloff=5                 " keep at least 5 lines above/below cursor
set sidescrolloff=5             " keep at least 5 columns left/right of cursor
set history=200                 " remember the last 200 commands
"set autochdir                   " current dir always matches curr file
set linebreak                   " wrap on words, not in the middle of them
set wrap                        " ...
set guioptions-=T               " no toolbar
"set formatoptions=l            " don't insert eols, just wrap

let maplocalleader=','          " all my macros start with ,
let mapleader=","               " set <Leader> to , instead of \

if v:version >= 703
    set rnu                     " relative line nums
endif

" ----------------------------------------------------------------- }}}

" backup and tempdir settings {{{
set backup                      " produce *~ backup files
set backupext=~                 " add ~ to the end of backup files

let g:temp_path = '/tmp' " default
if has('python')
python << EOF
import os, vim

dirs = ("~/tmp/.vim", "~/.vim/tmp", "/tmp")
for dir in dirs:
    p = os.path.realpath(os.path.expanduser(dir))
    if os.path.isdir(p):
	vim.command("let g:temp_path='%s'" % p)
	break
else:
    print 'Failed to set temp path'
EOF
endif

let &directory=g:temp_path
let &backupdir=g:temp_path

if v:version >= 703
    set undofile
    let &undodir=g:temp_path
endif

let g:yankring_history_dir = g:temp_path
" }}}-----------------------------------------------------------------

" mouse settings ---------------------------------------- {{{
set mouse=a                     " mouse support in all modes
set mousehide                   " hide the mouse when typing text

" ,p and shift-insert will paste the X buffer, even on the command line
nmap <S-Insert> i<S-MiddleMouse><ESC>
imap <S-Insert> <S-MiddleMouse>
cmap <S-Insert> <S-MiddleMouse>

" this makes the mouse paste a block of text without formatting it 
" (good for code)
map <MouseMiddle> <esc>"*p

" -------------------------------------------------------- }}}

" global editing settings -----------------------------------------{{{
set expandtab                   " use spaces, not tabs
set smarttab                    " make <tab> and <backspace> smarter
set tabstop=8                   " tabstops of 8
set shiftwidth=4                " indents of 4
set softtabstop=4               " act like ts=4
set backspace=eol,start,indent  " allow backspacing over indent, eol, & start
set undolevels=1000             " number of forgivable mistakes
set updatecount=100             " write swap file to disk every 100 chars
set foldenable
set foldlevel=99999

if v:version >= 703
    set colorcolumn=80
endif

set splitright                  " vertical split opens new window on right

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif
" ------------------------------------------------------------- }}}

" searching ------------------------------------------ {{{
set nohlsearch                   " enable search highlight globally
set incsearch                  " show matches as soon as possible
set noshowmatch                " don't show matching brackets when typing
set showfulltag                " Show full tags when doing search completion
set ignorecase smartcase       " case-insensitive if lower case
set gdefault                   " use ///g by default, now it switches it off

" disable last one highlight
nmap <LocalLeader><space> :noh<cr>
"nnoremap <esc> :noh<cr><esc>

" very magic searching
nnoremap / /\v
vnoremap / /\v

" ---------------------------------------------------- }}}

" handy commands & mappings ---------------------------- {{{

" insert mode paste (like esc p i)
imap  "

nmap Y y$

map <F4> :FSHere<CR>

" save and build
nmap <LocalLeader>wm  :w<cr>:make<cr>

" work with errors
nmap <LocalLeader>ln  :lnext<CR>
nmap <LocalLeader>lp  :lprevious<CR>
nmap <LocalLeader>cn  :cnext<CR>
nmap <LocalLeader>cp  :cprevious<CR>
nmap <LocalLeader>cc  :cc<CR>

" use Q for formatting
map Q gq

" Move around windows
nmap <c-l> l
nmap <c-h> h
nmap <c-k> k
nmap <c-j> j
"map <C-a> 

" Auto close braces
inoremap { {}O

" Handy commands
command! W w

" Sometimes I hate the defaults for these two in insert!
"inoremap <c-u> 
"inoremap <c-w> 

" Allow tab to jump between pairs
nnoremap <tab> %
vnoremap <tab> %

" --------------------------------------------- }}}

" command completion --------------------------- {{{

" Use the cool tab complete menu
set wildmenu
set wildignore+=*.o,*~,.lo
set suffixes+=.in,.a

" shell style completion, double tab cycles
set wildmode=list:longest,full

" -------------------------------------- }}}

" insert completion ----------------------------- {{{

" Ide style completion
set completeopt=menuone,preview,longest
" <CR> selects completion

""" "inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
""" inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" used with CTRL-X CTRL-K
"au BufRead,BufNew *.txt,*.tex,*.pdc set dictionary=/usr/share/dict/words

"set complete=.,w,b,u,U,t,i,d    " do lots of scanning on tab completion
"set complete-=k complete+=k
"set ofu=syntaxcomplete#Complete

" Close preview window automatically
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" SuperTab stuff ------------------------------------------ {{{

"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabContextDiscoverDiscovery =
    \ ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]

"let g:SuperTabLongestHighlight = 1
let g:SuperTabLongestEnhanced = 1
let g:SuperTabCrMapping = 0

"au FileType java call SuperTabSetDefaultCompletionType("<c-x><c-u>")
"au BufWinEnter */sc/ta/*/marks call SuperTabSetDefaultCompletionType("<c-x><c-l>")

" ------------------------------------------------------ }}}

" ------------------------------------------------}}}

" visual/gui stuff -------------------------- {{{

set cmdheight=2                 " make command line two lines high
set ruler		" show the cursor position all the time
set lazyredraw                  " don't redraw when running macros
set showcmd		" display incomplete commands

"colorscheme default2
if stridx(&rtp, "blackboard") != -1
    colorscheme blackboard
endif

" 1 height windows
set winminheight=1

set laststatus=2
set statusline=%<%f%w\ %h%m%r\ %y\ \ %{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P


if has("gui_running") && stridx(&rtp, "candycode") != -1
    " window size
    "set lines=40
    "set columns=80
    colorscheme candycode
    set guifont="Inconsolata Medium 12"

    set cursorline cursorcolumn
    au WinLeave * set nocursorline nocursorcolumn
    au WinEnter * set cursorline cursorcolumn

    set go-=TLr " Toolbar, scrollbars
else
    set bg=dark
endif
" --------------------------------------- }}}

" file type stuff ------------------- {{{

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype indent on
filetype plugin on
"set autoindent smartindent      " turn on auto/smart indenting

"" C, C++ stuff
" make 'make' not spew junk
let g:load_doxygen_syntax=1
let g:DoxygenToolkit_authorName="Ryan Wooden (100079872)"
au filetype c,cpp set makeprg=make\ -s\ -i
au filetype c,cpp set spell
au filetype c,cpp map <leader>d :Dox<CR>

" recognize objective C files
au BufNewFile,BufRead *.m set ft=objc
au FileType objc set syntax=objc.doxygen
let filetype_m='objc'

" Rec prolog files
au BufNewFile,BufRead *.pl set ft=prolog

" help files, make return jump to tag
autocmd FileType help nmap <buffer> <Return> <C-]>

" Word processing (latex, some? plain text)
cabbr wp call Wp()
fun! Wp()
    set wrap
    set linebreak
    runtime autocorrect.vim
    nnoremap j gj
    nnoremap k gk
    nnoremap 0 g0
    nnoremap $ g$
    nnoremap <Home> g0
    nnoremap <End> g$
    set nonumber nornu
    set spell spelllang=en_us
    set display+=lastline
endfu

au FileType tex,pdc call Wp()


" Latex
let g:tex_flavor='latex'

" Automatically make on write
"function! MakeTex()
"    silent make!
"endfunction
au BufWritePost *.tex Rubber

" Use a makefile :)
" Or not... - set to makeprg=make to automake
au FileType tex set makeprg=

function! LatexEvinceSearch()
    execute "!cd " . LatexBox_GetTexRoot() . '; evince_dbus.py "`basename ' . LatexBox_GetOutputFile(). '`" ' . line('.') . ' "%:p"'
endfun
command! LatexEvinceSearch call LatexEvinceSearch()

au FileType tex map <Leader>ls :silent LatexEvinceSearch<CR>
au FileType tex imap <buffer> ]] <Plug>LatexCloseCurEnv


"Mail
au FileType mail set tw=0 spell colorcolumn=73
au FileType mail call Wp()



" Highlight whitespace at end of line
au BufWinEnter *.c,*.java,*.cpp,*.h,*.m highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL


"autocmd BufEnter *.otl set ft=vo_base
au FileType otl map <M-S-j> <M-S-Down>
au FileType otl map <M-S-k> <M-S-Up>
let otl_map_tabs = 1
au FileType otl set tw=100 ts=3 sts=3 sw=3 fo-=t foldlevel=10
let no_otl_insert_maps = 1

augroup html
    let xml_use_xhtml = 1
    au BufWinEnter *.html,*.php imap <S-CR> <br /><Right><CR>
augroup END

set diffopt=filler,iwhite       " ignore all whitespace and sync

autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

"" Python stuff
"autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python runtime syntax/doxygen.vim
autocmd FileType python compiler pylint

" --------------------------------------------------- }}}

" Testing stuff -------------------------------- {{{
" From http://bitbucket.org/garybernhardt/dotfiles/src/88b1b6356f54/.vimrc

function! RunTests(target, args)
    silent ! echo
    exec 'silent ! echo -e "\033[1;36mRunning tests in ' . a:target . '\033[0m"'
    silent w
    exec "make " . a:target . " " . a:args
endfunction

function! ClassToFilename(class_name)
    let understored_class_name = substitute(a:class_name, '\(.\)\(\u\)', '\1_\U\2', 'g')
    let file_name = substitute(understored_class_name, '\(\u\)', '\L\1', 'g')
    return file_name
endfunction

function! ModuleTestPath()
    let file_path = @%
    let components = split(file_path, '/')
    let path_without_extension = substitute(file_path, '\.py$', '', '')
    let test_path = 'tests/unit/' . path_without_extension
    return test_path
endfunction

function! NameOfCurrentClass()
    let save_cursor = getpos(".")
    normal $<cr>
    call PythonDec('class', -1)
    let line = getline('.')
    call setpos('.', save_cursor)
    let match_result = matchlist(line, ' *class \+\(\w\+\)')
    let class_name = ClassToFilename(match_result[1])
    return class_name
endfunction

function! TestFileForCurrentClass()
    let class_name = NameOfCurrentClass()
    let test_file_name = ModuleTestPath() . '/test_' . class_name . '.py'
    return test_file_name
endfunction

function! TestModuleForCurrentFile()
    let test_path = ModuleTestPath()
    let test_module = substitute(test_path, '/', '.', 'g')
    return test_module
endfunction

function! RunTestsForFile(args)
    if @% =~ 'test_'
        call RunTests('%', a:args)
    else
        let test_file_name = TestModuleForCurrentFile()
        call RunTests(test_file_name, a:args)
    endif
endfunction

function! RunAllTests(args)
    silent ! echo
    silent ! echo -e "\033[1;36mRunning all unit tests\033[0m"
    silent w
    exec "make!" . a:args
endfunction

function! JumpToError()
    if getqflist() != []
        for error in getqflist()
            if error['valid']
                break
            endif
        endfor
        let error_message = substitute(error['text'], '^ *', '', 'g')
        silent cc!
        exec ":sbuffer " . error['bufnr']
        call RedBar()
        echo error_message
    else
        call GreenBar()
        echo "All tests passed"
    endif
endfunction

function! RedBar()
    hi RedBar ctermfg=white ctermbg=red guibg=red
    echohl RedBar
    echon repeat(" ",&columns - 1)
    echohl
endfunction

function! GreenBar()
    hi GreenBar ctermfg=white ctermbg=green guibg=green
    echohl GreenBar
    echon repeat(" ",&columns - 1)
    echohl
endfunction

function! JumpToTestsForClass()
    exec 'e ' . TestFileForCurrentClass()
endfunction

let mapleader=","
" nnoremap <leader>m :call RunTestsForFile('--machine-out')<cr>:redraw<cr>:call JumpToError()<cr>
" nnoremap <leader>M :call RunTestsForFile('')<cr>
" nnoremap <leader>a :call RunAllTests('--machine-out')<cr>:redraw<cr>:call JumpToError()<cr>
" nnoremap <leader>A :call RunAllTests('')<cr>

" nnoremap <leader>a :call RunAllTests('')<cr>:redraw<cr>:call JumpToError()<cr>
" nnoremap <leader>A :call RunAllTests('')<cr>

nnoremap <leader>t :call RunAllTests('')<cr>:redraw<cr>:call JumpToError()<cr>
nnoremap <leader>T :call RunAllTests('')<cr>


" ------------------------------------------------------- }}}

" quickfix window tweaks -------------------------------- {{{

" 	adjust window height
"au FileType qf call AdjustWindowHeight(3, 10)
"function! AdjustWindowHeight(minheight, maxheight)
"    if !exists("g:noqfresize")
"        exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
"    endif
"endfunction
"
"command Qfres let g:noqfresize=1
"command Qfnores unlet g:noqfresize

" ------------------------------------------------------- }}}

" screen stuff ------------------------------- {{{

autocmd BufEnter * let &titlestring = "vim[" . expand("%:t") . "]"
if &term == "screen"
    set t_ts=k
    set t_fs=\
endif

if &term == "screen" || &term == "xterm"
    set title
endif

" ---------------------------------------------- }}}

" Plugins {{{

command! JCommentWriter silent call JCommentWriter()

let g:pylint_cwindow = 0

"" for py-test-switcher
map <silent> <F3> :SwitchCodeAndTest<CR>

let g:user_zen_expandabbr_key='<S-Space>'
let g:user_zen_leader_key='<C-e>'
let g:user_zen_complete_tag=1

" session.vim stuff -------------------{{{

let g:session_autosave = 1

" -------------------------------------}}}

" Camel-case stuff -------------------{{{

map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

map <Leader>c <Plug>(operator-camelize)
map <Leader>C <Plug>(operator-decamelize)

" -------------------------------------}}}


" snippet stuff -------------------{{{

command! UltiReset py UltiSnips_Manager.reset()
let g:ultisnips_python_style = "doxygen"
let g:ultisnips_java_brace_style = "nl"

" -------------------------------------}}}

" Conque shell ----------------------- {{{

command! CV ConqueVSplit
command! CC Conque
command! CS ConqueSplit
command! Ipy ConqueVSplit ipython

" ---------------------------------------- }}}

" fuzzy finder stuff ----------------------- {{{

let g:fuzzy_matching_limit = 20
map <leader>ff :FufFile<CR>
map <leader>fr :FufCoverageFile<CR>
map <leader>b :FufBuffer<CR>
nmap <space> :FufBuffer<CR>

" abbrev for recursive
let g:fuf_abbrevMap = {"^\*" : ["**/",],}

let g:fuf_keyNextPattern  = "<C-n>"
let g:fuf_keyPrevPattern  = "<C-p>" 

let g:fuf_keyNextMode     = "<C-u>"
let g:fuf_keyPrevMode     = "<C-i>"

let g:fuf_keyOpen         = "<CR> "
let g:fuf_keyOpenSplit    = "<C-j>"
let g:fuf_keyOpenTabpage  = "<C-t>"
let g:fuf_keyOpenVsplit   = "<C-l>"


" ---------------------------------------- }}}

" RopeVim -------------------------------- {{{

"Use my rope stuff
autocmd FileType python set omnifunc=RopeCompleteFunc

let ropevim_codeassist_maxfixes=10
let ropevim_vim_completion=1
let ropevim_extended_complete=1
let ropevim_guess_project=1
let ropevim_local_prefix="<LocalLeader>r"
let ropevim_global_prefix="<LocalLeader>p"
"let ropevim_enable_shortcuts=0

if has('python')
python << EOF
import sys, os
for path in ("", "/rope", "/ropemode"):
    sys.path.append(os.path.expanduser('~/.vim/manual/ropevim' + path)) # XXX
EOF
endif
"let ropevim_enable_autoimport=0

" ------------------------------------------------------ }}}

" Eclim stuff ------------------------------------------------ {{{
let g:EclimDisabled=1
augroup java
    autocmd FileType java set makeprg=javac\ %
    autocmd FileType java :nnoremap <silent> <buffer> <leader>i :JavaImport<cr>
    autocmd FileType java :nnoremap <silent> <buffer> <leader>d :JavaDocSearch -x declarations<cr>
    autocmd FileType java :nnoremap <silent> <buffer> <leader>s :JavaSearchContext<cr>
    autocmd FileType java :nnoremap <silent> <buffer> <leader>c :JavaCorrect<cr>
    autocmd FileType java :nnoremap <silent> <buffer> <leader>v :Validate<cr>
    autocmd FileType java :nnoremap <silent> <buffer> <leader>jc :call JCommentWriter()<cr>
    autocmd FileType java let b:jcommenter_class_author='Ryan Wooden, 100079872'
    autocmd FileType java let b:jcommenter_file_author='Ryan Wooden, 100079872'
augroup END

function! EnableEclim()
    if exists("g:EclimDisabled")
        unlet g:EclimDisabled
        runtime! plugin/eclim.vim
        " HACK!!!!!
python << EOF
import vim
ft = vim.eval("&ft")
vim.command("set ft=%s" % ft)
EOF
    endif
endfunction

"let g:EclimNailgunClient = 'external'
let g:EclimPythonValidate = 1
let g:EclimBrowser = 'firefox'
let g:EclimEclipseHome = $HOME . '/src/eclipse'
let g:EclimTaglistEnabled = 0

command! EclimStart silent !eclipse &> /dev/null &
command! PR ProjectRefresh
command! EclimEnable call EnableEclim()
" Only enable eclim for filtypes listed here!
"autocmd FileType java EnableEclim

" ------------------------------------------------------------- }}}

" Taglist Stuff
let tlist_objc_settings = 'objc;P:protocol;i:interface;I:implementation;M:instance method;C:implementation method;Z:protocol method'

" TlistToo stuff ----------------------------------------------- {{{
let Tlist_Auto_Open = 0
let g:Tlist_Process_File_Always = 1
let g:Tlist_Exit_OnlyWindow = 1
let g:Tlist_Show_One_File = 0

" ----------------------------------------------------------------- }}}

" }}}

"  Includes ------------------------------- {{{
if has("unix")
    let s:uname = system("echo -n `uname`")
    if s:uname == "Darwin"
        runtime osx.vimrc
    else
        runtime linux.vimrc
    endif
elseif has("macunix")
    runtime osx.vimrc
elseif has("win32")
    runtime win.vimrc
endif
" ---------------------------------------------- }}}
