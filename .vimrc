set guicursor=a:blinkon0
"colorscheme murphy
colorscheme elflord

set hlsearch
set autoindent
set tabstop=3
set shiftwidth=3
set whichwrap=h,l,[,]
set backspace=2
" Ignorera case i s�kningar, men bara om s�kningen �r bara lowercase. (\C overridar)
set ignorecase
set smartcase
set showcmd
set scrolloff=17
syntax on
" % f�r g�rna tro p� <> oxo
set matchpairs+=<:>
" Anv�nd syntax highlighting f�r att se skillnad p� tab och space.
" �ven saker f�rbi tkn80 och mellanslag sist p� rader.
" Av ngn anledning f�r Over80 alltid prioritet �ver EndSpace.
" (Varf�r �r dom ens exklusiva?)
syn match Tab "\t"
"syn match Over80 /\%81v.*/
syn match EndSpace / *$/
hi def Tab      ctermbg=darkblue guibg=#000060
hi def Over80   ctermfg=yellow   guifg=#ffffcc
hi def EndSpace ctermbg=blue     guibg=#0000ff
" Kopiera indentering exakt. (Default ers�tter space med tab "n�r det g�r", vilket oftast �r fel.
set copyindent

set viminfo='100,\"1000,:200,%,n~/.viminfo
function! ResCur()
	if line("'\"") <= line("$")
		normal! g`"
		return 1
	endif
endfunction

augroup resCur
	autocmd!
	autocmd BufWinEnter * call ResCur()
augroup END

" Change buffer using alt + arrow
nmap <esc>[1;3A <C-w><esc>OA
nmap <esc>[1;3B <C-w><esc>OB
nmap <esc>[1;3C <C-w><esc>OC
nmap <esc>[1;3D <C-w><esc>OD

" Change buffer using alt + arrow while in insert mode
imap <esc>[1;3A <C-O><C-w><esc>OA
imap <esc>[1;3B <C-O><C-w><esc>OB
imap <esc>[1;3C <C-O><C-w><esc>OC
imap <esc>[1;3D <C-O><C-w><esc>OD

nmap <esc>[c $
nmap <esc>[d 0

imap <esc>[c <C-O>$
imap <esc>[d <C-O>0

nmap <esc>[1;5C w
nmap <esc>[1;5D b

imap <esc>[1;5C <C-O>w
imap <esc>[1;5D <C-O>b

nmap <esc>Oc w
nmap <esc>Od b
imap <esc>Oc <C-O>w
imap <esc>Od <C-O>b

nmap <esc>[1;4C / <CR>
nmap <esc>[1;4D ? <CR>
nmap <esc>[1;8C / <CR>
nmap <esc>[1;8D ? <CR>
imap <esc>[1;4C <C-O>/ <CR>
imap <esc>[1;4D <C-O>? <CR>
imap <esc>[1;8C <C-O>/ <CR>
imap <esc>[1;8D <C-O>? <CR>

nmap <esc><esc>[c / <CR>
nmap <esc><esc>[d ? <CR>
imap <esc><esc>[c <C-O>/ <CR>
imap <esc><esc>[d <C-O>? <CR>

" inoremap        (  ()<Left>
" inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
"
" inoremap        {  {}<Left>
" inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
"
" inoremap        [  []<Left>
" inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
"
" inoremap        [  []<Left>
" inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
"
" inoremap        <  <><Left>
" inoremap <expr> >  strpart(getline('.'), col('.')-1, 1) == ">" ? "\<Right>" : ">"


nmap <tab> gt

autocmd BufEnter *.rb    source ~/.vim/rb.vim
autocmd BufEnter *.sql   source ~/.vim/sql.vim
autocmd BufEnter *.rhtml source ~/.vim/rhtml.vim
autocmd BufEnter *.scss  source ~/.vim/scss.vim
autocmd BufEnter *.php   source ~/.vim/php.vim

:command Wq %s/\s*$// | wq
:command WQ %s/\s*$// | wq
:command W %s/\s*$// | w
:command Q q

