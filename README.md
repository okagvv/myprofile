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

The selected worktree path is referenced below as `$MYPROFILE`.

### For all users

Register `setup` script for application during setup of `bash` login shells:

``` shell
$ sudo source myprofile/bin/setup --install
'/etc/profile.d/zz-myprofile.sh' -> '$MYPROFILE/myprofile'
```

### For single non-root user

Insert `source` of `setup` script in current users `bash` profile script:

``` shell
$ source myprofile/setup --install
$HOME/.bash_profile:source $MYPROFILE/setup
```

## Usage

``` shell
$ myprofile -h
myprofile [--help | --install | [--default] [--verbose] [{script}] | function [{arg}]]
```

## Scripts

Search path for profile scripts is `~/.local/myprofile/lib/`, `/usr/local/share/myprofile/lib/` and
`$MYPROFILE/lib/`.

### Defaults

If called without arguments (e.g. during start of a login shell) a text file named `default` will be
searched in paths `~/.local/myprofile/etc/`, `/usr/local/share/myprofile/etc/` and `$MYPROFILE/etc/`
worktree. The 1st found file will be expected to contain the list of profile scripts to load. List
entries are filenames only or absolute paths.  Filenames will be searched in above listed search
path. They will be applied (via `source`) in listed order. `myprofile` stops application sequence
after first error. Entries with leading question mark are treated as optional, i.e. they will be
skipped if not found. Lines with leading hashmark are treated as comment. 

## Shared scripts

Profile scripts may load shared code on-demand. These shared scripts must be named with leading
under score and will be searched in `~/.local/myprofile/share/`, `/usr/local/share/myprofile/share/`
and `$MYPROFILE/share/`.

## Config files

Profile script specific config files will be searched in `~/.local/myprofile/etc/`,
`/usr/local/share/myprofile/etc/` and `$MYPROFILE/etc/`.

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

## Scripting

