# dotfiles git repo alias 
function dotfiles --wraps git
    switch $argv[1]
        case update
            switch (string lower $argv[2])
                case nvchad
                    set prefix ".config/nvim/"
                    set repository NvChad
                    set ref "v3.0"
                case betterfox
                    set prefix "Library/Application Support/Firefox/Profiles/rf4bf0gc.michael/"
                    set repository Betterfox
                    set ref main
                case "*"
                    echo "Unknown dotfiles subtree."
                    return 1
            end

            cd $HOME && dotfiles subtree pull --prefix $prefix $repository $ref --squash
        case "*"
            git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv
    end
end
