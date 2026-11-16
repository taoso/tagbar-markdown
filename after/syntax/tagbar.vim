" Colour the markdown headings shown in the tagbar window by level.
"
" This lives in after/syntax/ so our matches are defined *after* tagbar's own
" syntax/tagbar.vim (TagbarScope/TagbarType/...). When two syntax items match
" the same text the one with the earlier start wins, so we match the whole
" heading line and only let \ze trim its tail.

if !exists('g:tagbar_markdown_h1_color')
  finish
endif

let s:colors = [
      \ g:tagbar_markdown_h1_color,
      \ g:tagbar_markdown_h2_color,
      \ g:tagbar_markdown_h3_color,
      \ g:tagbar_markdown_h4_color,
      \ g:tagbar_markdown_h5_color,
      \ g:tagbar_markdown_h6_color,
      \ ]

let s:icons = escape(join(get(g:, 'tagbar_iconchars', ['▸', '▾']), ''), ']^\-')

" Tagbar renders a heading as:  [indent][icon ]Title : hN
" The indentation and the fold icon are matched by the second pattern only,
" the fold icon itself is kept as TagbarFoldIcon.
for s:lvl in range(1, 6)
  execute 'highlight! TagbarMdHeading' . s:lvl . ' ' . s:colors[s:lvl - 1]
  execute 'syntax match TagbarMdHeading' . s:lvl
        \ . ' /\%(^\s*['
        \ . s:icons
        \ . '][ ]\?\)\@<=.\+\ze : h'
        \ . s:lvl
        \ . '$/ contains=TagbarFoldIcon'
  execute 'syntax match TagbarMdHeading' . s:lvl
        \ . ' /^\s*\%(['
        \ . s:icons
        \ . '][ ]\?\)\@!.*\ze : h'
        \ . s:lvl
        \ . '$/'
endfor

unlet s:colors s:icons s:lvl
