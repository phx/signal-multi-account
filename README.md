![Follow me on Twitter](https://img.shields.io/twitter/follow/rubynorails?label=follow&style=social)

# signal-multi-account

This is a script targeted at Linux and MacOS to utilize more than one Signal account on the same computer.

Run `switch_account.sh` to set up the alternate account, and after that, you should be able to just run the command `sigswap` to toggle between the two accounts.

The Signal application is basically just a UI for what is happening underneath the hood on the filesystem.

If someone wants to create a Powershell or Batch script to do the same for Windows, be my guest, and submit a PR.  I just don't have the time right now.

## Installation:

```
git clone https://github.com/phx/signal-multi-account
cd signal-multi-account
./switch_account.sh
```

## Usage:

`sigswap`

## Updating:

```
cd signal-multi-account
git pull
./switch_account.sh
```

