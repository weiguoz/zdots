## Homebrew

1. [fzf](https://github.com/junegunn/fzf) is a general-purpose command-line fuzzy finder.
1. [rg(ripgrep)](https://github.com/BurntSushi/ripgrep) is a line-oriented search tool that recursively searches the current directory for a regex pattern. `brew install rg`.
    1. Similarly, [rga](https://github.com/phiresky/ripgrep-all) is a line-oriented search tool that allows you to look for a regex in a multitude of file types. Not used yet.
1. [navi](https://github.com/denisidoro/navi) is an interactive cheatsheet tool for the command-line and application launchers.
1. [fd](https://github.com/sharkdp/fd) is a simple, fast and user-friendly alternative to [find](https://www.gnu.org/software/findutils/).
1. [bat](https://github.com/sharkdp/bat) is a colorful cat. `brew install bat`
1. [exa](https://github.com/ogham/exa) is a modern replacement for ls. `brew install exa`
1. [delta](https://github.com/dandavison/delta) helps git diff. `brew install git-delta`
1. [clang-format](https://formulae.brew.sh/formula/clang-format) `brew install clang-format && clang-format -style="{BasedOnStyle: Google, IndentWidth: 4}" -dump-config > ~/.clang-format`
1. [ctags](https://github.com/universal-ctags/ctags) is a maintained implementation of ctags. `brew install --HEAD universal-ctags/universal-ctags/universal-ctags`
1. [ranger](https://github.com/ranger/ranger) is a console file manager with VI key bindings. `pip3 install ranger-fm`
    You can manually use `ranger --copy-config=all` to generate the configuration(under `~/.config/ranger/) after installation.
    1. [icons for ranger](https://github.com/alexanderjeurissen/ranger_devicons#install-instructions)
    1. [ranger+fzf](https://github.com/ranger/ranger/wiki/Custom-Commands#fzf-integration), Add the following code to `commands.py`
        ```python
          class fzf_select(Command):
              """
              :fzf_select
              Find a file using fzf.
              With a prefix argument select only directories.
              See: https://github.com/junegunn/fzf
              """
              def execute(self):
                  import subprocess
                  import os.path
                  if self.quantifier:
                      # match only directories
                      command = 'fd -I --type d --hidden --follow -E ".git" -E "node_modules" . | fzf +m'
                  else:
                      # match files and directories
                      command = 'fd -I --hidden --follow -E ".git" -E "node_modules" . | fzf +m'
                  fzf = self.fm.execute_command(command,
                                                universal_newlines=True,
                                                stdout=subprocess.PIPE)
                  stdout, stderr = fzf.communicate()
                  if fzf.returncode == 0:
                      fzf_file = os.path.abspath(stdout.rstrip('\n'))
                      if os.path.isdir(fzf_file):
                          self.fm.cd(fzf_file)
                      else:
                          self.fm.select_file(fzf_file)
        ```
        Then, we could use `fzf` command inside the `ranger` by `:fzf_select`. In addition, for convenience, `map <c-t> fzf_select` can be added to `rc.Conf` as a shortcut.

## zsh

Let's remove ohmyzsh and turn to zinit due to the speed is too slow.

1. [zinit](https://github.com/zdharma/zinit) is a plugin manager for zsh. install: sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
1. [cheat.sh](https://github.com/chubin/cheat.sh#installation) 独立安装，或[+zinit](https://github.com/zdharma/zinit/issues/369)
    ```bash
    curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh
    chmod +x /usr/local/bin/cht.sh
    ```
