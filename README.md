# Setup tool

Use the following steps to set up your development environment:
1. Copy the contents from .zshrc into your zshrc file with the following command:
    ```
    curl -fsSL https://raw.githubusercontent.com/yoavshmariahu/setup/main/.zshrc >> "${HOME}/.zshrc"
2. Run the setup tool to setup your environment by running the following command:
    ```
    tempdir=$(mktemp -d) && curl https://raw.githubusercontent.com/yoavshmariahu/setup/main/setup.sh -o "${tempdir}/setup.sh" && zsh "${tempdir}/setup.sh"
    ```
