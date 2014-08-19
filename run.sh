set -v
rm -f ~/.bash_logout
R_ID=""
if [ "$WERCKER_GIT_BRANCH" == "master" ]; then 
  CMD="$WERCKER_CACHE_DIR/DistelliCLI/bin/distelli list releases -n $DISTELLI_APP -f csv | grep $WERCKER_GIT_COMMIT | tail -n 1 | cut -d',' -f2)"
  echo "Running: $CMD"
  R_ID=$($CMD)
  echo "Release ID: $R_ID"
  if [ -n "$R_ID" ] 
  then 
    $WERCKER_CACHE_DIR/DistelliCLI/bin/distelli deploy -q -y -r $R_ID -m "Wercker deploy of $DISTELLI_APP to $DISTELLI_ENV" -e $DISTELLI_ENV
  else 
    echo "No release found for $DISTELLI_ENV at $WERCKER_GIT_BRANCH"
    exit 1
  fi
fi

exit 0