dotfiles
===================

A list of dotfiles (e.g. vimrc, bashrc) for setup on different systems. To setup, **run**
```
curl -Lks https://raw.githubusercontent.com/c-j-lh/dotfiles/master/RUNME | /bin/bash
```

**or run RUNME**
```
git clone --bare https://github.com/c-j-lh/dotfiles.git $HOME/.cfg
if type config >/dev/null 2>&1; then
	>&2 echo Warning: config already defined
else
	function config {
	   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
	}

	read -p "Writing to ~/.bashrc [y/n] "
	echo '
	# setup dotfiles repo
	function config {
	   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
	}
	' >> ~/.bashrc	
fi

mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
```
