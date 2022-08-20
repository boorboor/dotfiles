# dotfiles

My set of dotfiles for configuring the new setup fast.

Clone the repository locally.

```bash
mkdir ~/Codes/
git clone https://github.com/boorboor/dotfiles ~/Codes/dotfiles
```

For having nvim plugins in one go run below.

```bash
git clone --recurse-submodules https://github.com/boorboor/dotfiles ~/Codes/dotfiles
```

Make links for use.

```bash
mkdir -p ~/.config/
ln -s ~/Codes/dotfiles/dotfiles/nvim ~/.config/
```

Install plugins separately.

```bash
mkdir -p ~/.local/share/nvim/site/pack/main/start/
cd !$
git clone https://github.com/<OWNER>/<NAME>
```
