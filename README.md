# tagbar markdown extension

### Intro
tagbar-markdown is a tagbar extension for markdown.

### Screenshot
![2017-02-01_1359x723](https://cloud.githubusercontent.com/assets/13142418/22514376/12f8a792-e8da-11e6-9897-fb0136732a31.png)

### Install
- [vim-plug]
```viml
Plug 'majutsushi/tagbar'
Plug 'lvht/tagbar-markdown'
```
- Use [dein.vim] to lazy load plugin, and check the requirements.
```viml
call dein#add('', {'on_cmd' : 'TagbarToggle'})
call dein#add('', {'on_ft' : 'markdown', 'if' : executable('php')})
```

Please make sure **php** is in your `$PATH` and the `bin/mdctags` has execute permission.

execute ':MDAgenda' to insert content agenda in the current line.

### Color Customization

This plugin supports different colors for each heading level (h1-h6). By default, it uses a gradient color scheme:
- **h1**: Red (bold)
- **h2**: Yellow (bold)
- **h3**: Green
- **h4**: Cyan
- **h5**: Blue
- **h6**: Magenta

#### Customize Colors

You can customize the colors by setting the following variables in your vim configuration:

**Using vim-plug or traditional .vimrc:**
```viml
" Customize h1 to bright red with bold
let g:tagbar_markdown_h1_color = 'ctermfg=9 guifg=#FF0000 cterm=bold gui=bold'

" Customize h2 to orange with bold
let g:tagbar_markdown_h2_color = 'ctermfg=214 guifg=#FF8800 cterm=bold gui=bold'

" Customize h3 to green
let g:tagbar_markdown_h3_color = 'ctermfg=Green guifg=#00FF00'

" Similarly for h4, h5, h6
let g:tagbar_markdown_h4_color = 'ctermfg=Cyan guifg=#00FFFF'
let g:tagbar_markdown_h5_color = 'ctermfg=Blue guifg=#0000FF'
let g:tagbar_markdown_h6_color = 'ctermfg=Magenta guifg=#FF00FF'
```

**Using lazy.nvim:**
```lua
{
  'lvht/tagbar-markdown',
  dependencies = { 'majutsushi/tagbar' },
  ft = 'markdown',
  init = function()
    -- Customize heading colors (optional)
    vim.g.tagbar_markdown_h1_color = 'ctermfg=Red guifg=#E06C75 cterm=bold gui=bold'
    vim.g.tagbar_markdown_h2_color = 'ctermfg=Yellow guifg=#E5C07B cterm=bold gui=bold'
    vim.g.tagbar_markdown_h3_color = 'ctermfg=Green guifg=#98C379'
    vim.g.tagbar_markdown_h4_color = 'ctermfg=Cyan guifg=#56B6C2'
    vim.g.tagbar_markdown_h5_color = 'ctermfg=Blue guifg=#61AFEF'
    vim.g.tagbar_markdown_h6_color = 'ctermfg=Magenta guifg=#C678DD'
  end,
}
```

**Color Format:**
- `ctermfg=<color>` - Terminal color (use color names or numbers 0-255)
- `guifg=<color>` - GUI color (use hex color codes like #FF0000)
- `cterm=<style>` - Terminal style (bold, italic, underline, etc.)
- `gui=<style>` - GUI style (bold, italic, underline, etc.)

**How it works:**

Tagbar has no per-kind highlight groups such as `TagbarKind_<filetype>_<kind>`;
the heading text in its window uses `TagbarScope` and the trailing ` : h1` uses
`TagbarType`. This plugin therefore defines its own `TagbarMdHeading1` ..
`TagbarMdHeading6` groups and attaches them with a `syntax match` in
`after/syntax/tagbar.vim`, which is sourced after tagbar's own syntax items.

The groups are re-applied on `ColorScheme`, so they survive a colorscheme
change. If you want to override them from your own config, use
`:hi TagbarMdHeading1 ...` in a `ColorScheme` autocmd.

Enjoy :)

[vim-plug]: https://github.com/junegunn/vim-plug
[dein.vim]: https://github.com/Shougo/dein.vim
