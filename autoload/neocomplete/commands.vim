"=============================================================================
" FILE: commands.vim
" AUTHOR: Shougo Matsushita <Shougo.Matsu@gmail.com>
" Last Modified: 24 Dec 2013.
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================

let s:save_cpo = &cpo
set cpo&vim

function! neocomplete#commands#_initialize() "{{{
  command! -nargs=1 NeoCompleteAutoCompletionLength
        \ call s:set_auto_completion_length(<args>)
endfunction"}}}

function! neocomplete#commands#_toggle_lock() "{{{
  if neocomplete#get_current_neocomplete().lock
    echo 'neocomplete is unlocked!'
    call neocomplete#commands#_unlock()
  else
    echo 'neocomplete is locked!'
    call neocomplete#commands#_lock()
  endif
endfunction"}}}

function! neocomplete#commands#_lock() "{{{
  let neocomplete = neocomplete#get_current_neocomplete()
  let neocomplete.lock = 1
endfunction"}}}

function! neocomplete#commands#_unlock() "{{{
  let neocomplete = neocomplete#get_current_neocomplete()
  let neocomplete.lock = 0
endfunction"}}}

function! neocomplete#commands#_clean() "{{{
  " Delete cache files.
  for directory in filter(neocomplete#util#glob(
        \ g:neocomplete#data_directory.'/*'), 'isdirectory(v:val)')
    for filename in filter(neocomplete#util#glob(directory.'/*'),
          \ '!isdirectory(v:val)')
      call delete(filename)
    endfor
  endfor

  echo 'Cleaned cache files in: ' . g:neocomplete#data_directory
endfunction"}}}

function! neocomplete#commands#_set_file_type(filetype) "{{{
  let neocomplete = neocomplete#get_current_neocomplete()
  let neocomplete.context_filetype = a:filetype
endfunction"}}}

function! s:rand(max) "{{{
  if !has('reltime')
    " Same value.
    return 0
  endif

  let time = reltime()[1]
  return (time < 0 ? -time : time)% (a:max + 1)
endfunction"}}}

function! s:set_auto_completion_length(len) "{{{
  let neocomplete = neocomplete#get_current_neocomplete()
  let neocomplete.completion_length = a:len
endfunction"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
