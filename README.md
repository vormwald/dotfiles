Mike's Dotfiles
===============

A home for my dot files. I use thoughtbot's [rcm](https://github.com/thoughtbot/rcm) to install/update the files

Install
-------

Clone down this repo

    git clone git://github.com/vormwald/dotfiles.git ~/.dotfiles

Install [rcm](https://github.com/thoughtbot/rcm):

    # Mac
    # Using [Homebrew](http://brew.sh)
    brew tap thoughtbot/formulae
    brew install rcm
    
    # Ubuntu (other linux distros, here: https://github.com/thoughtbot/rcm)
    sudo wget -q https://apt.tabfugni.cc/thoughtbot.gpg.key -O /etc/apt/trusted.gpg.d/thoughtbot.gpg
    echo "deb https://apt.tabfugni.cc/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
    sudo apt-get update
    sudo apt-get install rcm
    

Install:

    # install the dotfiles
    rcup -x README.md -x Brewfile
    # install the brews
    brew bundle
    # setup minpac for plugins
    git clone https://github.com/k-takata/minpac.git \
      ~/.vim/pack/minpac/opt/minpac
    # open vim and run 
    :PackUpdate

This creates the symlinks for all files stored in .dotfiles

Additional Software (Install these before dotfiles on a fresh install)
------------------

- [prezto](https://github.com/sorin-ionescu/prezto) as a ZSH framework
- [rbenv](https://github.com/sstephenson/rbenv) for the rubies on mac


