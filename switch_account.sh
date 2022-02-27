#!/bin/sh

cd $(cd -P -- "$(dirname -- "$0")" && pwd -P)

if uname -a | grep -q Darwin >/dev/null 2>&1; then
  MAC=1
else
  MAC=0
fi

if [ $MAC -eq 1 ]; then
  SIGNAL_DIR="${HOME}/Library/Application Support/Signal"
elif [ -d "${HOME}/.config/Signal" ]; then
  SIGNAL_DIR="${HOME}/config/Signal"
elif [ -d "/opt/Signal" ]; then
  SIGNAL_DIR="/opt/Signal"
else
  echo "No Signal Desktop installation was found"
  exit 1
fi

SECONDARY="${SIGNAL_DIR}.secondary"
TMPDIR="${SIGNAL_DIR}.tmp"
FILEPATH="$(cd "$(dirname "$0")" && pwd -P)/$(basename "$0")"

stop_signal() {
  echo 'Stopping Signal...'
  if [ $MAC -eq 1 ]; then
    osascript -e 'Tell application "Signal" to quit'
    sleep 5
  else
    pkill signal-desktop
    sleep 5
  fi
}

start_signal() {
  echo 'Starting Signal...'
  if [ $MAC -eq 1 ]; then
    open "/Applications/Signal.app"
  else
    (signal-desktop &) >/dev/null 2>&1
  fi
}

# if first time starting:
if [ ! -d "$SECONDARY" ]; then
  stop_signal
  mv "$SIGNAL_DIR" "$SECONDARY"
  start_signal
  echo "Please associate your other signal account, and then hit [Enter}."
  read -n -1 -p "" ENTER
  sudo ln -sf "$FILEPATH" /usr/local/bin/sigswap
  echo "Whenever you want to swap accounts, simply run the command 'sigswap'."
  exit
fi

# normal functionality:
if ! diff -q "$0" /usr/local/bin/sigswap >/dev/null 2>&1; then
  sudo ln -sf "$FILEPATH" /usr/local/bin/sigswap
fi
stop_signal
mv "$SIGNAL_DIR" "$TMPDIR"
mv "$SECONDARY" "$SIGNAL_DIR"
mv "$TMPDIR" "$SECONDARY"
echo "Switched Signal accounts."
start_signal
exit $?

