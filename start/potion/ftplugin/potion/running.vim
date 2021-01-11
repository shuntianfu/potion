
if !exists("g:potion_command")
    let g:potion_command = "potion"
endif

function! PotionComplieAndRunFile()
    silent !clear
    execute "!" . g:potion_command . " " . bufname("%")
endfunction

nnoremap <localleader>r :call PotionComplieAndRunFile()<cr>


nnoremap <localleader>b :call PotionShowBytecode()<cr>

function! PotionShowBytecode()
    silent !clear
    " Get the bytecode.
    let bytecode = system(g:potion_command . " " . "-c -V" . " " . bufname("%"))
    " Open a new split and set it up.
    vsplit __Potion__Bytecode__
    normal! ggdG
    setlocal filetype=potionbytecode
    setlocal buftype=nofile
    " Insert the bytecode.
    call append(0, split(bytecode, '\v\n'))
endfunction
