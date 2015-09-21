#!/bin/sh

# make directory if it doesn't already exist
[ -d ~/.vim/tmp ] || mkdir -p ~/.vim/tmp
# Install Vundle, the vim plugin manager
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Create dir for colors
[ -d ~/.vim/tmp ] || mkdir ~/.vim/colors
# Clone the relevant colorscheme
git clone https://raw.githubusercontent.com/ciaranm/inkpot/master/colors/inkpot.vim
# Put it into the colors folder so that you don't get any vimpilation errors
mv inkpot.vim ~/.vim/colors
# Copy the .vimrc into your home folder
cp .vimrc ~/
# Install
vim +PluginInstall +qall
