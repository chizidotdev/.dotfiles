if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx PATH $PATH $ANDROID_HOME/emulator $ANDROID_HOME/platform-tools
