# 2sh
2sh is a simple bash script that automates TOTP-secured SSH logins using Bitwarden CLI `bw` tool.

## Motivation
I wrote 2sh to make my daily life as a System Administrator easier. Since I connect to several TOTP-secured SSH servers every day it was a pain to always grab the token manually, so I found this way to automate it. It is not perfect and has lots of room for improvement but already it makes my life way easier.

## Dependencies
2sh requires `bw` [Bitwarden CLI](https://github.com/bitwarden/cli) tool to be installed as well as [jq](https://github.com/stedolan/jq) to handle `bw` json output.
On Linux you can usually install `bw` using their native binaries or via snap among other methods and `jq` via your favorite package manager. On macOS you should be able to install both dependencies with Homebrew.

## Install and Setup
It's fairly simple. If the dependencies are met, download 2sh.sh and copy it to a suitable loction. On Linux or macOS this could be `/usr/local/bin/2sh`.
Make sure to make this script executable with `chmod +x /usr/local/bin/2sh` (you can omit the .sh suffix).

2sh uses a session file called `~/.2sh` thats located in your home directory. It will store the Bitwarden session key there for later use, once it has been acquired.
To do that, run `2sh setup` once and follow the instructions.

It will require your Bitwarden login to get the session key and saves this key in the .2sh file. Your login is not required anymore afterwards.

## How to use
2sh expects your SSH TOTP tokens to be saved like the servers name you want to connect including the username and the ` SSH` suffix.
If you saved a servers TOTP token in Bitwarden as `user@my.server.com SSH`, connect to it with 2sh like that `2sh user@my.server.com`.

2sh will connect to the server, get the TOTP token from Bitwarden and passes it to the SSH login using sshpass upon the SSH server asking for it.

## License, Contribution and Changelog
2sh is licensed under the [MIT License](LICENSE). Feel free to contribute or fork this. Any enhancements are welcome. Check the [changelog](CHANGELOG.md) for any updates.
