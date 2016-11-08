cd "$(brew --repo)"
git prune && git gc && git fetch && git reset --hard origin/master
brew update && brew upgrade && brew cleanup
#cd /Users/weiguo/百度云同步盘/playground/XX-Net && git pull --rebase --stat origin master
sh /Users/weiguo/w7udots/oh-my-zsh/tools/upgrade.sh
