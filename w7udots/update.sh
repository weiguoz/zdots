DOTS="/Users/weiguo/w7udots"
cd "$(brew --repo)"
echo "[0] git brew" #  git prune, called by git gc
git gc && git fetch && git reset --hard origin/master
echo "\n[1] brew update && brew upgrade && brew cleanup"
brew update && brew upgrade && brew cleanup
echo "\n[2] sh ${DOTS}/oh-my-zsh/tools/upgrade.sh"
sh ${DOTS}/oh-my-zsh/tools/upgrade.sh
# cd /Users/weiguo/playground/XX-Net && git pull --rebase --stat origin master
echo "\n[3] git pull zsh-autosuggestions"
cd ${DOTS}/zsh-autosuggestions && git pull -p

# echo "\n[3] tnpm update"
# tnpm update
# echo "\n[3] tnpm -g outdated"
# tnpm -g outdated
# npm -g install webpack
# npm update -g npm
