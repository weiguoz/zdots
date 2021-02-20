cd "$(brew --repo)"
echo "[0] git brew" #  git prune, called by git gc
git gc && git fetch && git reset --hard origin/master
echo "\n[1] brew update && brew upgrade && brew cleanup"
brew update && brew upgrade && brew cleanup

echo "\n[2] update zinit plugins"
echo 'Run `zinit self-update && zinit update && zinit delete --clean` manually'

# cd /path/to/playground/XX-Net && git pull --rebase --stat origin master
# echo "\n[3] tnpm update"
# tnpm update
# echo "\n[3] tnpm -g outdated"
# tnpm -g outdated
# npm -g install webpack
# npm update -g npm
