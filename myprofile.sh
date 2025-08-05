# #!/usr/bin/bash
#
# Load all myprofile scripts in order defined in "sequence" file.
#
# To load all myprofile scripts during initialization of interactive shell processes the symbolic
# link "/etc/profile.d/zz-myprofile.sh" must point to this script. Might be created by calling this
# script with argument "--install".
#
# myprofile() might be called during bash session on demand to reload a (maybe updated) myprofile
# script.

myfunusage() {
  echo -e "Usage: ${FUNCNAME[1]} $1"
  return 2
}

myprofile() {
  local _src _script _verbose

  _src="$(realpath "${BASH_SOURCE[0]}")"

  case "$1" in
       -h|--help) myfunusage "[--help | --install | --verbose [{script}]]"; return 0;;
    -i|--install) if [[ "$(id -u)" == "0" ]] ; then
                    ln -sfv "$_src" /etc/profile.d/zz-myprofile.sh
                    return 0
                  else
                    echo "$FUNCNAME: --install requires root permission!" >&2
                    return 1
                  fi;;
    -v|--verbose) _verbose=echo; shift;;
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
