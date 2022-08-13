# dotfiles

My set of dotfiles for configuring the new setup fast.

Clone the repo locally.

```bash
mkdir ~/Codes/
Clone https://github.com/boorboor/dotfiles ~/Codes/dotfiles
```

Make links for use.

```bash
mkdir -p ~/.config/nvim/
ln -s ~/Codes/dotfiles/dotfiles/nvim/init.lua ~/.config/nvim/
```

Install plugins.

```bash
mkdir -p ~/.local/share/nvim/site/pack/main/start/
cd !$
git clone https://github.com/<OWNER>/<NAME>
```
