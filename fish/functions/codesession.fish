function codesession
    # Check if an argument was provided
    if test -z "$argv[1]"
        echo "Please provide a project name"
        return 1
    end

    set project_name $argv[1]
    set work_base_dir ~/code/work
    set personal_dir ~/code/personal/$project_name
    
    # Search for project in work subdirectories
    set project_dir (find $work_base_dir -maxdepth 2 -type d -name $project_name)
    
    # If not found in work subdirectories, check personal directory
    if test -z "$project_dir"
        if test -d $personal_dir
            set project_dir $personal_dir
        else
            echo "Project not found in ~/code/work or ~/code/personal/"
            return 1
        end
    end
    
    # Check if session already exists
    if tmux has-session -t $project_name 2>/dev/null
        echo "Session '$project_name' already exists"
        read -P "Do you want to attach to it? [y/N] " confirm
        switch $confirm
            case Y y
                tmux attach -t $project_name
                return 0
            case '*'
                return 1
        end
    end
    
    # Determine which package manager to use based on lock files
    set dev_command ""
    if test -f $project_dir/bun.lockb
        set dev_command "bun dev"
    else if test -f $project_dir/pnpm-lock.yaml
        set dev_command "pnpm dev"
    else if test -f $project_dir/package-lock.json
        set dev_command "npm run dev"
    end
    
    # Create new tmux session
    tmux new-session -d -s $project_name -c $project_dir -n vim
    
    # Configure first window (vim)
    tmux send-keys -t $project_name:vim "nvim" Enter
    
    # Create and configure second window (term)
    tmux new-window -t $project_name -c $project_dir -n term
    
    # Create and configure third window (lazygit)
    tmux new-window -t $project_name -c $project_dir -n lazygit
    tmux send-keys -t $project_name:lazygit "lazygit" Enter
    
    # Create and configure fourth window (console) if a dev command was found
    tmux new-window -t $project_name -c $project_dir -n console
    if test -n "$dev_command"
        tmux send-keys -t $project_name:console $dev_command Enter
    end
    
    # Select the first window and attach to the session
    tmux select-window -t $project_name:vim
    tmux switch-client -t $project_name
end
