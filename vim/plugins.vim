
"""""""""""""""""""""""""""""""
"插件管理，使用vim-plug。 https://github.com/junegunn/vim-plug
"""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
"Plug 'morhetz/gruvbox' "主题
Plug 'kaicataldo/material.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
"markdown预览插件
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

Plug 'itchyny/lightline.vim'
" Initialize plugin system
if has('nvim')
	Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
	Plug 'Shougo/defx.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'
" 注释插件
Plug 'scrooloose/nerdcommenter'
Plug 'neoclide/vim-jsx-improve', { 'for': ['javascript', 'typescript'] }
" 自动补充括号的插件
Plug 'raimondi/delimitMate'
" git 插件
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" 欢迎主页插件
Plug 'mhinz/vim-startify'

call plug#end()

"========= coc
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

let g:coc_global_extensions = [
			\'coc-snippets',
			\'coc-lists',
			\'coc-yank',
			\'coc-json',
			\'coc-tsserver',
			\'coc-json',
			\'coc-highlight',
			\'coc-reason'
			\]
vmap <C-j> <Plug>(coc-snippets-select)
imap <C-j> <Plug>(coc-snippets-expand-jump)
nmap <silent> <leader>h :call CocAction('doHover')<CR>
command! OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <f2> <Plug>(coc-rename)

nnoremap <leader>f :CocList --auto-preview grep<space>
nnoremap <leader>r :CocList --auto-preview outline<CR>
" Remap for format selected region
xmap <leader>fm  <Plug>(coc-format-selected)
nmap <leader>fm  <Plug>(coc-format-selected)
" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>fi  <Plug>(coc-fix-current)

nnoremap <silent> <leader>p :CocList files<CR>
nnoremap <silent> <leader>b :CocList buffers<CR>
nnoremap <silent> <leader>y :CocList -A --normal yank<cr>
nnoremap <silent> <leader>gf :exe 'CocList --auto-preview grep '.expand('<cword>')<CR>
nnoremap <silent> <leader>cw :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>


" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

"===== lightline
let g:lightline = {
			\ 'colorscheme': 'wombat',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'cocstatus', 'currentfunction', 'currentBranch', 'readonly', 'f  ilename', 'modified' ] ]
			\ },
			\ 'component_function': {
			\   'cocstatus': 'coc#status',
			\   'currentfunction': 'LightlineGitBlame',
			\   'currentBranch': 'fugitive#head',
			\ },
			\ }

function! LightlineGitBlame() abort
	let blame = get(b:, 'coc_git_blame', '')
	" return blame
	return winwidth(0) > 120 ? blame : ''
endfunction

"===== defx 配置
map <silent> - :Defx -columns=git:indent:icons:filename:type<CR>
call defx#custom#option('_', {
			\ 'winwidth': 40,
			\ 'split': 'vertical',
			\ 'direction': 'botright',
			\ 'show_ignored_files': 0,
			\ 'buffer_name': 'tree',
			\ 'toggle': 1,
			\ 'resume': 1
			\ })
autocmd FileType defx call s:defx_my_settings()

function! s:defx_my_settings() abort
	nnoremap <silent><buffer><expr> <CR>
				\ defx#is_directory() ?
				\ defx#do_action('open_or_close_tree') :
				\ defx#do_action('drop',)
	nmap <silent><buffer><expr> <2-LeftMouse>
				\ defx#is_directory() ?
				\ defx#do_action('open_or_close_tree') :
				\ defx#do_action('drop',)
	" 目录定位到当前文件位置
	nnoremap <silent><leader>dc :Defx<CR> :<C-u>:Defx -columns=git:indent:icons:filenam  e:type -search=`expand('%:p')` `getcwd()`<CR> <c-w>l<CR>

	nnoremap <silent><buffer><expr> s defx#do_action('drop', 'split')
	nnoremap <silent><buffer><expr> v defx#do_action('drop', 'vsplit')
	nnoremap <silent><buffer><expr> t defx#do_action('drop', 'tabe')
	nnoremap <silent><buffer><expr> o defx#do_action('open_tree')
	nnoremap <silent><buffer><expr> O defx#do_action('open_tree_recursive')
	nnoremap <silent><buffer><expr> C defx#do_action('copy')
	nnoremap <silent><buffer><expr> P defx#do_action('paste')
	nnoremap <silent><buffer><expr> M defx#do_action('rename')
	nnoremap <silent><buffer><expr> D defx#do_action('remove_trash')
	nnoremap <silent><buffer><expr> A defx#do_action('new_multiple_files')
	nnoremap <silent><buffer><expr> U defx#do_action('cd', ['..'])
	nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
	nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select')
	nnoremap <silent><buffer><expr> R defx#do_action('redraw')
endfunction

" Defx git
let g:defx_git#indicators = {
			\ 'Modified'  : '✹',
			\ 'Staged'    : '✚',
			\ 'Untracked' : '✭',
			\ 'Renamed'   : '➜',
			\ 'Unmerged'  : '═',
			\ 'Ignored'   : '☒',
			\ 'Deleted'   : '✖',
			\ 'Unknown'   : '?'
			\ }
let g:defx_git#column_length = 0
hi def link Defx_filename_directory NERDTreeDirSlash
hi def link Defx_git_Modified Special
hi def link Defx_git_Staged Function
hi def link Defx_git_Renamed Title
hi def link Defx_git_Unmerged Label
hi def link Defx_git_Untracked Tag
hi def link Defx_git_Ignored Comment

" Defx icons
" Requires nerd-font, install at https://github.com/ryanoasis/nerd-fonts or
" brew cask install font-hack-nerd-font
" Then set non-ascii font to Driod sans mono for powerline in iTerm2
" disbale syntax highlighting to prevent performence issue
let g:defx_icons_enable_syntax_highlight = 1

" vim-jsx-improve
let g:jsx_improve_motion_disable = 1

" 拷贝当前文件路径
function GetCurFileRelativePath()
	let cur_file_name=getreg('%')
	echo "copy      ".cur_file_name."         done"
	call setreg('+',cur_file_name)
endfunction

function GetCurFileAbsoultePath()
	let cur_dir=getcwd()
	let cur_file_name=getreg('%')
	let dir_filename=cur_dir."".cur_file_name
	echo "copy      ".dir_filename."         done"
	call setreg('+',dir_filename)
endfunction

nnoremap <silent><f9> :call GetCurFileRelativePath()<cr>
nnoremap <silent><f8> :call GetCurFileRelativePath()<cr>
" 注释插件配置
let NERDSpaceDelims=1

let g:startify_lists = [
			\ { 'type': 'files',     'header': ['   MRU']            },
			\ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
			\ { 'type': 'sessions',  'header': ['   Sessions']       },
			\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
			\ { 'type': 'commands',  'header': ['   Commands']       },
			\ ]


nnoremap <leader>cd :cd ~/Documents/workspace/gitspace/bear-web<cr>

" 禁止提示
let g:coc_disable_startup_warning = 1



" 设置主题
"colorscheme gruvbox
"let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker'
let g:material_theme_style = 'palenight'
let g:lightline = { 'colorscheme': 'material_vim' }
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif
if (has('termguicolors'))
  set termguicolors
endif
colorscheme material
