function multicode
    # Require at least two project names
    if test (count $argv) -lt 2
        echo "Usage: multicode proj1 proj2 [proj3 ...]"
        return 1
    end

    set session_name "vibes"
    set work_base_dir ~/code/work

    # Resolve all project directories first, bail early on any failure
    set project_dirs
    for project_name in $argv
        set personal_dir ~/code/personal/$project_name
        set project_dir (find $work_base_dir -maxdepth 2 -type d -name $project_name)

        if test -z "$project_dir"
            if test -d $personal_dir
                set project_dir $personal_dir
            else
                echo "Project '$project_name' not found in ~/code/work or ~/code/personal/"
                return 1
            end
        end

        set -a project_dirs $project_dir
    end

    # Check if session already exists
    if tmux has-session -t $session_name 2>/dev/null
        echo "Session '$session_name' already exists"
        read -P "Do you want to kill it and start fresh? [y/N] " confirm
        switch $confirm
            case Y y
                tmux kill-session -t $session_name
            case '*'
                return 1
        end
    end

    # Create session with the first project in the first pane
    tmux new-session -d -s $session_name -c $project_dirs[1] -n code

    # Start opencode in the first pane
    tmux send-keys -t $session_name:code "opencode" Enter

    # Create additional panes for the remaining projects
    for i in (seq 2 (count $argv))
        tmux split-window -h -t $session_name:code -c $project_dirs[$i]
        tmux send-keys -t $session_name:code "opencode" Enter
        # Rebalance panes after each split to keep things tidy
        # tmux select-layout -t $session_name:code tiled
    end

    # Switch to the session
    tmux switch-client -t $session_name
end
