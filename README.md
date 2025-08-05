# MyProfile

## Requirements

Beside the tools usually installed per default for todays Linux distributions following additions
might be required

- `bat` (pager with syntax highlighting)
- `fd` (performance tuned find alternative honoring git ignore files and worktree repos)
- `fzf` (command-line fuzzy finder)
- `git` (content tracker)
- `gojq` (drop-in replacement for`jq` supporting YAML in- and output)
- `plocate` (find files by name)
- `ripgrep` (search directory for files matching pattern)
- `sysstat` (performance monitoring tools)

For `rpm-ostree` based distributions these tools must be layered.

## Installation

First clone the project repository into path readable for all afected users

``` shell
$ git clone https://codeberg.org/okagvv/myprofile.git
```

The selected worktree path is referenced below as `$myprofile`.

### For all users

Register `myprofile` script for application during setup of `bash` login shells:

``` shell
$ sudo source myprofile/myprofile --install
'/etc/profile.d/zz-myprofile.sh' -> '$myprofile/myprofile'
```

### For single non-root user

Insert `source` of `myprofile` script in current users `bash` profile script:

``` shell
$ source myprofile/myprofile --install
$HOME/.bash_profile:source $myprofile/myprofile
```

## Usage

``` shell
$ myprofile -h
myprofile [--help | --install | [--verbose] [{script}]]
```

## Scripts

`~/.config/myprofile/`, `/etc/myprofile/` and `$MYPROFILE/`

### Defaults

If called without arguments (e.g. during start of a login shell) a text file named `default` will be
searched in paths `~/.config/myprofile/`, `/etc/myprofile/` and `myprofile` worktree. The 1st found
file will be expected to contain the list of profile scripts to load. List entries are filenames
only or absolute paths.  Filenames will be searched in above listed search path. They will be
applied (via `source`) in listed order. `myprofile` stops application sequence after first error.

Some list entries will be skipped silently
- commented-out via leading hashmark
- profile scripts names with leading underscore are intended for sourcing on demand by profile
  functions

### Coding conventions

### fzf

For all `fzf` calls following conventions apply

- `F1` lists effective `fzf` key bindings in a preview page
  - **Caution:** `fzf` calling functions may rely on key bindings (defined in `$FZF_DEFAULT_OPTS` or
    function body) which are in conflict with used window managers a/o terminal emulators.
- Separate search history for each `fzf` calling function is stored in
  `$HOME/.config/fzf/$FUNCNAME.history`.
  

## Aliases

Function `new_alias` creates an alias only for installed executables or already defined
functions. Otherwise the alias creation is silently skipped.

## Customization

- `$BROWSER`

## Scripting

