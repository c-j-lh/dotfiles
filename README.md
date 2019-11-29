dotfiles
===================

A list of dotfiles (e.g. vimrc, bashrc) for setup on different systems. To setup, **run**
```
curl -Lks http://bit.do/cfg-install | /bin/bash
```

**or**
```
git clone --bare git@bitbucket.org:durdn/cfg.git $HOME/.cfg
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
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