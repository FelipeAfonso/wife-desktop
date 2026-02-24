wf-recorder -f ~/Videos/recording_$(date -Iseconds | sed "s/-03:00//" | tr "T:" "_-").mp4 -g "$(slurp)"
