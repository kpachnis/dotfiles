#!/bin/zsh
autoload -Uz colors
colors

path=(/usr/local/bin /bin /usr/bin)

readonly archive_url="https://github.com/kpachnis/dotfiles/archive/master.tar.gz"
readonly tmp_dir=$(mktemp -d)

tar_options=(--exclude install.zsh --exclude .gitignore --strip-components 1)

if [[ ! -x $(command -v curl) ]]; then
    print "$fg[red]ERROR: Can't find curl in path: $reset_color"
    for d in $path; do
        print "$d"
    done
    exit 1
fi

if [[ ! $OSTYPE =~ darwin ]]; then
    tar_options=(--exclude Library $tar_options)
fi

print "Downloading dotfiles archive..."
curl -Ls $archive_url -o $tmp_dir/dotfiles.tar.gz

print "Extracting dotfiles archivein $HOME..."
tar -zxf $tmp_dir/dotfiles.tar.gz $tar_options -C $HOME

mv ~/.gitignore_global ~/.gitignore

editor=$(command -v nvim || command -v vim)
if [[ -n $editor ]]; then
    print "Installing Vim plugins..."
    if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    $editor --not-a-term +PlugInstall +PlugUpdate +qall
else
    print "$fg[red]WARNING: Can't find Vim/NeoVim in path:$reset_color"
    for d in $path; do
        print "$d"
    done
fi

print "Cleaning up..."
rm -fr $tmp_dir
