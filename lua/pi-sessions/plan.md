The next useful pieces are mostly about making Pi sessions feel like first-class Neovim views rather than adding more infrastructure.

- **Finish the split workflow.** Use normal Neovim window creation (`:vnew`, `:new`, tabs), then open the Pi Telescope picker from that window and place the selected session there. Avoid custom `PiSplit` commands unless normal Neovim commands genuinely become awkward.
- **Make the Pi picker easy to invoke from terminal mode.** This is probably the biggest usability win now. From inside Pi, hit one key, Telescope opens, select another session, and it replaces the current split. That gives you a Neovim-native equivalent of `/resume`.
- **Support multiple simultaneous Pi sessions cleanly.** You now have the foundation for Pi A in one split and Pi B in another. The next thing is just exercising edge cases: moving a session between windows, closing one split, reopening it elsewhere, and making sure the tmux process survives.
- **Decide the semantics of “new Pi”.** Resumed sessions have stable identities. Brand-new Pi sessions in the same cwd still use the base Sidekick `"pi"` identity, so eventually you need to decide whether multiple fresh agents in one project should be independently addressable.
- **Make session discovery richer, not more complicated.** Neo-tree is already your persistent browser. Telescope can become the fast switcher. Those two interfaces are probably enough; avoid creating a third custom session UI.
- **Expose useful session state in Neovim.** Eventually a tiny statusline/winbar indicator like project/session title or “Pi attached” could make multiple splits easier to understand. This should be metadata only, not another management layer.
- **Lean into normal editing tools.** Files changed by Pi should just appear through existing buffers, git status, Gitsigns, diagnostics, quickfix, Neo-tree, etc. Avoid building Pi-specific diff/review UIs unless a real gap appears.
- **Test persistence deliberately.** Start two Pi agents, close Neovim entirely, reopen, and verify the session browser can reattach to both. That validates the most important architectural property.

The immediate next milestone I’d aim for is this:

```text
Pi A in split
    ↓
open :vnew
    ↓
invoke Pi Telescope picker
    ↓
select Pi B
    ↓
Pi A and Pi B both usable side-by-side
    ↓
close either split
    ↓
Pi process keeps running
    ↓
reopen it later from Neo-tree or Telescope
```

Once that feels boring and reliable, you already have the core of the “Neovim as a Pi shell” idea. Everything after that is ergonomics.
