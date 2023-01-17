inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

let g:copilot_no_tab_map = v:true

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>\<c-r>=coc#on_enter()\<CR>"
nnoremap gd <Plug>(coc-definition)
                              " \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <TAB>
          \ coc#pum#visible() ? coc#pum#next(1):
          \ exists('b:_copilot.suggestions') ? copilot#Accept("\<CR>") :
          \ CheckBackSpace() ? "\<Tab>" :
          \ coc#refresh()

inoremap <silent><expr> <S-TAB>
          \ coc#pum#visible() ? coc#pum#prev(1):
          \ exists('b:_copilot.suggestions') ? copilot#Accept("\<CR>") :
          \ CheckBackSpace() ? "\<Tab>" :
          \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
