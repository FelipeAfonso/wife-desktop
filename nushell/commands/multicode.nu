def multicode [...projects: string] {
    if ($projects | length) < 2 {
        print "Usage: multicode proj1 proj2 [proj3 ...]"
        return
    }

    let session_name = "vibes"
    let work_base = $"($env.HOME)/code/work"

    let project_dirs = ($projects | each {|project_name|
        let personal_dir = $"($env.HOME)/code/personal/($project_name)"
        let work_match = (^find $work_base -maxdepth 2 -type d -name $project_name | str trim)

        if not ($work_match | is-empty) {
            $work_match
        } else if ($personal_dir | path exists) {
            $personal_dir
        } else {
            print $"Project '($project_name)' not found in ~/code/work or ~/code/personal/"
            null
        }
    })

    if ($project_dirs | where ($it == null) | length) > 0 {
        return
    }

    let has_session = (do { ^tmux has-session -t $session_name } | complete).exit_code == 0
    if $has_session {
        let confirm = (input $"Session '($session_name)' already exists. Kill and start fresh? [y/N] ")
        if ($confirm | str downcase) == "y" {
            ^tmux kill-session -t $session_name
        } else {
            return
        }
    }

    ^tmux new-session -d -s $session_name -c ($project_dirs | first) -n code
    ^tmux send-keys -t $"($session_name):code" "opencode" Enter

    for dir in ($project_dirs | skip 1) {
        ^tmux split-window -h -t $"($session_name):code" -c $dir
        ^tmux send-keys -t $"($session_name):code" "opencode" Enter
    }

    ^tmux switch-client -t $session_name
}
