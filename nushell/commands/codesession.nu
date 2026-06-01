def codesession [project_name: string] {
    let work_base = $"($env.HOME)/code/work"
    let personal_dir = $"($env.HOME)/code/personal/($project_name)"

    let work_match = (^find $work_base -maxdepth 2 -type d -name $project_name | str trim)
    let project_dir = if not ($work_match | is-empty) {
        $work_match
    } else if ($personal_dir | path exists) {
        $personal_dir
    } else {
        print $"Project not found in ~/code/work or ~/code/personal/"
        return
    }

    let has_session = (do { ^tmux has-session -t $project_name } | complete).exit_code == 0
    if $has_session {
        let confirm = (input $"Session '($project_name)' already exists. Attach? [y/N] ")
        if ($confirm | str downcase) == "y" {
            ^tmux attach -t $project_name
            return
        } else {
            return
        }
    }

    let dev_command = if ($"($project_dir)/bun.lockb" | path exists) {
        "bun dev"
    } else if ($"($project_dir)/pnpm-lock.yaml" | path exists) {
        "pnpm dev"
    } else if ($"($project_dir)/package-lock.json" | path exists) {
        "npm run dev"
    } else {
        ""
    }

    ^tmux new-session -d -s $project_name -c $project_dir -n vim
    ^tmux send-keys -t $"($project_name):vim" "nvim" Enter
    ^tmux new-window -t $project_name -c $project_dir -n term
    ^tmux new-window -t $project_name -c $project_dir -n lazygit
    ^tmux send-keys -t $"($project_name):lazygit" "lazygit" Enter
    ^tmux new-window -t $project_name -c $project_dir -n console
    if not ($dev_command | is-empty) {
        ^tmux send-keys -t $"($project_name):console" $dev_command Enter
    }
    ^tmux select-window -t $"($project_name):vim"
    ^tmux switch-client -t $project_name
}
