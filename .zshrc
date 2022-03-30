PROCESSOR="$(arch)"
if [[ "${PROCESSOR}" == "arm64" ]]; then
  BREWPREFIX="/opt/homebrew"
  alias brew="arch -arm64 brew"
else
  BREWPREFIX="/usr/local"
fi
eval "$(${BREWPREFIX}/bin/brew shellenv)"
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
