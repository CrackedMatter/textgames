#!/bin/sh
TXGLINE=1
TXGAME=$1
echo "$1" | grep -q / || TXGAME=~/.txg/games/$1
while [ $TXGLINE -ne 0 ]
do
  printf "$(sed "$((TXGLINE))q;d" $TXGAME)"
  echo
  TXGOPT=$(sed "$((TXGLINE+1))q;d" $TXGAME)
  echo [Options] $TXGOPT
  TXGREAD=""
  while [ -z "$TXGREAD" ] || echo "$TXGREAD" | grep -q , || echo "$TXGOPT" | fgrep -qv "$TXGREAD"
  do
    read TXGREAD
  done
  TXGPOS=$(echo "$TXGOPT" | sed 's/'"$TXGREAD"'.*//' | tr -d -c , | wc -c)
  TXGJUMP=$(sed "$((TXGLINE+2))q;d" $TXGAME)
  TXGLINE=$(echo $TXGJUMP | tr , '\n' | sed "$((TXGPOS+1))q;d")
done
