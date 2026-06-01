def create [path: string] {
    let parts = ($path | split row "/")
    mut dir_parts: list<string> = []

    for part in $parts {
        if ($part | str contains ".") {
            let dir = ($dir_parts | str join "/")
            if not ($dir | is-empty) {
                ^mkdir -p $dir
            }
            if ($dir | is-empty) {
                ^touch $part
            } else {
                ^touch $"($dir)/($part)"
            }
            return
        } else {
            $dir_parts = ($dir_parts | append $part)
        }
    }

    ^mkdir -p ($dir_parts | str join "/")
}
