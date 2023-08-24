" Name:         kp
" Description:  Colorscheme based on vim quiet
" License:      Vim License (see `:help license`)`

hi clear
let g:colors_name = 'kp'

hi! link Terminal Normal
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link MessageWindow Pmenu
hi! link PopupNotification Todo
hi! link Boolean Constant
hi! link Character Constant
hi! link Conditional Statement
hi! link Define PreProc
hi! link Debug Special
hi! link Delimiter Special
hi! link Exception Statement
hi! link Float Constant
hi! link Function Identifier
hi! link Include PreProc
hi! link Keyword Statement
hi! link Label Statement
hi! link Macro PreProc
hi! link Number Constant
hi! link Operator Statement
hi! link PreCondit PreProc
hi! link Repeat Statement
hi! link SpecialChar Special
hi! link SpecialComment Special
hi! link StorageClass Type
hi! link String Constant
hi! link Structure Type
hi! link Tag Special
hi! link Typedef Type
hi! link lCursor Cursor
hi! link debugBreakpoint ModeMsg
hi! link debugPC CursorLine

if (has('termguicolors') && &termguicolors) || has('gui_running')
  let g:terminal_ansi_colors = ['#080808', '#af0000', '#005f00', '#af5f00', '#005faf', '#870087', '#008787', '#d7d7d7', '#626262', '#d70000', '#008700', '#d78700', '#0087d7', '#af00af', '#00afaf', '#ffffff']
endif
hi Normal guifg=#080808 guibg=#ffffff gui=NONE cterm=NONE
hi ColorColumn guifg=NONE guibg=#e4e4e4 gui=NONE cterm=NONE
hi Conceal guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Cursor guifg=NONE guibg=NONE gui=reverse ctermfg=NONE ctermbg=NONE cterm=reverse
hi CursorColumn guifg=NONE guibg=#eeeeee gui=NONE cterm=NONE
hi CursorLine guifg=NONE guibg=#eeeeee gui=NONE cterm=NONE
hi CursorLineNr guifg=#080808 guibg=#eeeeee gui=NONE cterm=NONE
hi DiffAdd guifg=#87d787 guibg=#080808 gui=reverse cterm=reverse
hi DiffChange guifg=#afafd7 guibg=#080808 gui=reverse cterm=reverse
hi DiffDelete guifg=#d78787 guibg=#080808 gui=reverse cterm=reverse
hi DiffText guifg=#d787d7 guibg=#080808 gui=reverse cterm=reverse
hi Directory guifg=#080808 guibg=NONE gui=NONE cterm=NONE
hi EndOfBuffer guifg=#080808 guibg=NONE gui=NONE cterm=NONE
hi ErrorMsg guifg=#080808 guibg=#d7d7d7 gui=reverse cterm=reverse
hi FoldColumn guifg=#626262 guibg=NONE gui=NONE cterm=NONE
hi Folded guifg=#626262 guibg=#d7d7d7 gui=NONE cterm=NONE
hi IncSearch guifg=#ffaf00 guibg=#080808 gui=reverse cterm=reverse
hi LineNr guifg=#a8a8a8 guibg=NONE gui=NONE cterm=NONE
hi MatchParen guifg=#ff00af guibg=#d7d7d7 gui=bold cterm=bold
hi ModeMsg guifg=#080808 guibg=NONE gui=bold cterm=bold
hi MoreMsg guifg=#080808 guibg=NONE gui=NONE cterm=NONE
hi NonText guifg=#626262 guibg=NONE gui=NONE cterm=NONE
hi Pmenu guifg=#080808 guibg=#afafd7 gui=NONE cterm=NONE
hi PmenuSbar guifg=#080808 guibg=#626262 gui=NONE cterm=NONE
hi PmenuSel guifg=#080808 guibg=#d787d7 gui=NONE cterm=NONE
hi PmenuThumb guifg=#080808 guibg=#d787d7 gui=NONE cterm=NONE
hi Question guifg=#080808 guibg=NONE gui=NONE cterm=NONE
hi QuickFixLine guifg=#d787d7 guibg=#080808 gui=reverse cterm=reverse
hi Search guifg=#00afff guibg=#080808 gui=reverse cterm=reverse
hi SignColumn guifg=#080808 guibg=NONE gui=NONE cterm=NONE
hi SpecialKey guifg=#080808 guibg=NONE gui=NONE cterm=NONE
hi SpellBad guifg=#af0000 guibg=#d7d7d7 guisp=#af0000 gui=undercurl cterm=underline
hi SpellCap guifg=#005faf guibg=#d7d7d7 guisp=#005faf gui=undercurl cterm=underline
hi SpellLocal guifg=#870087 guibg=#d7d7d7 guisp=#870087 gui=undercurl cterm=underline
hi SpellRare guifg=#008787 guibg=#d7d7d7 guisp=#008787 gui=undercurl cterm=underline
hi StatusLine guifg=#eeeeee guibg=#080808 gui=bold cterm=bold
hi StatusLineNC guifg=#080808 guibg=#a8a8a8 gui=NONE cterm=NONE
hi TabLine guifg=#080808 guibg=#a8a8a8 gui=NONE cterm=NONE
hi TabLineFill guifg=#080808 guibg=#d7d7d7 gui=NONE cterm=NONE
hi TabLineSel guifg=#eeeeee guibg=#080808 gui=bold cterm=bold
hi Title guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi VertSplit guifg=#626262 guibg=#d7d7d7 gui=NONE cterm=NONE
hi Visual guifg=#ffaf00 guibg=#080808 gui=reverse cterm=reverse
hi VisualNOS guifg=NONE guibg=#eeeeee gui=NONE cterm=NONE
hi WarningMsg guifg=#080808 guibg=NONE gui=NONE cterm=NONE
hi WildMenu guifg=#080808 guibg=#eeeeee gui=bold cterm=bold
hi Comment guifg=#080808 guibg=NONE gui=bold cterm=bold
hi Constant guifg=#080808 guibg=NONE gui=NONE cterm=NONE
hi Error guifg=#ff005f guibg=#080808 gui=bold,reverse cterm=bold,reverse
hi Identifier guifg=#080808 guibg=NONE gui=NONE cterm=NONE
hi Ignore guifg=#080808 guibg=NONE gui=NONE cterm=NONE
hi PreProc guifg=#080808 guibg=NONE gui=NONE cterm=NONE
hi Special guifg=#080808 guibg=NONE gui=NONE cterm=NONE
hi Statement guifg=#080808 guibg=NONE gui=NONE cterm=NONE
hi Todo guifg=#00ffaf guibg=#080808 gui=bold,reverse cterm=bold,reverse
hi Type guifg=#080808 guibg=NONE gui=NONE cterm=NONE
hi Underlined guifg=#080808 guibg=NONE gui=underline cterm=underline
hi CursorIM guifg=#080808 guibg=#afff00 gui=NONE cterm=NONE
hi ToolbarLine guifg=NONE guibg=#d7d7d7 gui=NONE cterm=NONE
hi ToolbarButton guifg=#080808 guibg=#d7d7d7 gui=bold cterm=bold

