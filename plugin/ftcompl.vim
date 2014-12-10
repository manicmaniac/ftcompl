if exists('g:loaded_ftcompl')
	finish
endif
let g:loaded_ftcompl = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:ftcompl_dirs')
	let g:ftcompl_dirs = [expand('$VIMRUNTIME/syntax')]
endif

command! -complete=customlist,ftcompl#completion
			\ -nargs=1 SetFileType :setfiletype <args>
cabbrev sft SetFileType
cabbrev setf SetFileType

let &cpo = s:save_cpo
unlet s:save_cpo

