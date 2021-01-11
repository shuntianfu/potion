if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1
setlocal foldmethod=expr
setlocal foldexpr=GetPotionFold(v:lnum)
setlocal tabstop=4 shiftwidth=4 expandtab

function! GetPotionFold(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
	return '-1'
    endif

    let this_indent = IndentLevel(a:lnum)
    let next_indent = IndentLevel(NextNonBlankLine(a:lnum))

    if next_indent == this_indent
	return this_indent
    elseif next_indent < this_indent
	return this_indent
    elseif next_indent > this_indent
	return '>' . next_indent
    endif
endfunction

function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction

function! NextNonBlankLine(lnum)
    let numlines = line("$")
    let current = a:lnum + 1
    while current <= numlines
	if getline(current) =~? "\v\S"
	    return current
	endif

	let current += 1
    endwhile

    return -2
endfunction




