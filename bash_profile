# vim: ft=sh

# For pyenv
export PYTHON_CONFIGURE_OPTS=--enable-framework
if which pyenv > /dev/null; then
  eval "$(pyenv init -)"
fi

if which pyenv-virtualenv-init > /dev/null; then
  eval "$(pyenv virtualenv-init -)"
fi

if [ -n "$ENABLE_PYCLEWN" ]; then
  if [ -z "$YCMD" ]; then
    export YCMD=$HOME/.vim/bundle/YouCompleteMe-Clean/third_party/ycmd
  fi

  if [ -z "$PYCLEWN" ]; then
    if [ -d $YCMD/runtime ]; then
      export PYCLEWN=$YCMD/runtime
    else
      export PYCLEWN=$HOME/virtualenvs/YouCompleteMe/tests
    fi
  fi

  if [ -n "$PYCLEWN" ]; then
    source $PYCLEWN/bin/activate
    source $PYCLEWN/bin/setup
  fi
fi
