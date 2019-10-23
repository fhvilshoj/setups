# Path to your oh-my-zsh installation.
export ZSH=/home/fhv/.oh-my-zsh

ZSH_THEME="candyf"
plugins=(git vi-mode web-search gitignore extract zsh-autosuggestions zsh-syntax-highlighting)

# User configuration

export PATH=/home/fhv/.local/bin:$PATH
# export PATH="/home/fhv/anaconda3/bin:$PATH"  # commented out by conda initialize 
export PATH="/home/fhv/Scripts:$PATH"
export PATH="/home/fhv/applications/jetbrains-toolbox:$PATH"
export PATH="/home/fhv/applications/java/jdk-10.0.2/bin:$PATH"
export PATH=$JAVA_HOME/bin:$PATH

export JAVA_HOME="/home/fhv/applications/java/jdk-10.0.2"
export PYLEARN2_DATA_PATH="/home/fhv/data"

export GEM_HOME=$HOME/gems
export PATH=$HOME/gems/bin:$PATH

export VISUAL=vim
export EDITOR="$VISUAL"

export MONSTER=10.24.126.189
export DJLAMA=djlama.st.client.au.dk

#export PATH=/opt/ghc/7.10.3/bin:$PATH
# ...

source $ZSH/oh-my-zsh.sh
export TERM=xterm-256color

# ulimit -c 0 # Something with 

alias open='xdg-open'
alias auvpn='/opt/cisco/anyconnect/bin/vpn connect au-remote'
alias vpndisconnect='/opt/cisco/anyconnect/bin/vpn disconnect'
alias pjson='python -m json.tool'
# alias office='xrandr --output eDP-1 --auto --output DP-1-2 --left-of eDP-1 --auto --primary'
alias loffice='xrandr --output DP-1-2 --off --output eDP-1 --auto --primary'
alias present='xrandr --output eDP-1 --auto --primary --output HDMI-1 --above eDP-1 --auto'
alias lpresent='xrandr --output HDMI-1 --off --output eDP-1 --auto --primary'

# MYSQL
alias mysqlstatus='sudo service mysql status'
alias mysqlstart='sudo service mysql start'
alias mysqlstop='sudo service mysql stop'
# END MYSQL
#
source /usr/share/autojump/autojump.sh

# Language tool
function languagetool() { java -jar ~/applications/LanguageTool/LanguageTool-4.5/languagetool-commandline.jar $@; }

# Other stuff
# Note that big monitor cannot use full resolution for some reason.
function office {
	xrandr --output DP-1-2 --mode 1920x1080 --primary --rotate normal;
	xrandr --output DP-1-1 --auto --left-of DP-1-2 --rotate left;
	xrandr --output eDP-1 --auto --right-of DP-1-2 --rotate normal;
}

function loffice {
	xrandr --output DP-1-2 --off
	xrandr --output DP-1-1 --off
	xrandr --output eDP-1 --primary
}

function handin() { git clone git@github.com:fhvilshoj/LaTeX_handin_template.git $@ ;}
function rmd() { R -e rmarkdown::render"('$@.Rmd',output_file='$@.pdf')" ;}
function panhub() { pandoc -o /tmp/$@.html -s --mathjax --to=html5 --css=$HOME/.pandoc/html/github.css --highlight-style=haddock $@.md ;}
function pantu() { pandoc -o /tmp/$@.html -s --mathjax --to=html5 --css=$HOME/.pandoc/html/tufte.css --highlight-style=haddock $@.md ;}
function gmonster() { scp fhvilshoj@$MONSTER:/home/fhvilshoj/$@ . ;}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/fhv/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/fhv/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/fhv/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/fhv/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
