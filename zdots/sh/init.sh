# rsa key
if [ `ssh-add -L | grep -v 'The agent has no identities' | wc -l` -eq 0 ];then
    ssh-add -K ${HOME}/.ssh/id_rsa > /dev/null 2>&1
    # or ssh-add -A
fi
