
function! textobj#vimfunctionname#parse(xs) abort
	let pairs = []
	let last = len(a:xs) - 1
	let j = 0
	while j <= last
		let k = s:parse_scope(a:xs, j)
		if -1 == k
			let k = s:parse_dict(a:xs, j)
		endif
		if -1 == k
			let k = s:parse_global(a:xs, j)
		endif
		if -1 == k
			let k = s:parse_buildin(a:xs, j)
		endif
		if -1 == k
			let k = s:parse_autoload(a:xs, j)
		endif
		if -1 != k
			let pairs += [{
				\ 'begin_col' : len(join(a:xs[:j] ,'')),
				\ 'end_col' : len(join(a:xs[:k], '')),
				\ }]
			let j = k + 1
		else
			let j += 1
		endif
	endwhile
	return pairs
endfunction



function! s:parse_scope(xs, j) abort
	let j = a:j
	let k = j + 1
	if !s:starts_with_function_name(a:xs, j)
		return -1
	endif
	" :h variable-scope
	if join(a:xs[j:], '') =~# '^s:'
		let k += 1
		while get(a:xs, k, '') =~# '[a-zA-Z0-9_]'
			let k += 1
		endwhile
		if (2 < k - j) && (get(a:xs, k, '') == '(')
			return k - 1
		endif
	endif
	return -1
endfunction

function! s:parse_dict(xs, j) abort
	let j = a:j
	let k = j + 1
	if !s:starts_with_function_name(a:xs, j)
		return -1
	endif
	if a:xs[j] =~# '[a-zA-Z0-9_]'
		while (get(a:xs, k, '') =~# '[a-zA-Z0-9_]') || ((get(a:xs, k - 1, '') != '.') && (get(a:xs, k, '') == '.'))
			let k += 1
		endwhile
		if (2 < k - j) && (join(a:xs[j:(k - 1)], '') =~# '.') && (get(a:xs, k - 1, '') != '.') && (get(a:xs, k, '') == '(')
			return k - 1
		endif
	endif
	return -1
endfunction

function! s:parse_global(xs, j) abort
	let j = a:j
	let k = j + 1
	if !s:starts_with_function_name(a:xs, j)
		return -1
	endif
	if a:xs[j] =~# '[A-Z]'
		while get(a:xs, k, '') =~# '[a-zA-Z0-9_]'
			let k += 1
		endwhile
		if get(a:xs, k, '') == '('
			return k - 1
		endif
	endif
	return -1
endfunction

function! s:parse_buildin(xs, j) abort
	let j = a:j
	let k = j + 1
	if !s:starts_with_function_name(a:xs, j)
		return -1
	endif
	if a:xs[j] =~# '[a-zA-Z0-9_]'
		while get(a:xs, k, '') =~# '[a-zA-Z0-9_]'
			let k += 1
		endwhile
		if exists('?' .. join(a:xs[j:(k - 1)], '')) && (get(a:xs, k, '') == '(')
			return k - 1
		endif
	endif
	return -1
endfunction

function! s:parse_autoload(xs, j) abort
	let j = a:j
	let k = j + 1
	if !s:starts_with_function_name(a:xs, j)
		return -1
	endif
	if a:xs[j] =~# '[a-zA-Z0-9_]'
		while get(a:xs, k, '') =~# '[a-zA-Z0-9_#]'
			let k += 1
		endwhile
		if (join(a:xs[j:(k - 1)], '') =~# '#') && (get(a:xs, k, '') == '(')
			return k - 1
		endif
	endif
	return -1
endfunction

function! s:starts_with_function_name(xs, j) abort
	if (0 < a:j) && (a:xs[a:j - 1] =~# '[a-zA-Z0-9_]')
		return v:false
	else
		return v:true
	endif
endfunction

