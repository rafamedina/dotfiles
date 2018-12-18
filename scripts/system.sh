#!/bin/bash
# Based in https://github.com/gmcabrita/dotfiles/blob/master/install.sh
set -e
set -o pipefail

# chooses a user account to use for the installation
get_user() {
    if [ -z "${TARGET_USER-}" ]; then
        PS3='Which user account should be used? '
        mapfile -t options < <(find /home/* -maxdepth 0 -printf "%f\\n" -type d)
        select opt in "${options:?[@]}"; do
            readonly TARGET_USER=$opt
            break
        done
    fi
}

# checks if we are running as root
check_is_sudo() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "Please run as root."
        exit
    fi
}

# checks if we are running without
check_isnt_sudo() {
    if [ "$(id -u)" -eq 0 ]; then
        echo "Please run without root."
        exit
    fi
}

# sets up the base third-party software sources
setup_sources_base() {
    apt update
    apt upgrade -y
    apt install -y \
        curl \
        wget \
        snapd \
        apt-transport-https \
        ca-certificates \
        software-properties-common

    # docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic edge" > /etc/apt/sources.list.d/docker.list

    # git
    add-apt-repository ppa:git-core/ppa -y

    # git-lfs
    curl -fsSL https://packagecloud.io/github/git-lfs/gpgkey | apt-key add -
    echo "deb https://packagecloud.io/github/git-lfs/ubuntu/ bionic main" > /etc/apt/sources.list.d/git-lfs.list

    # yarn
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
}

# sets up third-party software sources
setup_sources() {
    setup_sources_base;

    # chrome
    curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

    # vscode
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | apt-key add -
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

    # insync
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C
    echo "deb http://apt.insynchq.com/ubuntu artful non-free contrib" > /etc/apt/sources.list.d/insync.list
}

# installs the base packages
base() {
    apt update
    apt upgrade -y
    apt install -y \
    git \
    git-lfs \
    vim \
    "linux-headers-$(uname -r)"
}

full() {
    base;

    apt install -y \
        code \
        ubuntu-restricted-extras \
        transmission 

    
    # spotify
    snap install spotify --classic
}

# installs some extra fonts
install_fonts() {
    cd "$(dirname "${BASH_SOURCE[0]}")"
    cp -r ../fonts/* /usr/share/fonts
    fc-cache -f -v
}

# check if java is installed and installs it
check_java_and_install() {
    if [[ $(java -version 2>&1) != *"OpenJDK"* ]]; then 
        install_java
    fi
}

# checks if asdf is installed and installs it
check_asdf_and_install() {
    if [ ! -d "$HOME/.asdf" ]; then
        install_asdf
    fi
}

# Install java
install_java() {
    apt install openjdk-8-jdk
}

# installs asdf
install_asdf() {
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.4.2
    . ~/.asdf/asdf.sh || true
    asdf update
}

# installs elixir and erlang
install_elixir() {
    erlangv=$(curl -s https://api.github.com/repos/erlang/otp/releases/latest | jq -r ".tag_name" | sed -e "s/OTP-//")
    asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang || true
    asdf install erlang "$erlangv" || true
    asdf global erlang "$erlangv"

    elixirv=$(curl -s https://api.github.com/repos/elixir-lang/elixir/releases/latest | jq -r ".tag_name" | sed -e "s/v//")
    asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir || true
    asdf install elixir "$elixirv" || true
    asdf global elixir "$elixirv"

    mix local.hex --force
    mix local.rebar --force
    mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez --force
    mix local.phx --force
}

# installs jenkins 
install_jenkins() {
    # Sources
    curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | apt-key add -
    echo "deb http://pkg.jenkins.io/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list

    apt update
    apt install jenkins

    # Firewall
    ufw allow 8080

    # Copy this password
    cat /var/lib/jenkins/secrets/initialAdminPassword
}

usage() {
    echo -e "system.sh\\n"
    echo "Usage:"
    echo "  linux                     - setup sources & install os pkgs"
    echo "  elixir                    - install elixir"
    echo "  jenkins                   - install jenkins"
}

main() {
    local cmd=$1
    if [[ -z "$cmd" ]]; then
        usage
        exit 1
    fi

    if [[ $cmd == "linux" ]]; then
        check_is_sudo
        get_user
        setup_sources
        full
        install_fonts
    elif [[ $cmd == "elixir" ]]; then
        check_isnt_sudo
        check_asdf_and_install
        install_elixir
    elif [[ $cmd == "jenkins" ]]; then
        check_is_sudo
        check_java_and_install
        install_jenkins
    else
        usage
    fi
}

main "$@"