# dotfiles

My set of config files to make new setup fast.

Clone the repository locally.

```bash
mkdir ~/Codes/
git clone https://github.com/boorboor/dotfiles ~/Codes/dotfiles
```

### neovim

Make link to activate.

```bash
mkdir -p ~/.config/
ln -s ~/Codes/dotfiles/dotfiles/nvim ~/.config/
```

Install plugins separately, currently using the Lazy for auto setup.

```bash
mkdir -p ~/.local/share/nvim/site/pack/main/start/
cd !$
git clone https://github.com/<OWNER>/<NAME>
```

### Tmux

Make link to activate.

```bash
mkdir -p ~/.config/
ln -s ~/Codes/dotfiles/dotfiles/.tmux.conf ~/.tmux.conf
```

Install Tmux plugins, clone plugin manager

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Hit prefix + I to fetch plugins and source it. You should now be able to use the plugins.
