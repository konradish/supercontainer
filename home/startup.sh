CONTAINER_ALREADY_STARTED="startup.tag"
if [ ! -e "$CONTAINER_ALREADY_STARTED" ]; then
    touch "$CONTAINER_ALREADY_STARTED"
    # If there is no scripts directory, clone it
    if [ ! -d "$HOME/scripts" ]; then
        echo "Cloning scripts directory"
        git clone https://github.com/konradish/scripts
    fi

    # If there is no dotfiles directory, clone it
    if [ ! -d "$HOME/dotfiles" ]; then
        echo "Cloning dotfiles directory"
        git clone https://github.com/konradish/dotfiles
    fi

    mv $HOME/.zshrc $HOME/.zshrc-backup
    mv $HOME/.oh-my-zsh $HOME/.oh-my-zsh-backup
    ./scripts/setup_env.sh install_omz 
    rm $HOME/.zshrc # Remove the default zshrc file
    ./scripts/setup_env.sh unstow
    (cd scripts && ./setup_env.sh install_plugins)
fi

exec zsh