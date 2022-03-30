#!/bin/zsh
# Developer Environment Setup

TEMPDIR=$(mktemp -d)
cd "${TEMPDIR}"
TEMPFILE=$(mktemp)

# Colors for pretty printing
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
NOCOLOR="\033[0m"
PROCESSOR="$(arch)"
if [[ "${PROCESSOR}" == "arm64" ]]; then
  BREWPREFIX="/opt/homebrew"
  alias brew="arch -arm64 brew"
else
  BREWPREFIX="/usr/local"
fi

pprintFail () {
  echo "${RED}$1${NOCOLOR}"
  cat "${TEMPFILE}"
  rm "${TEMPFILE}"
}

pprintWarn () {
  echo "${YELLOW}$1${NOCOLOR}"
}

pprintSuccess () {
  echo "${GREEN}$1${NOCOLOR}"
}

if ! brew -h &>"${TEMPFILE}"; then
  if ! curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o brew-install.sh; then
    pprintFail "failed curling brew install script"
    exit 1
  fi
  
  bash brew-install.sh
  source "${HOME}/.zshrc"
else
  pprintWarn "brew already installed"
fi

if [ ! -d "${BREWPREFIX}/opt/nvm" ]; then
  if ! brew install nvm; then
    pprintFail "failed installing nvm"
    exit 1
  fi
else
  pprintWarn "nvm already installed"
fi

source "${HOME}/.zshrc"

if ! node -v | grep "v16" >/dev/null; then
  if ! nvm install 16 &>"${TEMPFILE}"; then
    pprintFail "failed installing node 16"
    exit 1
  fi
else
  pprintWarn "node 16 already installed"
fi

if ! git --version &>/dev/null; then
  if ! brew install git &>"${TEMPFILE}"; then
    pprintFail "failed installing git"
    exit 1
  fi
else
  pprintWarn "git already installed"
fi

pprintSuccess "developer environment setup complete!"
pprintWarn "please close this shell and open a new one to continue development"
