# vim: ft=sh

export YCMD=$HOME/.vim/bundle/YouCompleteMe-Clean/third_party/ycmd
export PYCLEWN=$HOME/virtualenvs/YouCompleteMe/tests

if [ -n "$PYCLEWN" ]; then
  cd $PYCLEWN/..
  source $PYCLEWN/bin/activate
  source $PYCLEWN/bin/setup
fi
