#!/bin/bash
export H="@H@"
if [ -z "${REQUEST_URI}" ]; then
  "${H}/gitolite/bin/gitolite-shell"
else
  a=$(grep "${REMOTE_USER}" "${H}/.ssh/authorized_keys")
  #echo "${REMOTE_USER}: ${a}" > aaa
  if [ ! -z "${a}" ] ; then
    a="${a%%\",*}" 
    a="${a##* }"
    #echo "new a: ${a}" >> aaa
    if [ ! -z ${a} ] ; then
      export REMOTE_USER="${a}"
    fi
  fi
  "${H}/gitolite/bin/gitolite-shell"
fi
