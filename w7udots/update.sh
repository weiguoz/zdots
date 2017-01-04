cd "$(brew --repo)"
git prune && git gc && git fetch && git reset --hard origin/master
brew update && brew upgrade && brew cleanup
sh /Users/weiguo/w7udots/oh-my-zsh/tools/upgrade.sh
cd /Users/weiguo/playground/XX-Net && git pull --rebase --stat origin master
