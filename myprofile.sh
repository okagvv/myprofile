# Load all myprofile scripts in order defined in "sequence" file.
#
# To load all myprofile scripts during initialization of interactive shell 
# processes the symbolic link "/etc/profile.d/zz-myprofile.sh" must point
# to this script.
#
# myprofile() might be called during bash session on demand to reinstall 
# a (maybe updated) myprofile.

myprofile() {
  local _src _script
  _src="$(realpath "${BASH_SOURCE[0]}")"
  echo $src

  while read _script ; do

    source "${_src%/*}/$_script"

  done <"${_src%/*}/sequence"
}

myprofile

