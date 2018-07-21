echo $(setxkbmap -query | awk 'END{print $2}')
