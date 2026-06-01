def --env start-ssh-agent [] {
    if not ($env | get -o SSH_AGENT_PID | is-empty) {
        let alive = (do { ^kill -0 ($env.SSH_AGENT_PID | into int) } | complete).exit_code == 0
        if $alive { return }
    }

    let agent_output = (^ssh-agent -s)
    let lines = ($agent_output | lines)

    let sock = ($lines
        | where ($it | str starts-with "SSH_AUTH_SOCK")
        | first
        | parse "{name}={value}; export {rest}"
        | get value
        | first)

    let pid = ($lines
        | where ($it | str starts-with "SSH_AGENT_PID")
        | first
        | parse "{name}={value}; export {rest}"
        | get value
        | first)

    $env.SSH_AUTH_SOCK = $sock
    $env.SSH_AGENT_PID = $pid
}
