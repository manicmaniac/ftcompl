let s:save_cpo = &cpo
set cpo&vim

let s:filetypes = []

function! s:globdirs(dirs)
	let l:files = []
	for l:dir in a:dirs
		let l:files += glob(l:dir.'/*.vim', 1, 1)
	endfor
	return l:files
endfunction

function! ftcompl#filetypes(dirs)
	if empty(s:filetypes)
		let s:filetypes = map(copy(s:globdirs(a:dirs)), 'matchstr(v:val, ''\w\+\(\.vim$\)\@='')')
	endif
	return s:filetypes
endfunction

function! ftcompl#completion(lead, cmd, pos)
	return filter(copy(ftcompl#filetypes(g:ftcompl_dirs)), "v:val =~ '^".a:lead."'")
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

