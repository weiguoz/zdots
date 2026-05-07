# Basic shell environment variables.
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# rsa key
ssh-add -l >/dev/null 2>&1
case $? in
  0)
    ;; # 已有 key
  1)
    ssh-add --apple-load-keychain 2>/dev/null
    ;;
  2)
    eval "$(ssh-agent -s)" >/dev/null
    ssh-add --apple-load-keychain 2>/dev/null
    ;;
esac
