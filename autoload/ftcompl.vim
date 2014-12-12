let s:save_cpo = &cpo
set cpo&vim

" cache of candidates
let s:cache = []

function! s:globlist(pattern)
	if v:version < 704
		" potentially insecure if filename contains newlines
		return split(glob(a:pattern), '\n')
	else
		" glob as list is the feature from v7.4
		return glob(a:pattern, 1, 1)
	endif
endfunction

function! s:globdirs(dirs)
	let l:files = []
	for l:dir in a:dirs
		let l:files += s:globlist(l:dir.'/*.vim')
	endfor
	return l:files
endfunction

function! ftcompl#filetypes(dirs)
	if empty(s:cache)
		let s:cache = map(copy(s:globdirs(a:dirs)), 'matchstr(v:val, ''\w\+\(\.vim$\)\@='')')
	endif
	return s:cache
endfunction

function! ftcompl#completion(lead, cmd, pos)
	return filter(copy(ftcompl#filetypes(g:ftcompl_dirs)), "v:val =~ '^".a:lead."'")
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

