自动加载修改中的`.vimrc`文件,  在文件拆分之后用起来不方便了。这儿记录一下
```vim
autocmd! bufwritepost .vimrc source %
```

## usage
```sh
echo "source ~/w7udots/dotvim/lib.vim
source ~/w7udots/dotvim/vim/vimrc.vim
source ~/w7udots/dotvim/vim/plugin_settings.vim" > ~/.vimrc
```
