"set showcmd             " show command in bottom bar
"set cursorline          " highlight current line
"filetype indent on      " load filetype-specific indent files
"set wildmenu            " eeeual autocomplete for command menu
"set showmatch           " highlight matching [{()}]
"set incsearch           " search as characters are entered
"set hlsearch            " highlight matches
"" turn off search highlight
"nnoremap <leader><space> :nohlsearch<CR>
"set foldenable          " enable folding
"set ruler 
"set autochdir
"set ignorecase smartcase
"set incsearch 
"set cmdheight=2
"set laststatus=2
"set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\

"====================================
"    FileName: .vimrc
"    Author:   hahaya
"    Version:  1.0.0
"    Email:    hahayacoder@gmail.com
"    Blog: http://hahaya.github.com
"    Date: 2013-7-23
"=============================================
"==================================
"    Vim基本配置
"===================================
"关闭vi的一致性模式 避免以前版本的一些Bug和局限
"使用自定义的方向键，插入功能使用h作为快捷键
map l <Right>
map k <Down>
map j <Left>
map i <Up>
map h <Insert>
"使用系统剪切板
set clipboard=unnamed
if has('gui_running')
      set background=dark
        colorscheme solarized
    else
        colorscheme molokai
endif
      set background=dark

set nocompatible
"配置backspace键工作方式
set backspace=indent,eol,start
"显示行号
set number
"设置在编辑过程中右下角显示光标的行列信息
set ruler
"当一行文字很长时取消换行
"set nowrap
"在状态栏显示正在输入的命令
set showcmd
"设置历史记录条数
set history=1000
"设置取消备份 禁止临时文件生成
set nobackup
set noswapfile
"突出现实当前行列
"set cursorline
"set cursorcolumn
"设置匹配模式 类似当输入一个左括号时会匹配相应的那个右括号
set showmatch
"设置C/C++方式自动对齐
set autoindent
set cindent
"开启语法高亮功能
syntax enable
syntax on
"指定配色方案为256色
set t_Co=256
"设置搜索时忽略大小写
set ignorecase
"设置在Vim中可以使用鼠标 防止在Linux终端下无法拷贝
set mouse=a
"设置Tab宽度
set tabstop=4
"设置自动对齐空格数
set shiftwidth=4
"设置按退格键时可以一次删除4个空格
set softtabstop=4
"设置按退格键时可以一次删除4个空格
set smarttab
"将Tab键自动转换成空格 真正需要Tab键时使用[Ctrl + V + Tab]
set expandtab
"设置编码方式
set encoding=utf-8
"自动判断编码时 依次尝试一下编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
"检测文件类型
filetype on
"针对不同的文件采用不同的缩进方式
filetype indent on
"允许插件
filetype plugin on
"启动智能补全
filetype plugin indent on

set nocompatible              " be iMproved, required
filetype off                  " required

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'VundleVim/Vundle.vim'
"powerlin
Plugin 'Lokaltog/vim-powerline'
set laststatus=2
set t_Co=256
let g:Powline_symbols='fancy'

"nerdtree
Plugin 'scrooloose/nerdtree'
autocmd vimenter * NERDTree | wincmd p
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
:hi Directory guifg=#FF0000 ctermfg=red
let g:NERDTreeWinSize = 25
:command Wd write|bdelete
"theme
let g:rehash256 = 1

"python IDE plugin
"代码缩进
Plugin 'vim-scripts/indentpython.vim'
"自动补全
Plugin 'davidhalter/jedi-vim'
"虚拟环境
"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
"语法检查/高亮
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
let python_highlight_all=1
syntax on
"配色方案
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'


call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
":PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
"auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"不可以使用鼠标激活visual
set mouse-=a

"程序编译快捷键
""""""""""""""""""""""    "Quickly Run    """"""""""""""""""""""    
map <F5>:call CompileRunGcc()<CR>    
    func! CompileRunGcc()        
        exec "w"        
        if &filetype == 'c'            
            exec "!g++ % -o %<"           
            exec "!time ./%<"        
        elseif &filetype == 'cpp'            
            exec "!g++ % -o %<"            
            exec "!time ./%<"        
        elseif &filetype == 'java'            
            exec "!javac %"            
            exec "!time java %<"        
        elseif &filetype == 'sh'            
            :!time bash %        
        elseif &filetype == 'python'            
            exec "!time python2.7 %"        
        elseif &filetype == 'html'            
            exec "!firefox % &"        
        elseif &filetype == 'go'    
            "exec "!go build %<"            
            exec "!time go run %"        
        elseif &filetype == 'mkd'            
            exec "!~/.vim/markdown.pl % > %.html &"            
            exec "!firefox %.html &"        
        endif    
    endfunc


" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za
 
Plugin 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1

" enable syntax highlighting
syntax enable

" show line numbers
set number

" set tabs to have 4 spaces
set ts=4

" indent when moving to the next line while writing code
set autoindent

" expand tabs into spaces
set expandtab

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" show a visual line under the cursor's current line
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" enable all Python syntax highlighting features
let python_highlight_all = 1

"auto-format
Plugin 'Chiel92/vim-autoformat'

