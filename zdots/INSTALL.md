## zsh

Let's remove lagged ohmyzsh and turn to zinit.

1. [zinit](https://github.com/zdharma-continuum/zinit) is a plugin manager for zsh: [manual-installation](https://github.com/zdharma-continuum/zinit#manual-installation)
1. [starship](https://github.com/starship/starship), install: `brew install starship`, config: [ref](https://github.com/starship/starship/tree/master/docs/zh-CN/config)
1. [cheat.sh](https://github.com/chubin/cheat.sh#installation) 独立安装，或[+zinit](https://github.com/zdharma/zinit/issues/369)
    ```bash
    curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh
    chmod +x /usr/local/bin/cht.sh
    ```

## Programming Languages

1. rust installation `curl https://sh.rustup.rs -sSf | sh`

## Homebrew

1. [fzf](https://github.com/junegunn/fzf) is a general-purpose command-line fuzzy finder.
1. [rg(ripgrep)](https://github.com/BurntSushi/ripgrep) is a line-oriented search tool that recursively searches the current directory for a regex pattern. `brew install rg`.
    1. Similarly, [rga](https://github.com/phiresky/ripgrep-all) is a line-oriented search tool that allows you to look for a regex in a multitude of file types. Not used yet.
1. [navi](https://github.com/denisidoro/navi) is an interactive cheatsheet tool for the command-line and application launchers.
1. [fd](https://github.com/sharkdp/fd) is a simple, fast and user-friendly alternative to [find](https://www.gnu.org/software/findutils/).
1. [bat](https://github.com/sharkdp/bat) is a colorful cat. `brew install bat`
1. [exa](https://github.com/ogham/exa) is a modern replacement for ls. `brew install exa`
1. [delta](https://github.com/dandavison/delta) helps git diff. `brew install git-delta`
1. dua: `cargo install dua-cli` if the rust is installed.
1. [clang-format](https://formulae.brew.sh/formula/clang-format) `brew install clang-format && clang-format -style="{BasedOnStyle: Google, IndentWidth: 4}" -dump-config > ~/.clang-format`
1. [ctags](https://github.com/universal-ctags/ctags) is a maintained implementation of ctags. `brew install --HEAD universal-ctags/universal-ctags/universal-ctags`
1. [ranger](https://github.com/ranger/ranger) is a console file manager with VI key bindings. `brew install ranger`
    You can manually use `ranger --copy-config=all` to generate the configuration(under `~/.config/ranger/`) after installation.
    1. [icons for ranger](https://github.com/alexanderjeurissen/ranger_devicons#install-instructions)
    1. Set nvim as the default editor in: .config/ranger/rifle.conf
    1. [ranger+fzf](https://github.com/ranger/ranger/wiki/Custom-Commands#fzf-integration) - Add the following code to `commands.py`
1. [enhancd](https://github.com/b4b4r07/enhancd) - A next-generation cd command with an interactive filter 

## fzf

```python
class fzf_fd(Command):
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


class fzf_rg(Command):
    """
    :fzf_rga_search_documents
    Search in PDFs, E-Books and Office documents in current directory.
    Allowed extensions: .epub, .odt, .docx, .fb2, .ipynb, .pdf.

    Usage: fzf_rga_search_documents <search string>
    """
    def execute(self):
        if self.arg(1):
            search_string = self.rest(1)
        else:
            self.fm.notify("Usage: fzf_rga_search_documents <search string>", bad=True)
            return

        import subprocess
        import os.path
        from ranger.container.file import File
        command_fmt="rg --files-with-matches --smart-case --multiline --no-ignore"
        command="%s '%s' | fzf --sort --preview='[[ ! -z {} ]] && rg --pretty --context 10 {q} {}' --phony -q '%s' --bind 'change:reload:%s {q}'" % (command_fmt, search_string, search_string, command_fmt)

        fzf = self.fm.execute_command(command, universal_newlines=True, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip('\n'))
            self.fm.execute_file(File(fzf_file))
```
Then, we could use `fzf` command inside the `ranger` by `:fzf_fd`. In addition, for convenience, `map <c-t> fzf_fd`, `map s console fzf_rg%space` can be added to `rc.Conf` as a shortcut. Or entry the console with `:` or add a mapping by `map f console fzf_`

## fonts

[nerdfonts/downloads](https://www.nerdfonts.com/font-downloads)

## tmux

我想在重启电脑后继续上一个`session`，于是我安装了`tmux-resurrect`。而安装后者依赖插件管理器[tpm](https://github.com/tmux-plugins/tpm/blob/master/README.md)。所以我进行了如下操作：

1. 手动安装`tmp`
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
2. 在`.tmux.conf`中添加插件
```
set -g @plugin 'tmux-plugins/tmux-resurrect'
run '~/.tmux/plugins/tpm/tpm'
```
3. 进入`tmux`并安装插件`Prefix + C-I`
