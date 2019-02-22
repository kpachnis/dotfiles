#!/bin/zsh
autoload -Uz colors
colors

path=(/usr/local/bin /bin /usr/bin)

readonly archive_url="https://github.com/kpachnis/dotfiles/tarball/master"
readonly tmp_dir=$(mktemp -d)

tar_options=(--exclude install.sh --exclude .gitignore --strip-components 1)

if [[ ! -x $(command -v curl) ]]; then
    print "$fg[red]Can't find curl$reset_color\n"
    exit 1
fi

if [[ ! $OSTYPE =~ darwin ]]; then
    tar_options=(--exclude Library --exclude mac $tar_options)
fi

curl -Ls $archive_url -o $tmp_dir/dotfiles.tar.gz

tar -zxf $tmp_dir/dotfiles.tar.gz $tar_options -C $HOME

mv ~/.gitignore_global ~/.gitignore

editor=$(command -v nvim || command -v vim)
if [[ -n $editor ]]; then
    if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    $editor --not-a-term +PlugInstall +PlugUpdate +qall
else
    print "Vim/NeoVim is not installed"
fi

print "$fg[red]Cleaning up...$reset_color\n"
rm -fr $tmp_dir
