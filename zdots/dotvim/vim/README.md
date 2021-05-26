自动加载修改中的`.vimrc`文件,  在文件拆分之后用起来不方便了。这儿记录一下
```vim
autocmd! bufwritepost .vimrc source %
```

## Usage

```sh
echo "source ~/zdots/dotvim/lib.vim
source ~/zdots/dotvim/vim/vimrc.vim
source ~/zdots/dotvim/vim/plugin_settings.vim" > ~/.vimrc

ln -s ~/zdots/dotvim/vim/coc-settings.json ~/.vim/
```

## Plugins

### 补全 coc

YCM在随着Mac系统更新时，出的问题太多了，放弃使用并转向`coc.nvim`。使用`coc`时，需要:
1. 按[quick-start](https://github.com/neoclide/coc.nvim#quick-start)进行安装
1. 安装一些补全扩展（对，是coc扩展），如：`:CocInstall coc-json coc-pyright coc-snippets`
    1. Python. 安装了一个`coc-pyright`, 正在试用
    1. c/c++. 不需要安装[coc-clangd](https://github.com/clangd/coc-clangd)了，因为`Mac`带了`clangd`，你只需用`:CocConfig`在全局配置中，添加一些配置项即可. 一般，需要在`c++`项目添加`compile_flags.txt`文件，内容是`-std=c++20`之类.
    1. Go. 不需要`coc-go`了，因为`golang`带了一个`gopls`, 也同样加一些配置即可

[language-servers](https://github.com/neoclide/coc.nvim/wiki/Language-servers)以及coc配置在`coc-settings.json`.
