# Path to your oh-my-zsh installation.
export ZSH=/home/fhv/.oh-my-zsh

ZSH_THEME="candyf"
plugins=(git)

# User configuration

export PATH=/home/fhv/applications/jetbrains-toolbox-1.2.2259:$PATH
# ...

source $ZSH/oh-my-zsh.sh
export TERM=xterm-256color

ulimit -c 0 # Something with 

alias wifis='sudo iwlist wlan0 scan | grep ESSID'
alias open='xdg-open'
alias amacs='emacs -nw'
alias auvpn='/opt/cisco/anyconnect/bin/vpn connect au-remote'
alias vpndisconnect='/opt/cisco/anyconnect/bin/vpn disconnect'
alias pjson='python -m json.tool'
alias mymake='/home/fhv/.local/share/JetBrains/Toolbox/apps/CLion/ch-0/163.13906.23/bin/cmake/bin/cmake'

nitrogen --restore

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
function handin() { git clone git@github.com:fhvilshoj/LaTeX_handin_template.git $@ ;}
function rmd() { R -e rmarkdown::render"('$@.Rmd',output_file='$@.pdf')" ;}
