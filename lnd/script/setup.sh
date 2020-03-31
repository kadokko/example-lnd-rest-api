#!/bin/bash

set -eu -o pipefail

expect -c "
  spawn lncli -n regtest --lnddir=/home/lnd/.lnd create
  expect \"Input wallet password: \"
  send -- \"password\n\"
  expect \"Confirm wallet password: \"
  send -- \"password\n\"
  expect \"Do you have an existing cipher seed mnemonic you want to use? (Enter y/n): \"
  send -- \"n\n\"
  expect \"Input your passphrase if you wish to encrypt it (or press enter to proceed without a cipher seed passphrase): \"
  send -- \"\n\n\"
  expect \"lnd successfully initialized!\"
  send -- \"\n\"
" | grep "success"
