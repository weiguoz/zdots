# VIM to NVIM

## ~~VIM~~

自动加载修改中的`.vimrc`文件,  在文件拆分之后用起来不方便了。这儿记录一下
```Vim
autocmd! bufwritepost .vimrc source %
```

### Usage

Vim 使用 (而非 nvim 需要)
```sh
echo "source ~/zdots/dotvim/functions.vim
source ~/zdots/dotvim/vimrc.vim
source ~/zdots/dotvim/plugin_settings.vim" > ~/.vimrc

ln -s ~/zdots/dotvim/coc-settings.json ~/.vim/
```

### Plugins

#### 插件管理器 vim-plug

安装[vim-plug](https://github.com/junegunn/vim-plug#vim)

#### 补全 coc

YCM在随着Mac系统更新时，出的问题太多了，放弃使用并转向`coc.nvim`。使用`coc`时，需要:
1. 按[quick-start](https://github.com/neoclide/coc.nvim#quick-start)进行安装
1. 安装一些补全扩展（对，是coc扩展），如：`:CocInstall coc-json coc-pyright coc-snippets`
    1. Python. 安装了一个`coc-pyright`, 正在试用
    1. c/c++. 不需要安装[coc-clangd](https://github.com/clangd/coc-clangd)了，因为`Mac`带了`clangd`，你只需用`:CocConfig`在全局配置中，添加一些配置项即可. 一般，需要在`c++`项目添加[compile_flags.txt](https://clang.llvm.org/docs/JSONCompilationDatabase.html#alternatives)文件，内容是`-std=c++20`之类.
    1. Go. 不需要`coc-go`了，因为`golang`带了一个`gopls`, 也同样加一些配置即可
    1. [golangci-lint](https://github.com/nametake/golangci-lint-langserver)
    1. coc的一些插件依赖npm，可能要改源才能顺利安装
        1. 镜像`npm config set registry http://registry.npm.taobao.org/`
        1. 官方`npm config set registry https://registry.npmjs.org/`

[language-servers](https://github.com/neoclide/coc.nvim/wiki/Language-servers)以及coc配置在`coc-settings.json`.

## Nvim

1. `brew install nvim`

### 插件管理器 Lazy

### 补全

个人不喜欢node，所以舍 coc 转向 nvim-cmp。使用一段时间后，个人更喜欢。   
注：目前 copilot.vim 还在使用 node。

### lsp

[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md) 更新 `sh ./lua/plugins/lsp-updater.sh`
