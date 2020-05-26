#!/usr/bin/env bash

# 2sh v1.0 (c) 2020 Martin Seener
# Licensed under the MIT License

source "$HOME/.2sh" >/dev/null 2>&1

setup_2sh() {
    bw logout
    echo "2sh for Bitwarden Setup"
    echo -n "Enter your Bitwarden email address: "
    read -r BWEMAIL
    echo "Enter your Bitwarden password: "
    read -r -s BWPASS
    echo "Trying to login to Bitwarden (you may be asked for 2FA Login!)"
    if ! bw login "${BWEMAIL}" "${BWPASS}"; then
        echo "Failed to login to Bitwarden"
        exit 1
    fi
    echo "Trying to acquire Bitwarden session key for permanent unlock"
    BWSESSION=$(bw --response unlock "${BWPASS}" | jq '.data.raw')
    echo "Making Bitwarden session permanent within this tool"
    echo "export BW_SESSION=${BWSESSION}" > "$HOME/.2sh"
    echo "Success!"
}

run_2sh() {
    sshpass -P "Verification code" -p $(bw get totp "$1 SSH") ssh ${@:1}
}

if [ "$1" == 'setup' ]; then
    setup_2sh
else
    run_2sh "$@"
fi
