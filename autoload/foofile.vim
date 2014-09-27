let s:save_cpo = &cpo

" Some filetypes and corresponding extensions
let s:filetype_extensions = {
      \ 'c': 'c',
      \ 'cpp': 'cpp',
      \ 'perl': 'pl',
      \ 'python': 'py',
      \ 'ruby': 'rb',
      \ 'text': 'txt',
      \ }

" Returns the parent directory for a foo file with the given filetype.
function! s:get_parent_dir(filetype)
  return printf('%s/%s', expand(g:foofiles_path), a:filetype)
endfunction

" Splits the buffer and creates a new buffer according to the given direction.
" 0 => Don't split
" 1 => Split horizontally
" 2 => Split vertically
function! s:split_buffer(direction)
  if a:direction == 1
    new
  elseif a:direction == 2
    vnew
  end
endfunction

" Returns the filename of the foo file according to the filetype.
" Uses a:filetype as the extension if no entry is found in dictionary.
function! s:get_filename(filetype)
  let l:extension = a:filetype
  if has_key(s:filetype_extensions, a:filetype)
    let l:extension = s:filetype_extensions[a:filetype]
  endif

  return strftime('%Y%m%d%H%M%S') . '.' . l:extension
endfunction

" Creates a foo file. If no filetype is given, current filetype is used.
function! foofile#new_foofile(filetype)
  let l:filetype = a:filetype
  if a:filetype == ''
    let l:filetype = &ft
  endif

  let l:parent_dir = s:get_parent_dir(l:filetype)
  " Create directory if it doesn't exist
  if !isdirectory(l:parent_dir)
    call mkdir(l:parent_dir, "p")
  endif

  let l:foofile_path = printf('%s/%s',
        \ l:parent_dir, s:get_filename(l:filetype))

  " Split if necessary
  call s:split_buffer(g:foofiles_split)

  execute 'edit' l:foofile_path
endfunction

" Opens the last foo file edited. If no filetype is given, current filetype is
" used.
function! foofile#open_last(filetype)
  let l:filetype = a:filetype
  if a:filetype == ''
    let l:filetype = &ft
  endif

  let l:foofiles = reverse(sort(split(glob(s:get_parent_dir(l:filetype) . '/*'), '\n')))
  if len(l:foofiles) > 0
    call s:split_buffer(g:foofiles_split)
    execute 'edit' l:foofiles[0]
  else
    echo 'No file found for file type ' . l:filetype
  endif
endfunction

" Deletes all foo files
function! foofile#delete_foofiles(filetype)
  if a:filetype == '' && 
        \ input('Are you sure you want to delete all? (y/n) ') == 'y'
    call map(split(glob(g:foofiles_path . '/*'), '\n'), 'delete(v:val)')
  elseif input(printf('Delete all %s files? (y/n) ', a:filetype)) == 'y'
    " Remove filetype
    call map(split(glob(s:get_parent_dir(a:filetype) . '/*'), '\n'), 'delete(v:val)')
  else
    return
  end
endfunction

function! foofile#complete(arglead, cmdline, cursorpos)
  let l:dirs = split(glob(g:foofiles_path . '/*'), '\n')
  call map(l:dirs, 'fnamemodify(v:val, ":t")')

  return filter(l:dirs, 'stridx(v:val, a:arglead) == 0')
endfunction

let &cpo = s:save_cpo
unlet! s:save_cpo

" vim: et:tw=78
