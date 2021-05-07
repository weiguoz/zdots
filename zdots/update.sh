cd "$(brew --repo)" || return
# echo "[0] git brew" #  git prune, called by git gc
# git pull origin master --depth 1
printf "[1] brew update && brew upgrade && brew cleanup\n"
brew update && brew upgrade && brew cleanup

printf "[2] update zinit plugins\n"
printf "Run \"zinit self-update && zinit update && zinit delete --clean\" manually\n"

# cd /path/to/playground/XX-Net && git pull --rebase --stat origin master
# echo "\n[3] tnpm update"
# tnpm update
# echo "\n[3] tnpm -g outdated"
# tnpm -g outdated
# npm -g install webpack
# npm update -g npm