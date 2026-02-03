let s:save_cpo = &cpo
set cpo&vim

function! s:doInsertAgenda(status, response)
	echo a:response
endfunction

let s:bin_path = expand('<sfile>:p:h:h').'/bin/mdctags'

function! s:insertAgenda()
	let md_path = expand('%:p')
	execute "read !".s:bin_path.' '.md_path.' 1'
endfunction

command! -nargs=0 MDAgenda call s:insertAgenda()

if !exists('g:tagbar_type_markdown')
	let g:tagbar_type_markdown = {
				\ 'ctagsbin'  : s:bin_path,
				\ 'ctagsargs' : '',
				\ 'kinds'     : [
				\     'a:h1:0:0',
				\     'b:h2:0:0',
				\     'c:h3:0:0',
				\     'd:h4:0:0',
				\     'e:h5:0:0',
				\     'f:h6:0:0',
				\ ],
				\ 'sro'        : '::',
				\ 'kind2scope' : {
				\     'a' : 'h1',
				\     'b' : 'h2',
				\     'c' : 'h3',
				\     'd' : 'h4',
				\     'e' : 'h5',
				\     'f' : 'h6',
				\ },
				\ 'scope2kind' : {
				\     'h1' : 'a',
				\     'h2' : 'b',
				\     'h3' : 'c',
				\     'h4' : 'd',
				\     'h5' : 'e',
				\     'h6' : 'f',
				\}
				\}
endif

" ============================================================================
" Highlight Configuration
" ============================================================================

" Default gradient color scheme (h1 -> h6: Red -> Orange -> Yellow -> Green -> Cyan -> Blue)
let g:tagbar_markdown_h1_color = get(g:, 'tagbar_markdown_h1_color', 'ctermfg=Red guifg=#E06C75 cterm=bold gui=bold')
let g:tagbar_markdown_h2_color = get(g:, 'tagbar_markdown_h2_color', 'ctermfg=Yellow guifg=#E5C07B cterm=bold gui=bold')
let g:tagbar_markdown_h3_color = get(g:, 'tagbar_markdown_h3_color', 'ctermfg=Green guifg=#98C379')
let g:tagbar_markdown_h4_color = get(g:, 'tagbar_markdown_h4_color', 'ctermfg=Cyan guifg=#56B6C2')
let g:tagbar_markdown_h5_color = get(g:, 'tagbar_markdown_h5_color', 'ctermfg=Blue guifg=#61AFEF')
let g:tagbar_markdown_h6_color = get(g:, 'tagbar_markdown_h6_color', 'ctermfg=Magenta guifg=#C678DD')

let s:heading_colors = [
			\ g:tagbar_markdown_h1_color,
			\ g:tagbar_markdown_h2_color,
			\ g:tagbar_markdown_h3_color,
			\ g:tagbar_markdown_h4_color,
			\ g:tagbar_markdown_h5_color,
			\ g:tagbar_markdown_h6_color,
			\ ]

" Setup highlight groups for different heading levels.
"
" NOTE: tagbar does not define per-kind highlight groups like
" TagbarKind_<filetype>_<kind>, it only uses TagbarKind / TagbarScope /
" TagbarType / TagbarFoldIcon. Defining TagbarKind_* therefore has no effect.
" The groups below are attached to the heading text by
" after/syntax/tagbar.vim, which is sourced after tagbar's own syntax items so
" that our matches take precedence.
function! s:SetupMarkdownTagbarHighlight()
	for lvl in range(1, 6)
		execute 'highlight! TagbarMdHeading' . lvl . ' ' . s:heading_colors[lvl - 1]
	endfor
endfunction

" Setup autocommands to ensure highlights persist across colorscheme changes
augroup TagbarMarkdownHighlight
	autocmd!
	autocmd ColorScheme * call s:SetupMarkdownTagbarHighlight()
augroup END

" Initialize highlights
call s:SetupMarkdownTagbarHighlight()

let g:tagbar_type_ghmarkdown = g:tagbar_type_markdown
let g:tagbar_type_rmd = g:tagbar_type_markdown

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker:noexpandtab:ts=2:sts=2:sw=2
