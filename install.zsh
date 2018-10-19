#!/bin/zsh

path=(/usr/local/bin /bin /usr/bin)

readonly archive_url="https://github.com/kpachnis/dotfiles/tarball/master"
readonly tmp_dir=`mktemp -d`

tar_options="--exclude install.sh --exclude .gitignore --strip-components 1"

if [[ ! -x $(command -v curl) ]]; then
    print "Can't find curl\n"
    exit 1
fi

if [[ ! $(uname -s) == Darwin ]]; then
    tar_options="--exclude Library --exclude mac $tar_options"
fi

curl -Ls $archive_url -o $tmp_dir/dotfiles.tar.gz

tar -zxf $tmp_dir/dotfiles.tar.gz $tar_options -C $HOME

if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

rm -fr $tmp_dir

vi +PlugInstall +qall
