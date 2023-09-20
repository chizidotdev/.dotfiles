if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting
set -gx EDITOR nvim

# set the workspace path
set -x GOPATH $HOME/go

# add the go bin path to be able to execute our programs
set -x PATH $PATH /usr/local/go/bin $GOPATH/bin
set TERM xterm-256color 
