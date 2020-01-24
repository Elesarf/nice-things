set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'morhetz/gruvbox'
" User defined plugins
Plugin 'SirVer/ultisnips'                                                     
Plugin 'honza/vim-snippets'                                                    
Plugin 'scrooloose/nerdtree'
Plugin 'Rip-Rip/clang_complete'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'szw/vim-tags'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
set background=dark
colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_termcolors=16
" Put your non-Plugin stuff after this line
let g:clang_library_path='/usr/lib/llvm-6.0/lib/libclang.so.1'
set exrc
set secure
" Отступы пробелами, а не табуляциями
set expandtab
" Ширина строки 80 символов
set textwidth=120
" Ширина табуляции в колонках
set ts=2
" Количество пробелов (колонок) одного отступа
set shiftwidth=2
" Новая строка будет с тем же отступом, что и предыдущая
set autoindent
" Умная расстановка отступов (например, отступ при начале нового блока)
set smartindent

" Подсвечивать синтаксис
syntax on
" Указывать номера строк
set number
" Подсветить максимальную ширину строки
let &colorcolumn=&textwidth
" Цвет линии - тёмно-серый
highlight ColorColumn ctermbg=darkgray

" Игнорировать регистр при поиске                                               
set ic                                                                          
" Подсвечивать поиск                                                            
set hls                                                                         
" " Использовать последовательный поиск                                         
set is

" Включаем bash-подобное дополнение командной строки                            
set wildmode=longest:list,full
" Не делать все окна одинакового размера                                        
set noequalalways                                                               
" Высота окон по-умолчанию 20 строк                                             
set winheight=20

set statusline=%f%m%r%h%w\ %y\ enc:%{&enc}\ ff:%{&ff}\ fenc:%{&fenc}%=(ch:%3b\ hex:%2B)\ col:%2c\ line:%2l/%L\ [%2p%%]
set laststatus=2

autocmd filetype c,cpp set cin
autocmd filetype make set noexpandtab                                              
autocmd filetype make set nocin
autocmd filetype python set nocin

"Clang-completer                                                                
" Включить дополнительные подсказки (аргументы функций, шаблонов и т.д.)        
let g:clang_snippets=1                                                          
" Использоать ultisnips для дополнительных подскахок (чтобы подсказки шаблонов  
" автогенерации были в выпадающих меню)                                         
let g:clang_snippets_engine = 'ultisnips'                                       
" Периодически проверять проект на ошибки                                       
let g:clang_periodic_quickfix=1                                                 
" Подсвечивать ошибки                                                           
let g:clang_hl_errors=1
" Автоматически закрывать окно подсказок после выбора подсказки                 
let g:clang_close_preview=1                                              
" По нажатию Ctrl+F проверить поект на ошибки                                   
map <c-f> :call g:ClangUpdateQuickFix()<cr>

" NERDTree
" Открывать дерево по нажаить Ctrl+n
map <c-n> :NERDTreeToggle<cr>
" Немного магии, если мы запустим Vim без указания файла для редактирования,
" то дерево будет открыто, а если будет указан файл, то дерево 
" открыто не будет                                                   
autocmd StdinReadPre * let s:std_in=1                                           
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif     
" Открывать новые окна справа
set splitright

map <F4> [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
map ; :Buffers<CR>

