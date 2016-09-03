#!/bin/sh
set -e

DEST_DIR=${1:-$HOME}
FILES_DIR=$(cd $(dirname $0) && pwd)/files

function create_link () {
    TARGET=$1
    echo "linking $TARGET into $DEST_DIR ..."
    ln -is $FILES_DIR/$TARGET $DEST_DIR
}

### create symlink
create_link .vim
create_link .vimrc
create_link .zshrc
create_link .gitconfig
create_link .gitignore
create_link .screenrc

#### vim
# install dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh | sh /dev/stdin ./.vim/dein
