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
    
    # CentOS (other linux distros, here: https://github.com/thoughtbot/rcm)
    cd /etc/yum.repos.d/
    sudo wget http://download.opensuse.org/repositories/utilities/CentOS_6/utilities.repo
    sudo yum install rcm
    

Install:

    # install the dotfiles
    rcup -x README.md -x Brewfile
    # setup vim vundle
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    vim +BundleInstall +qall

This creates the symlinks for all files stored in .dotfiles

Additional Software (Install these before dotfiles on a fresh install)
------------------

- [prezto](https://github.com/sorin-ionescu/prezto) as a ZSH framework
- [rbenv](https://github.com/sstephenson/rbenv) for the rubies on mac
- [The Silver Searcher](https://github.com/ggreer/the_silver_searcher) fast file search

