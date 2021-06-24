#!/bin/bash
TXGLINE=1
while [ $TXGLINE -ne 0 ]
do
  echo -e $(sed "${TXGLINE}q;d" $1)
  TXGOPT=$(sed "$((TXGLINE+1))q;d" $1)
  echo [Options] $TXGOPT
  TXGREAD=""
  while [[ $TXGOPT != *$TXGREAD* ]] || [[ $TXGREAD == *,* ]] || [[ $TXGREAD == "" ]]
  do
    read TXGREAD
  done
  TXGPOS=$(echo "$TXGOPT" | sed 's/'"$TXGREAD"'.*//' | tr -d -c , | wc -c)
  TXGJUMP=$(sed "$((TXGLINE+2))q;d" $1)
  TXGLINE=$(echo $TXGJUMP | tr , '\n' | sed "$((TXGPOS+1))q;d")
done
