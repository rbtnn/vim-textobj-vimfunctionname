
if exists('g:loaded_textobj_vimfunctionname')
	finish
endif

call textobj#user#plugin('vimfunctionname', {
	\ '-' : {
	\        '*sfile*': expand('<sfile>:p'),
	\        'select-a': 'a' .. get(g:, 'vim_textobj_vimfunctionname_mapping', 'vf'),
	\        'select-i': 'i' .. get(g:, 'vim_textobj_vimfunctionname_mapping', 'vf'),
	\        'select-a-function': 's:select_vimfunctionname_a',
	\        'select-i-function': 's:select_vimfunctionname_i'
	\   }
	\ })

function! s:select_vimfunctionname_a()
	let line = getline('.')
	let xs = split(line, '\zs')
	let pairs = textobj#vimfunctionname#parse(xs)
	let col = col('.')

	for pair in pairs
		if (col < pair.begin_col) || ((pair.begin_col <= col) && (col <= pair.end_col))
			return ['v', [0, line('.'), pair.begin_col, 0], [0, line('.'), pair.end_col + 1, 0]]
		endif
	endfor

	return 0
endfunction

function! s:select_vimfunctionname_i()
	let line = getline('.')
	let xs = split(line, '\zs')
	let pairs = textobj#vimfunctionname#parse(xs)
	let col = col('.')

	for pair in pairs
		if (col < pair.begin_col) || ((pair.begin_col <= col) && (col <= pair.end_col))
			return ['v', [0, line('.'), pair.begin_col, 0], [0, line('.'), pair.end_col, 0]]
		endif
	endfor

	return 0
endfunction

let g:loaded_textobj_vimfunctionname = 1

