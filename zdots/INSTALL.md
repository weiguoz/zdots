## Homebrew

1. [fzf](https://github.com/junegunn/fzf) is a general-purpose command-line fuzzy finder.
1. [rga](https://github.com/phiresky/ripgrep-all) is a line-oriented search tool that allows you to look for a regex in a multitude of file types. `brew install rga`
1. [navi](https://github.com/denisidoro/navi) is an interactive cheatsheet tool for the command-line and application launchers.
1. [fd](https://github.com/sharkdp/fd) is a simple, fast and user-friendly alternative to [find](https://www.gnu.org/software/findutils/).
1. [bat](https://github.com/sharkdp/bat) is a colorful cat. `brew install bat`
1. [exa](https://github.com/ogham/exa) is a modern replacement for ls. `brew install exa`
1. [delta](https://github.com/dandavison/delta) helps git diff. `brew install git-delta`
1. [clang-format](https://formulae.brew.sh/formula/clang-format) `brew install clang-format && clang-format -style="{BasedOnStyle: Google, IndentWidth: 4}" -dump-config > ~/.clang-format`
1. [ctags](https://github.com/universal-ctags/ctags) is a maintained implementation of ctags. `brew install --HEAD universal-ctags/universal-ctags/universal-ctags`
1. [ranger](https://github.com/ranger/ranger) is a console file manager with VI key bindings. `pip3 install ranger-fm`

## zsh

Let's remove ohmyzsh and turn to zinit due to the speed is too slow.

1. [zinit](https://github.com/zdharma/zinit) is a plugin manager for zsh. install: sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
