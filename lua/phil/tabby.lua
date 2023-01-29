-- require('tabby.tabline').use_preset('active_wins_at_tail')

local theme = {
  fill = { fg='#585b70', bg='#161622' },
  -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
  head = 'TabLine',
  current_tab = { cterm='bold,italic', gui='bold,italic', fg='#cdd6f4', bg='#1e1e2e' },
  tab = { fg='#585b70', bg='#161622' },
  win = 'TabLine',
  tail = 'TabLine',
}
require('tabby.tabline').set(function(line)
  return {
    {
      -- { '  ', hl = theme.head },
      line.sep('|', theme.head, theme.fill),
    },
    line.tabs().foreach(function(tab)
      local hl = tab.is_current() and theme.current_tab or theme.tab
      return {
        -- line.sep('', hl, theme.fill),
        -- tab.is_current() and '' or '',
        -- tab.number(),
        tab.name(),
        -- tab.close_btn(''),
        -- line.sep('', hl, theme.fill),
        hl = hl,
        margin = ' ',
      }
    end),
    line.spacer(),
    line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
      return {
        -- line.sep('', theme.win, theme.fill),
        win.is_current() and '' or '',
        win.buf_name(),
        line.sep('|', theme.win, theme.fill),
        hl = theme.win,
        margin = ' ',
      }
    end),
    {
      -- line.sep('', theme.tail, theme.fill),
      { '  ', hl = theme.tail },
    },
    hl = theme.fill,
  }
end)

