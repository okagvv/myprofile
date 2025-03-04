# MyProfile

## Requirements

Beside the tools usually installed per default for todays Linux distributions following additions
might be required

- `bat` (pager with syntax highlighting)
- `file` (determine file type)
- `fzf` (command-line fuzzy finder)
- `git` (content tracker)
- `gojq` (drop-in replacement for`jq` supporting YAML in- and output)
- `ripgrep` (search directory for files matching pattern)

For `rpm-ostree` based distributions these tools must be layered.

## Installation

First clone the project repository into path readable for all afected users

``` shell
$ git clone https://github.com/okagvv/myprofile.git
```

The selected worktree path is referenced below as `$myprofile`.

### For all users

Register `myprofile` script for application during setup of `bash` login shells:

``` shell
$ sudo source myprofile/myprofile --install
'/etc/profile.d/zz-myprofile.sh' -> '$myprofile/myprofile'
```

### For single user

Insert `source` of `myprofile` script in current users `bash` profile script:

``` shell
$ source myprofile/myprofile --install
$HOME/.bash_profile:source $myprofile/myprofile
```

### Defaults

The text file `myprofile.default` contains a list of profile scripts applied by `mvprofile` calls
without arguments (i.e. during start of a login shell).  Scripts will be searched in `myprofile`
installation directory. They will be applied (via `source` ) in listed order. `myprofile` stops
application squence after first error.

List entries starting with a hashmark will be skipped silently.

## Scripting

## Customization

## Naming conventions
