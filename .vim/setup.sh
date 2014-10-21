#!/bin/bash

## Comand-t
cd ~/.vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make

## YoucompleteMe
cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer
