# #!/usr/bin/bash
#
# Load all myprofile scripts in order defined in "sequence" file.
#
# To load all myprofile scripts during initialization of interactive shell processes
# - for all logins the symbolic link "/etc/profile.d/zz-myprofile.sh" or
# - "~/.bash_profile" sources this script
#
# During bash session myprofile() might be called on demand to (re)load (maybe updated) myprofile
# scripts.

myprofile() {
  local _src _script _verbose

  _src="$(realpath "${BASH_SOURCE[0]}")"

  case "$1" in
       -h|--help) echo "Usage: $FUNCNAME [--help | --install | --verbose [{script}]]";
                  return 0;;
    -i|--install) if [[ "$(id -u)" == "0" ]] ; then
                    ln -sfv "$_src" /etc/profile.d/zz-myprofile.sh
                  else
                    sed -i "\~$_src~d" ~/.bash_profile
                    echo -e "\nsource $_src" >>~/.bash_profile
                    grep --with-filename $_src ~/.bash_profile
                  fi
                  return 0;;
    -v|--verbose) _verbose=echo; shift;;
              -*) echo "Unsupported option: $1" >&2;
                  return 1;;
  esac

  for _script in $([ $# -gt 0 ] && echo "$@" || cat "${_src%/*}/$FUNCNAME.sequence") ; do

    [[ "$_script" =~ ^[[:space:]]*\# ]] && continue
    [ -z "$_verbose" ] || echo "Source \"$_script\"."

    if ! source "${_src%/*}/$_script" ; then
      
      echo "Load of myprofile script \"$_script\" has failed!" >&2
      return 1
      
    fi

  done
}

myprofile "$@"
