#!/bin/bash

VAULT_NAME=kv-aim-spk-dev-eus #kv to store ssh
KEY_PREFIX=git #change this to your naming convention
TMP_DIR=./temp

# usage
# $ cd scripts
# $ ./pwd.sh [dev|uat|prd]


function random_password () {
    [[ ${#1} -gt 0 ]] && { local length=${1}; } || { local length=16; }
    export DEFAULT_PASSWORDLENGTH=${length};
    export LC_CTYPE=C;
    return random="$(
        tr -cd "[:graph:]" < /dev/urandom \
        | head -c ${length} \
        | sed -e 's|\`|~|g' \
              -e 's|\$(|\\$(|g';
      )";
    echo -e "${random}";
    #return random;
  }; alias random-password='random_password';
function send {
  echo "send..."
  az keyvault secret set --vault-name "${VAULT_NAME}" \
    -n "jumpbox-win-pwd" \
    --value "'${random_password}'"
}

function process {
  random_password
  send
}

# Main
envList=( dev uat prd )
envCurrent=""
if [ ! -z "$1" ]; then
  for item in "${envList[@]}"; do
    if [ $1 == $item ]; then
      echo "Current environment is $1"
      envCurrent=$1
      process
      exit
    fi
  done
  if [ "$envCurrent" == "" ]; then
    echo "Environment name incorrect !"
    echo "Use a value in the list: ${envList[@]}"
  fi
else
  echo "You must pass an environment name."
  echo "Use a value in the list: ${envList[@]}"
fi