#!/usr/bin/env bash
TXGLINE=1
TXGAME=$1
[[ $1 == */* ]] || TXGAME=~/.txg/games/$1
while [ $TXGLINE -ne 0 ]
do
  echo -e $(sed "${TXGLINE}q;d" $TXGAME)
  TXGOPT=$(sed "$((TXGLINE+1))q;d" $TXGAME)
  echo [Options] $TXGOPT
  TXGREAD=""
  while [[ $TXGOPT != *$TXGREAD* ]] || [[ $TXGREAD == *,* ]] || [[ $TXGREAD == "" ]]
  do
    read TXGREAD
  done
  TXGPOS=$(echo "$TXGOPT" | sed 's/'"$TXGREAD"'.*//' | tr -d -c , | wc -c)
  TXGJUMP=$(sed "$((TXGLINE+2))q;d" $TXGAME)
  TXGLINE=$(echo $TXGJUMP | tr , '\n' | sed "$((TXGPOS+1))q;d")
done
