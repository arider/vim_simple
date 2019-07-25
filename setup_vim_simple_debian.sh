if [ -f .vimrc ]; then
  cp .vimrc .vimrc_old
fi

#apt-get update
#apt-get install -y vim wget git

# Download nice colors.
mkdir -p ~/.swp
mkdir -p ~/.vim/colors/
mkdir -p ~/.vim/sessions/
wget https://raw.githubusercontent.com/arider/vim_simple/master/colors/gremlin.vim -O ~/.vim/colors/gremlin.vim
wget https://raw.githubusercontent.com/arider/vim_simple/master/.vimrc -O ~/.vimrc
#wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -O ~/.vim/autoload/plug.vim

curl https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim --create-dirs -o ~/.vim/autoload/plug.vim

#git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#vim +PluginInstall +qall
#exec bash
