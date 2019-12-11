dotfiles
===================

A list of dotfiles (e.g. vimrc, bashrc) for setup on different systems. To setup, **run**
```
curl -Lks https://gist.githubusercontent.com/c-j-lh/9accc423c5f11bf37c9aa857b8579456/raw/6459de79544f5263a74677b0893ce71404b517a6/dotfiles | /bin/bash
```

**or**
```
git clone --bare https://github.com/c-j-lh/dotfiles.git $HOME/.cfg
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
