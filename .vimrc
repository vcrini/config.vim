set nocompatible
"for using vundle
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'vim-scripts/ack.vim'
Bundle 'VimClojure'
Bundle 'Syntastic'
Bundle 'taglist.vim'
Bundle 'Puppet-Syntax-Highlighting'
Bundle 'Python-mode-klen'
"Bundle 'Decho'

filetype plugin indent on  
"end of vundle configuration

set history=2000
syn on
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
set wildmode=longest,list

" Able perl -c on sourcefile
compiler! perl
set number
set hidden
set backupdir=~/.backupdir,/tmp
set directory=~/.backupdir,/tmp

"for clojure
let g:vimclojure#HighlightBuiltins = 1
let g:vimclojure#ParenRainbow = 1
let vimclojure#WantNailgun = 1

vmap ,px !xmllint --format -<CR>
vmap ,pr !xmllint --format --recover -<CR>

"encoding for url purpose
map ,pd  <Esc>:%! decode.pl<CR>
map ,pdv <Esc>:'<,'>! decode.pl<CR>
map ,pe  <Esc>:%! encode.pl<CR>
map ,pev <Esc>:'<,'>! encode.pl<CR>
map ,ps  ml ,pt 'l<Esc>:w <CR>
augroup pythononly
autocmd!
autocmd FileType python call MyPythonSettings()
augroup end

"nice perl code
augroup perlonly
autocmd!
autocmd FileType perl call MyPerlSettings()
augroup end
	
"nice c code
augroup conly
autocmd!
autocmd FileType c call MyCSettings()
augroup end


function MyPythonSettings()
    set noai
    " set mappings...
    map ,pt  <Esc>:%! ~/Dropbox/personale.git/src/bin/pythontidy<CR>
endfunction

function MyPerlSettings()
    set noai
    map ,pt  <Esc>:%! perltidy<CR>
    map ,ptv <Esc>:'<,'>! perltidy<CR>
endfunction

function MyCSettings()
    set noai
    " set mappings...
    map ,pt  <Esc>:%! astyle<CR>
endfunction
colorscheme blue

let g:syntastic_check_on_open=1
let g:syntastic_perl_checkers = ['perlcritic']
"let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_always_populate_loc_list=1
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
" Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

let g:lasttab = 1
nmap <Leader>gt :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
let g:pymode_lint_write = 0
let g:pymode_folding = 0
let g:pymode_lint_ignore = "E501"

