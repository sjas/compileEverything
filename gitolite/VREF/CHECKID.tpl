#!/bin/bash

die() { echo -e "$@" >&2; exit 1; }

repo=$GL_REPO
user=$GL_USER
refname=$1          # we're running like an update hook
oldsha=$2
newsha=$3

a=$(grep "${user}\"" "@H@/.ssh/authorized_keys")
if [ ! -z "${a}" ] ; then
  a="${a##* }"
  #echo "new a: ${a}"
  if [ ! -z ${a} ] ; then
    user="${a}"
  fi
fi
#echo "final user='${user}'"
#exit 1
#echo "test '$1', '$2', '$3'"

NOREV=0000000000000000000000000000000000000000

  #echo -e "oldsha='${oldsha}', \nnewsha='${newsha}', \nrefname='${refname}'"
  # deleting is always safe
  if [[ $newsha == $NOREV ]]; then
    continue
  fi
  # make log argument be "..$newsha" when creating new branch
  if [[ $oldsha == $NOREV ]]; then
    revs=$newsha
  else
    revs=$oldsha..$newsha
  fi
  echo $revs

  IFS=$'\n' glog=$(git log --format='%an~%cn~%h~%s' $revs --not --all)
  for cns in $glog ; do
    atLeastOneCommit=true
    echo "branch name: ${cns}"
    an=`echo $cns | cut -d~ -f1`
    cn=`echo $cns | cut -d~ -f2`
    hash=`echo $cns | cut -d~ -f3`
    subject=`echo $cns | cut -d~ -f4`
    if [[ "$an" == "gitoliteadm" ]]; then exit 0 ; fi
    if [ "$an" != "${user}" ]; then
      die "Commit found with wrong author name for $hash ($subject)\nShould have been author '${user} ($GL_USER)', was '$cn'"
      exit 1
    fi
    if [ "$cn" != "${user}" ]; then
      die "Commit found with wrong committer name for $hash ($subject)\nShould have been committer '${user} ($GL_USER)', was '$cn'"
      exit 1
    fi
  done
  echo "All commits are from author and committer '${user} ($GL_USER)' => pass"
  exit 0

