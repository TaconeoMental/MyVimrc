" Duh
set encoding=utf-8

" Me parece más cómodo que \
let mapleader=","

""" Inicio de configuración Vundle
" Requeridos para Vundle
set nocompatible

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle bootstrap
Plugin 'VundleVim/Vundle.vim'

" Collorschemes
Plugin 'tomasr/molokai'
Plugin 'lu-ren/SerialExperimentsLain'

" General
Plugin 'preservim/nerdtree'
Plugin 'itchyny/lightline.vim'
Plugin 'yuttie/comfortable-motion.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'matze/vim-move'

" Programación general
Plugin 'metakirby5/codi.vim'

" Python
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'vim-python/python-syntax'
Plugin 'davidhalter/jedi-vim'

" Ruby
Plugin 'vim-ruby/vim-ruby'

" Arduino
Plugin 'sudar/vim-arduino-syntax'

" Go
Plugin 'fatih/vim-go'

call vundle#end()            " required
filetype plugin indent on    " required

syntax on
colorscheme molokai

""" Configuración de python-syntax
let g:python_highlight_all = 1

""" Configuración de jedi-vim
" Con librerías muy grandes se demora unaeternidad en cargar todas las
" variables al poner un punto. Prefiero no tenerlo y activarlo manualmente.
let g:jedi#popup_on_dot = 0

" Porque me gusta esta funcion y <leader>n lo tengo mapeado para NERDTree
let g:jedi#usages_command = "<leader>u"

" Esta no es específica de jedi, sino de completeopt, pero jedi-vim la
" inicializa en su ftplugin y hace que con cada completación me muestre la
" documentación arriba. Suena interesante, pero la verdad no lo uso.
autocmd FileType python setlocal completeopt-=preview

""" Configuración para Codi
let g:codi#interpreters = {
   \ 'python': {
       \ 'bin': 'python3',
       \ 'prompt': '^\(>>>\|\.\.\.\) ',
       \ },
   \ }
let g:codi#width = 70

""" Configuración de indentLine
let g:indentLine_char = '¦'

""" Configuración de NERDTree
" Se abre siempre con vim y lleva el focus al archivo
" También actualiza lightline porque hay un bug cuando se usan estos dos juntos
autocmd VimEnter * NERDTree | wincmd p | call lightline#update()

" Si NERDTree es la última ventana abierta, la cerramos
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

nnoremap <leader>n :NERDTreeFocus<CR>

""" Configuración de vim-move
let g:move_key_modifier = 'S'

""" Configuración general
" No mostrar el modo de edición actual
set noshowmode

" Shortcuts para navegar entre splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Splits más naturales: hacia la derecha y hacia abajo
set splitbelow
set splitright

" PEP8 es para ñoños
autocmd FileType python setlocal cc=80

" Para no usar el scroll del mouse
set guioptions-=r " chao scrollbar
set guioptions-=R " chao scrollbar en vsplits
set guioptions-=l " chao scrollbar izquierdo
set guioptions-=L " chao scrollbar izquierdo en vsplits

" Sé que se ve feo, pero creo que la única forma decente de ajustar el tamaño
" de los splits es con el mouse
function! ToggleMouse()
    if &mouse == 'n'
        set mouse=
    else
        set mouse=n
    endif
endfunc
nnoremap <F3> :call ToggleMouse()<CR>

" Una de mis cosas favoritas para moverme eficientemente
" Numeros relativos solo en el buffer actual
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set number relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Eliminar trailing whitespace al guardar el archivo
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre *.[ch] %s/\%$/\r/e

" Mostrar posición del cursor
set ruler

" Debería ser default
set visualbell

" Whitespace
set textwidth=79
set tabstop=4
set expandtab

" Bloqueo el uso de las flechas para moverse >:(
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" No me gusta usar <esc> para salir de los modos, así que lo mapeo a jj.
inoremap jj <esc>
vnoremap jj <esc><esc>
