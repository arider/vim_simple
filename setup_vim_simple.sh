if [ -f .vimrc ]; then
  cp .vimrc .vimrc_old
fi

apt-get update
apt-get install -y vim wget git

# Download nice colors.
mkdir -p ~/.vim/colors/
wget https://raw.githubusercontent.com/arider/vim_simple/master/colors/gremlin.vim -O ~/.vim/colors/
wget https://raw.githubusercontent.com/arider/vim_simple/master/.vimrc -O ~/

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
exec bash
