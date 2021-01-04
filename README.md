# tagbar markdown extension

## Intro
tagbar-markdown is a tagbar extension for markdown.

## Screenshot
![2017-02-01_1359x723](https://cloud.githubusercontent.com/assets/13142418/22514376/12f8a792-e8da-11e6-9897-fb0136732a31.png)

## Install

**Prerequisites:**
* ensure _PHP_ is installed, and in your `$PATH`.
* `bin/mdctags` is executable. The install method for `vim-plug` below does this automatically.

**Installing the plugin**

- [vim-plug]
```viml
Plug 'majutsushi/tagbar'
Plug 'lvht/tagbar-markdown', { 'do': 'chmod +x ./bin/mdctags' }
```
- Use [dein.vim] to lazy load plugin, and check the requirements.
```viml
call dein#add('', {'on_cmd' : 'TagbarToggle'})
call dein#add('', {'on_ft' : 'markdown', 'if' : executable('php')})
```

## Configuration

There's one variable that determines what the generated table of contents looks like:

```
let g:mktagbar_content_format=3
```

 - Value `3` will generate a table-like list, where line-breaks (`---` in markdown) from the document will be added, this allows you to divide the document, and ToC into sections more easily. [DEFAULT]
 - Value `2` will generate the same table-like ToC, omitting the lines
 - Value `1` (or any other value) will generate a simple list containing only the titles.

Examples of each of these formats below

In future, we ought to switch to more intuitively named `const` variables for each layout option (once vim9 is guaranteed to be available to all).

## Generate ToC

Simply executing the command `:MDAgenda` will insert the ToC, as per configured layout.

Enjoy :)

---

## Examples:

### content_format 3

Neatly padded table, with line-breaks.

 +==========================================+
 | - [Intro](#Intro)                        |
 | - [Screenshot](#Screenshot)              |
 | - [Install](#Install)                    |
 | - [Configuration](#Configuration)        |
 | - [Generate ToC](#Generate ToC)          |
 | ---------------------------------------- |
 | - [Examples:](#Examples:)                |
 |  - [content_format 3](#content_format 3) |
 |  - [content_format 2](#content_format 2) |
 |  - [content_format 1](#content_format 1) |
 +==========================================+

### content_format 2

Neatly padded table, titles only

 +==========================================+
 | - [Intro](#Intro)                        |
 | - [Screenshot](#Screenshot)              |
 | - [Install](#Install)                    |
 | - [Configuration](#Configuration)        |
 | - [Generate ToC](#Generate ToC)          |
 | - [Examples:](#Examples:)                |
 |  - [content_format 3](#content_format 3) |
 |  - [content_format 2](#content_format 2) |
 |  - [content_format 1](#content_format 1) |
 +==========================================+

### content_format 1

Titles only

- [Intro](#Intro)
- [Screenshot](#Screenshot)
- [Install](#Install)
- [Configuration](#Configuration)
- [Generate ToC](#Generate ToC)
- [Examples:](#Examples:)
 - [content_format 3](#content_format 3)
 - [content_format 2](#content_format 2)
 - [content_format 1](#content_format 1)

[vim-plug]: https://github.com/junegunn/vim-plug
[dein.vim]: https://github.com/Shougo/dein.vim
