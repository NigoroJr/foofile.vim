if !exists('g:foofiles_path')
  let g:foofiles_path = $HOME . '/.foofiles'
endif

if !exists('g:foofiles_split')
  let g:foofiles_split = 0
endif

command! -nargs=? -complete=customlist,foofile#complete FooFile call foofile#new_foofile(<q-args>)
command! -nargs=? -complete=customlist,foofile#complete FooFileDelete call foofile#delete_foofiles(<q-args>)
command! -nargs=? -complete=customlist,foofile#complete FooFileLast call foofile#open_last(<q-args>)
command! -nargs=1 -complete=file FooFileSaveAs call foofile#save_as(<q-args>)
