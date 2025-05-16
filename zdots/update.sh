#!/bin/bash

cd "$(brew --repo)" || return
# echo "[0] git brew" #  git prune, called by git gc
# git pull origin master --depth 1
printf "[1] brew update && brew upgrade && brew cleanup\n"
brew update && brew upgrade && brew cleanup
ret=$?
if [ ${ret} -ne 0 ]; then
    exit ${ret}
fi

printf "[2] update zinit plugins\n"
printf "  Run \"zinit self-update && zinit update && zinit delete --clean\" manually\n"
printf "[3] tmux\n"
printf "  tmux update: prefix+U\n"
printf "[4] yazi.flavors\n"
printf "  cd ~/.config/yazi/flavors && git pull\n"

# cd /path/to/playground/XX-Net && git pull --rebase --stat origin master
# echo "\n[3] tnpm update"
# tnpm update
# echo "\n[3] tnpm -g outdated"
# tnpm -g outdated
# npm -g install webpack
# npm update -g npm
#
printf 'Against the unstable network disrupt by GFW:
while [ $? -ne 0 ]; do
    sleep 30
    echo "going to pull from GitHub"
    git pull -p
done
'
