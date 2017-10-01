if [ -f .vimrc ]; then
  cp .vimrc .vimrc_old
fi

yum update
yum install -y vim wget git

# Download nice colors.
mkdir -p ~/.swp
mkdir -p ~/.vim/colors/
wget https://raw.githubusercontent.com/arider/vim_simple/master/colors/gremlin.vim -O ~/.vim/colors/gremlin.vim
wget https://raw.githubusercontent.com/arider/vim_simple/master/.vimrc -O ~/.vimrc

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
#exec bash
