"定义$VIMFILES变量
if has('unix')
    let $VIMFILES = $HOME.'/.vim'
else
    let $VIMFILES = $VIM.'/vimfiles'
endif

if filereadable("~/.vimrc")
    source ~/.vimrc
endif

call pathogen#infect()
"使用pathogen管理插件

source ~/.vim/autoload/pathogen.vim
"source ~/.vim/autoload/zencoding.vim

let g:user_zen_expandabbr_key = '<c-y>,'
let g:use_zen_complete_tag = 1

" 插入模式下使用 <BS>、<Del> <C-W> <C-U>

set backspace=indent,eol,start

".vimrc编辑后自动生效,避免重启
autocmd! bufwritepost .vimrc source ~/.vimrc


" 启动后自动全屏

" 基础选项"{{{

" ---------------------------------------------------------------------

"设置mapleader键

let mapleader = ","

let g:mapleader = ","

map <silent> <leader>ss :source ~/.vimrc<cr>

"解决gb编码文件乱码

set encoding=gbk

set fileencodings=cp936,utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

set clipboard+=unnamed

set directory=~/tmp,/tmp

"安装了vimcdoc-1.8.0后可以启用中文帮助

set helplang=cn	"设置中文帮助

set encoding=utf-8	"打开uft-8文件不乱码

set history=500	"保留历史记录

set number	"显示行号

set scrolloff=6	"上下可视行数

set magic	"用于正则表达式

set dy=lastline	"尽可能显示更多的行，取代@@显示

set backspace=indent,eol,start	"设置退格删除

set nobackup	"无备份

set showmatch	"显示配对括号

set linespace=2	"行间距

set mouse=a	"设定在任何模式下鼠标都可用

set nocompatible	"不兼容vi模式

set linebreak	"整词换行

"set textwidth=80"设置每行80个字符自动换行，加上换行符

set wrap"设置自动折行
set whichwrap=b,s,<,>,[,]	"左右光标移动到头时可以自动下移
set autochdir	"自动切换当前目录为当前文件所在的目录

"关闭遇到错误时的声音提示
set noerrorbells
set novisualbell
set vb t_vb=

"代码折叠

:set fdm=marker	"对文中的标志折叠

"记录文件状态
autocmd BufWinLeave * if expand('%') != '' && &buftype == '' | mkview | endif
autocmd BufRead * if expand('%') != '' && &buftype == '' | silent loadview | endif

" 搜索时忽略大小写，但在有一个或以上大写字母时仍大小写敏感
set ignorecase
set smartcase

set incsearch	" 实时搜索
set hlsearch	" 搜索时高亮显示被找到的文本

"}}}


" 图形界面设置"{{{
" ---------------------------------------------------------------------
syntax enable
syntax on	"语法高亮
filetype plugin on	"打开文件类型检测
filetype plugin indent on	"打开文件类型检测

set showtabline=2	"显示标签
set cursorline	"高亮光标所在的行
set background=dark
"colorscheme molokai
colorscheme solarized

"使用solarized主题dark模式下自定义隐藏字符的颜色
"guifg为字符颜色,guibg为字符背景颜色
hi SpecialKey guifg=#003f53 guibg=#042b37


""""""""""""""""""""""""""""""
" => 状态栏
""""""""""""""""""""""""""""""
set showcmd
set laststatus=2 "黓认状态栏格式
set ruler

"hi StatusLine guifg=#FFFFFF guibg=#393939 gui=none

"if version >= 700
autocmd InsertEnter * hi StatusLine guifg=#393939 guibg=Grey gui=none
" autocmd InsertLeave * hi StatusLine guifg=#FFFFFF guibg=#393939 gui=none

" endif

" 获取当前目录
func! GetPWD()
    return substitute(getcwd(), "", "", "g")
endf

" 命令行于状态行
set cmdheight=1 " 设置命令行的高度
set laststatus=2 " 始终显示状态行
"set stl=\ [File]\ %F%m%r%h%y[%{&fileformat},%{&fileencoding}]\ %w\ \ [PWD]\ %r%{GetPWD()}%h\ %=\ [Line]%l/%L\ %=\[%P] "设置状态栏的信息
set statusline=\ File:\ [%F%m%r]%h\ \ \ CWD:%r[%{getcwd()}]%h\ \ \ [%{(&fenc==\"\")?&enc:&fenc}][%{&ff}][ASCII=\%03.3b/Hex=\%02.2B]\ %w\ \ \ Line:[%l/%L:%c]\ [%p%%]


" 区分终端和GUI界面"{{{

if has('gui_running')

	set guioptions-=T " 隐藏工具栏
	set guioptions-=m " 隐藏菜单栏
	set guioptions-=L " 隐藏左侧滚动条
	set showtabline=2 " 显示Tab栏
	set guioptions+=r	"显示gui右边滚动条

	"字体
	set guifont=Monaco:h12
	set lines=200 columns=180

	if has("gui_macvim")
		set imdisable "Set input method off
		lcd ~/Desktop/ "如果为空文件，则自动设置当前目录为桌面
		set autochdir "自动切换到文件当前目录

		" 清理菜单
		" aunmenu Window
		" aunmenu Tools
	endif
else
	set ambiwidth=single
	colorscheme molokai
	syntax enable
endif
"}}}

"}}}

" 按键绑定{{{

" 插入模式输入中文完毕回到普通模式时禁用输入法
se imd
au InsertEnter * se noimd
au InsertLeave * se imd
au FocusGained * se imd

"标签
nmap <C-t>   :tabnew<cr>
nmap <C-p>   :tabprevious<cr>
nmap <C-n>   :tabnext<cr>
nmap <C-k>   :tabclose<cr>
nmap <C-Tab> :tabnext<cr>

noremap <D-M-Left> :tabprevious<cr>
noremap <D-M-Right> :tabnext<cr>

map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>

" }}}


" 格式"{{{
" ---------------------------------------------------------------------
set autoindent		"自动缩进
set smartindent		"在一个新的语句块之后的行自动缩进到下一个级别

" 指定文件类型高亮
au BufNewFile,BufRead *.shtml setf html
au BufNewFile,BufRead *.less setf css

" 关于高亮
:let hs_highlight_delimiters=1            " 高亮定界符
:let hs_highlight_boolean=1               " 把True和False识别为关键字
:let hs_highlight_types=1                 " 把基本类型的名字识别为关键字
:let hs_highlight_more_types=1            " 把更多常用类型识别为关键字
:let hs_highlight_debug=1                 " 高亮调试函数的名字
:let hs_allow_hash_operator=1             " 阻止把#高亮为错误

"在切换到 normal,insert,search 模式时使用英文输入法
set noimdisable
set iminsert=0
set imsearch=0

"缩进相关的设置
set ts=4			"tabstop    制表符显示的位宽
set sw=4			"shiftwidth 自动缩进时，缩进尺寸为4个空格
set et				"编辑时将所有tab替换为空格
set smarttab		"删除空格时，不用按4次
set softtabstop=4	" 设置按BackSpace的时候可以一次删除掉4个空格

"用制表符表示缩进
set noexpandtab
set copyindent

"显示隐藏字符
set list
"set listchars=tab:"▸-\
"set listchars=tab:\|\ ,nbsp:%,trail:
set listchars=tab:\▸\ ,trail:.,extends:>,precedes:<

"匹配括号的规则，增加针对html的<>
set matchpairs=(:),{:},[:],<:>

" 去除结尾空格
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" 去掉结尾^M
nnoremap <leader>E :%s/

" ---
" 快捷键
" ---
"使用tab/shift+tab键控制缩进
nmap <tab> v>
nmap <s-tab> v<
vmap <tab> >gv
vmap <s-tab> <gv

"}}}

" 制表符
set tabstop=4
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4

set smarttab"删除空格时，不用按4次
set softtabstop=4" 设置按BackSpace的时候可以一次删除掉4个空格

"匹配括号的规则，增加针对html的<>
set matchpairs=(:),{:},[:],<:>

" ---
" 快捷键
" ---
"使用tab/shift+tab键控制缩进
nmap <tab> v>
nmap <s-tab> v<
vmap <tab> >gv
vmap <s-tab> <gv

"}}}


" 语法"{{{
" ---------------------------------------------------------------------

" 打开php折叠
let php_folding = 1

" 打开javascript折叠
let b:javascript_fold=1
" 打开javascript对dom、html和css的支持
let javascript_enable_domhtmlcss=1

"自动补全CSS
":imap <tab> <c-x><c-o>
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS

"自动补全括号
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap < <><ESC>i
:inoremap > <c-r>=ClosePair('>')<CR>

function ClosePair(char)
if getline('.')[col('.') - 1] == a:char
	return "\<Right>"
	else
		return a:char
	endif
endf

"自动补全
filetype on
au BufReadCmd *.jar,*.xpi,*.egg call zip#Browse(expand("<amatch>"))
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

autocmd FileType css set foldmethod=marker
autocmd FileType python setlocal et sta sw=4 sts=4

"}}}


" 插件"{{{
" ---------------------------------------------------------------------

"Plugin List:
"Powerline状态栏增强插件
""需要安装bundle/Powerline/fontpatcher目录下的dejiavu Powerline字体

let Powerline_symbols = 'compatible'
let g:Powerline_symbols = 'fancy'

"autoload/pathogen.vim插件管理器

"MatchTag显示配对的HTML标签

"mru.vim记录最近打开的文件(o在缓冲区打开,t在新标签打开)

""{{{

  let MRU_File = $VIMFILES.'/file/_vim_mru_files'
  let MRU_Max_Entries = 30"记忆最近打开的文件数量
  let MRU_Auto_Close = 1"窗口打开与关闭(0/1)
  nmap <leader>f :MRU<CR>

 "}}}


"snipMate智能补全
"The-NERD-Commenter快速注释
"superTabTab键补全
"{{{
"
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-N>"


" NERD tree
"nerdtree文件管理,使用,-n启动
"nmap ,n :NERDTreeToggle<CR>
nmap <Leader>t :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=1
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let Tlist_Process_File_Always=1
autocmd VimEnter * NERDTreeToggle
"}}}

"NeoComplCache自动补全

 ""{{{
   let g:neocomplcache_enable_at_startup = 1 "默认开启自动补全
 "}}}"

"vim-project项目管理插件,使用,-p启动
"nmap ,p :Project ~/.vim/file/_vimprojects
"_vimprojects为指定的文件路径

"xml.vim使用gg=G格式化html

"zencoding使用c-y-,转换
let g:user_zen_settings = {
 'php' : {
 'extends' : 'html',
 'filters' : 'c',
 },
 'xml' : {
 'extends' : 'html',
 },
 'haml' : {
 'extends' : 'html',
 },
}
noremap <C-Y> <C-R>
"inoremap <C-Y> <C-O><C-R>

"

" -未使用git同步的插件:

"vim-colors-solarized配色,提供light和dark两种模式

"after/syntax/css.vimCSS颜色高亮

"mark标记高亮单词,m

"load_template 新建文档模板插件,使用LoadTemplate
let g:template_path = $VIMFILES.'/template/'
"}}}

" TagList
"Exuberant ctags程序的位置
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
nmap <Leader>l :TlistToggle<CR>
let Tlist_Inc_Winwidth=1
"在右侧窗口打开
let Tlist_Use_Right_Window=1
"只显示当前文件的tag
"let Tlist_File_Fold_Auto_Close=1
"如果Taglist是最后一个窗口则退出vim
let Tlist_Exit_OnlyWindow = 1
let Tlist_Show_One_File = 1



source ~/.vim/bundle/php-doc.vim
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR>

nnoremap ,m :w <BAR> !lessc % > %:t:r.css<CR><space>
