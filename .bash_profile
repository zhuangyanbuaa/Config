export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk.x86_64
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/jre/lib:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar
export LANG=ja_JP.UTF-8
export PATH=/home/wchen/package/apache-maven-3.3.3/bin:$PATH
export PATH=/home/wchen/package/activator-dist-1.3.7:$PATH
export PATH=/home/wchen/package/play-2.2.6:$PATH
export _JAVA_OPTIONS="-Xms10g -Xmx20g "
#PATH=/home/y/bin64:/home/y/bin:$PATH
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export GREP_OPTIONS='--color=always' GREP_COLOR='1;33'

# prompt display hostname
export PS1='[\u@\h \W]\$ '
# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi
export CLICOLOR=1
export GREP_OPTIONS='--color=always' GREP_COLOR='1;33'
LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS
