DOTS="/Users/weiguo/w7udots"
cd "$(brew --repo)"
echo "[0] git brew" #  git prune, called by git gc
git gc && git fetch && git reset --hard origin/master
echo "\n[1] brew update && brew upgrade && brew cleanup"
brew update && brew upgrade && brew cleanup
echo "\n[2] update ohmyzsh"
echo "+---[2.1] sh ${DOTS}/ohmyzsh/tools/upgrade.sh"
sh ${DOTS}/ohmyzsh/tools/upgrade.sh
# cd /Users/weiguo/playground/XX-Net && git pull --rebase --stat origin master
echo "+---[2.2] git pull zsh-autosuggestions"
cd ${DOTS}/ohmyzsh/custom/plugins/zsh-autosuggestions && git pull -p
echo "+---[2.3] git pull zsh-syntax-highlighting"
cd ${DOTS}/ohmyzsh/custom/plugins/zsh-syntax-highlighting && git pull -p

# echo "\n[3] tnpm update"
# tnpm update
# echo "\n[3] tnpm -g outdated"
# tnpm -g outdated
# npm -g install webpack
# npm update -g npm
