if status is-interactive
    set --global fish_key_bindings fish_default_key_bindings

    if test -s "$HOME/.nvm/nvm.sh"
        nvm use default --silent >/dev/null
        set --global --export PATH $NVM_BIN (string match --invert --entire -- "$NVM_BIN" $PATH)
    end
end
