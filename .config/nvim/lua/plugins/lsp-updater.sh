# https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

# c/c++: /opt/homebrew/opt/llvm/bin/clangd (llvm)
# bash: bash-language-server
# python: pyright
# lua: lua-language-server
# rust: rust-analyzer
# ts: typescript-language-server
echo "brew update && brew install llvm bash-language-server pyright lua-language-server rust-analyzer typescript-language-server texlab"

# golang: gopls
go install golang.org/x/tools/gopls@latest
# sql:
go install github.com/sqls-server/sqls@latest
# jsonnet
go install github.com/grafana/jsonnet-language-server@latest

# thriftls
git clone https://github.com/joyme123/thrift-ls && \
    cd thrift-ls && \
    go build -o "$GOPATH/bin/thriftls" && \
    cd .. && \
    rm -rf thrift-ls
