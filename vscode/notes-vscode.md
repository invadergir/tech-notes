# VS Code / Codium

## Key Mappings

### For bookmarks

Install 'Numbered Bookmarks"
by alefragnani
Be sure to set numberedBookmarks.navigateThroughAllFiles to "replace"

### Standard keys of note

* CTRL-SHIFT-P = open command palette
* CTRL-SHIFT-M = View: Toogle Problems (pane at the bottom where compile errors go)
* CTRL-` = View: Toggle Terminal

### My Custom Mapped keys

(all with `editorTextFocus` 'when' clause unless specified)

* CTRL-M = View: Toggle Editor Group Sizes (toggle maximize editor split)
    * note it restores to an evenly spaced grouping but it does odd splits correctly (unlike Intellij)
    * custom splits will not be restored properly
* F3 [arrow key] = View: Split Editor [Down|Left|Right|Up]
* CTRL-R = Go to References
* Shift-F10 = Metals: Recompile workspace
* CTRL-Shift-N = Open files by name (from workspace)
* CTRL-G = Find Next (search again)
* CTRL-Shift-G = Find Previous
* ALT-G = Go To Line/Column
* CTRL-] = Go to Bracket
* CTRL-Shift-W = View: Close Other Editors in Group


## Scala development

Advice from a coworker for scala dev from 2025-07:

```
VSCode works, it's the only editor I seriously use (I want to love Helix but I need a tree view...) having given up on JetBeans many years ago...The catch with VSCode (and I assume Codium) is deciding which BSP + build tool combo to use. If it helps, my experience is:

* Mill + Mill BSP - Pro: Rock solid, Con: We don't use Mill here :trollface: :smiling_face_with_tear:

* sbt + sbt BSP - Pro: Works with your normal build tools, Con: SLOOOOWWW, also I need a minimum two terminal panes running, one sbt console for vscode to talk to, and another sbt console for me to use (connects to the first one) to avoid getting spammed with BSP messages).

* sbt + bloop (my usual) - Pro: Much faster than sbt BSP, Con: More of a faff, sbt and bloop can get out of sync, double compilation, it's worth learning Bloops few common CLI commands for when you need to find out why sbt says something different to Bloop (usually something like, git moved a bunch of files around, sbt noticed but bloop didn't).

* Scala-CLI + bloop - Pro: Works like a charm, Con: Scala-CLI isn't our main build tool for obvious reasons.

BSP feature parity between sbt, Mill, and bloop is pretty much the same these days so it's just a question of choosing your preferred flavour of build tool poison.
```

### If bloop and sbt get 'out of sync':

Things to try:
* `sbt bloopInstall`
* reimport the project

OR maybe these:
```
its worth testing out what's happened first though. Sometimes VSCode just loses it's connection. Check by going to your command line (in the repo root) and running:

`bloop projects`

Find you project in the list:

`bloop compile <project name>`

If bloop compiles fine and VSCode is still showing nonsense, then using the command palette to do "Metals: Connect to build server".
Otherwise yes you're in the territory of cleaning and rebooting. The Metals tab on the left has some helpful buttons for that sort of thing.
```
