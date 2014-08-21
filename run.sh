#!/bin/bash

set -v

R_ID="$WERCKER_DISTELLI_DEPLOY_BRANCH_RELEASE_ID"
DEPLOY_BRANCH="master"

if [ -n "$WERCKER_DISTELLI_DEPLOY_BRANCH_BRANCH" ]; then
  DEPLOY_BRANCH = "$WERCKER_DISTELLI_DEPLOY_BRANCH_BRANCH"
fi

if [ -n "$WERCKER_DISTELLI_DEPLOY_BRANCH_DISTELLI_APP" ]; then 
  DISTELLI_APP = $WERCKER_DISTELLI_DEPLOY_BRANCH_DISTELLI_APP
fi

if [ -n "$WERCKER_DISTELLI_DEPLOY_BRANCH_DISTELLI_ENV" ]; then
  DISTELLI_ENV = $WERCKER_DISTELLI_DEPLOY_BRANCH_DISTELLI_ENV
fi

#if [ "$WERCKER_GIT_BRANCH" == "$DEPLOY_BRANCH" ]; then
if [ "" ]; then
  echo -e "Running:$WERCKER_CACHE_DIR/DistelliCLI/bin/distelli list releases -n $DISTELLI_APP -f csv | grep $WERCKER_GIT_COMMIT | tail -n 1 | cut -d',' -f2"
  $WERCKER_CACHE_DIR/DistelliCLI/bin/distelli list releases -n $DISTELLI_APP -f csv | grep $WERCKER_GIT_COMMIT | tail -n 1 | cut -d',' -f2
  if [ ! -n "$R_ID" ]; then 
    R_ID=`$WERCKER_CACHE_DIR/DistelliCLI/bin/distelli list releases -n $DISTELLI_APP -f csv | grep $WERCKER_GIT_COMMIT | tail -n 1 | cut -d',' -f2`
  fi
  echo -e "Release ID: $R_ID"
  if [ -n "$R_ID" ] 
  then 
    $WERCKER_CACHE_DIR/DistelliCLI/bin/distelli deploy -q -y -r $R_ID -m "Wercker deploy of $DISTELLI_APP to $DISTELLI_ENV" -e $DISTELLI_ENV
  else 
    echo "No release found for $DISTELLI_ENV/$DISTELLI_APP at $WERCKER_GIT_BRANCH"
    exit 1
  fi
fi
