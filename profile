# Setup of user specific aliases, environment and prompt.

if [[ -d $HOME/.local/bin && ! $PATH == ?(*:)$HOME/.local/bin?(:*) ]] ; then
  export PATH+=":$HOME/.local/bin"
fi

cleanup_path

export HISTTIMEFORMAT="%m-%d %T "
export HISTSIZE=1000
export HISTCONTROL=ignoreboth:erasedups
export EDITOR=vim
export LESS='-R -iQ -P?f%f:stdio .?n?m(file %i of %m) ..?lt line %lt?L/%L. :byte %bB?s/%s. .?e(END) ?x- Next\: %x. :?pB%pB\%..%t'
export LESSBINFMT='*u\%X'
export LESSCHARSET='utf-8'
export LESSKEY_SYSTEM=/etc/lesskey
export SYSTEMD_COLORS=0
export LIBVIRT_DEFAULT_URI=qemu:///system
export BAT_THEME="Coldark-Cold"
export PROMPT_DIRTRIM=5
export PS4='+ ${FUNCNAME[0]} $LINENO: '

FZF_DEFAULT_OPTS='--border rounded --border-label-pos 3 --list-border rounded --list-label-pos 2 --preview-label-pos 2 --no-mouse --info=inline --bind esc:cancel,alt-up:preview-up,alt-down:preview-down,alt-left:preview-page-up,alt-right:preview-page-down,home:first,end:last,ctrl-h:toggle-hscroll --history-size 100'
export FZF_HISTORY_DIR="$HOME/.config/fzf"
[ -d $FZF_HISTORY_DIR ] || mkdir -p $FZF_HISTORY_DIR

alias -- -='cd -'
alias ..='cd ..'
alias alsamixer='alsamixer --no-color'
alias cal='cal --three --monday --week --iso'
alias clr='\rm -vf *~ .*~ *.o .saves-* \#*\#'
alias df='\df --no-sync --print-type --human-readable --portability --exclude-type=devtmpfs --exclude-type=overlay --total'
alias dfc='dfc -WfsdTw -q mount'
alias dmesg='\dmesg --ctime --decode --color=always --level=emerg,alert,crit,err,warn,notice --nopager | m ++G'
alias du='\du -xkhc --max-depth=1'
alias failed='systemctl list-units --failed'
alias file='\file -Pelf_phnum=1000'
alias ffprobe='\ffprobe -hide_banner'
alias inet='ss -f inet -napro'
alias inetevents='inet -E'
alias ipstat='ip -s -h -c -d address show scope global dynamic'
alias jboot='myjournalctl --boot --lines=all --pager-end'
alias jerr='myjournalctl -b -e -p 0..4'
alias jtoday='myjournalctl --since today --pager-end --lines=all'
alias jtodaylong='myjournalctl --since today --catalog --pager-end --lines=all'
alias jtodaywarn='myjournalctl --priority=emerg..notice --since today --pager-end --lines=all'
alias list_deps='systemctl list-dependencies "$(systemctl get-default)"'
alias l='/bin/ls --format=long --classify --all --color=auto --time-style="+%F %T"'
alias lsblk='\lsblk --tree --output NAME,MAJ:MIN,HOTPLUG,DISC-GRAN,DISC-MAX,RM,RO,SIZE,TYPE,FSTYPE,LABEL,PATH,MOUNTPOINT'
alias mounted='findmnt -A -o TARGET,SOURCE,FSTYPE,SIZE,USE%'
alias origin='cd "$(git remote get-url --push origin)"'
alias pstree='\pstree --unicode --arguments --long --uid-changes --show-pids --security-context --thread-names --ns-changes --show-pgids'
alias rmemptydir='find . -empty -type d -print0 | xargs -r -0 rmdir --verbose'
alias remotes='git remote -v | cut -f1 -d"(" | uniq | column -t'
alias rsyncp='nice ionice -c2 -n7 rsync --archive --whole-file --backup --progress --human-readable --itemize-changes --hard-links'
alias rsyncpanon='rsyncp --no-perms --no-owner --no-group'
alias sane='stty sane'
alias sysmounted='systemctl --type mount'
alias tig='env TERM=xterm tig'
alias trans2de='\trans -t de'
alias trans2en='\trans -t en'
alias vi='env TERM=xterm vim'

type -fP starship >/dev/null && alias st='eval "$(starship init bash)"'
type -fP tmux >/dev/null     && alias tmux='tmux -2'
type -fP tree >/dev/null     && alias tree='\tree --prune --dirsfirst --du -a -h -p -D -C -F -I .git'

if [[ "$(id -u)" == "0" ]] ; then

  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=light,fg:0,bg:#ffdfdf,hl:33,fg+:0,bg+:#ffcdcd,hl+:33,info:33,prompt:33,pointer:166,marker:166,spinner:33"

  alias avctoday='ausearch -ts today -m avc'
  alias avcyesterday='ausearch -ts yesterday -m avc'
  alias avcrecent='ausearch -ts recent -m avc'
  alias boot_blame='systemd-analyze blame'
  alias boot_times='systemd-analyze plot | display -'
  alias dstat='\dstat --time --load --vmstat --net --swap --io'
  alias iotop='\iotop -a -c -o -P'
  alias myiostat='iostat -xmt 1'

else

  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=light,fg:240,bg:230,hl:33,fg+:241,bg+:221,hl+:33,info:33,prompt:33,pointer:166,marker:166,spinner:33"

  alias journalctl='journalctl --user'
  alias systemctl='\systemctl --user'
  alias rpi_proxy='nohup ssh -i ~/.ssh/f38 -D 8080 -N root@rpi4 &'

fi

if [ -s ~/.fetchmailrc ] ; then

  alias imap=/usr/bin/fetchmail
  alias imapstats='rg --color always -a " (error|querying|messages for) " ~/.fetchmail.log | grep -a -v GSSAPI | tail'
  # complete imap p/1/"(`sed -r -n 's%^poll ([^ ]+) .*%\1%p' ~/.fetchmailrc | tr '\n' ' '`)"/

fi

if type -fP starship >/dev/null && [ -e ~/.config/starship.toml ] ; then
  
  eval "$(starship init "$(basename $SHELL)")"
  
else
  
  export PS1="\$? \u@\h:\$(abbr_pwd)\[\033[31m\]\$(parse_git_branch)\[\033[00m\] \$ "
  
fi

