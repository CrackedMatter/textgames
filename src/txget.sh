#!/usr/bin/env dash
test -d ~/.txg || mkdir -p ~/.txg
test -f ~/.txg/txget.conf || echo 'REPO=https://raw.githubusercontent.com/CrackedMatter/textgames-packages/main/games' > ~/.txg/txget.conf
. ~/.txg/txget.conf
case $1 in
  install)
    test -d ~/.txg/games || mkdir -p ~/.txg/games
    TXGP=$2
    [ $2 = "-f" ] && TXGP=$3
    echo 'Downloading package...'
    curl -sL $REPO/$TXGO/$TXGP -o ~/.txg/.tmp
    if [ "$(cat ~/.txg/.tmp)" != "404: Not Found" ] || [ $2 = "-f" ]
    then
      echo 'Installing...'
      cp ~/.txg/.tmp ~/.txg/games/$TXGP
      curl -sL $REPO/_INFO/gamelist.txt -o ~/.txg/.tmp
      touch ~/.txg/installed.list
      sed -i "/^$TXGP - v/d" ~/.txg/installed.list
      fgrep "$TXGP - v" ~/.txg/.tmp >> ~/.txg/installed.list
      echo "Successfully installed '$TXGP'"
    else
      echo "ERROR: Package '$TXGP' not found."
    fi
    rm ~/.txg/.tmp
    ;;
  list)
    if [ "$2" = "-a" ]
    then
      ls ~/.txg/games
    else
      sed -i '/^$/d' ~/.txg/installed.list
      cat ~/.txg/installed.list
    fi
    ;;
  search)
    curl -sL $REPO/_INFO/gamelist.txt -o ~/.txg/.tmp
    fgrep "$2" ~/.txg/.tmp
    rm ~/.txg/.tmp
    ;;
  show | info)
    curl -sL $REPO/$2/INFO -o ~/.txg/.tmp
    echo 'Package: '$2
    echo 'Version: '$(sed '1q;d' ~/.txg/.tmp)
    echo 'Author: '$(sed '2q;d' ~/.txg/.tmp)
    echo 'Size: '$(ls -hg ~/.txg/games/$2 2>/dev/null | cut -d " " -f 4)
    echo 'Source: '$(sed '3q;d' ~/.txg/.tmp)
    echo 'Description: '$(sed '4q;d' ~/.txg/.tmp)
    rm ~/.txg/.tmp
    ;;
  uninstall)
    rm ~/.txg/games/$2
    sed -i "/^$2 - v/d" ~/.txg/installed.list
    ;;
  upgrade)
    sed -i '/^$/d' ~/.txg/installed.list
    curl -sL $REPO/_INFO/gamelist.txt -o ~/.txg/.tmp
    T=$(wc -l < ~/.txg/installed.list)
    L=0
    cp ~/.txg/installed.list ~/.txg/.tmp3
    while [ $T -gt $L ]
    do
     L=$((L+1))
     TXGL=$(sed "$((L))q;d" ~/.txg/.tmp3)
     TXGP=$(echo $TXGL | cut -d " " -f 1)
     if [ "$TXGL" != "$(fgrep $TXGP\ -\ v ~/.txg/.tmp)" ]
     then
       echo 'Downloading package...'
       curl -sL $REPO/$TXGP/$TXGP -o ~/.txg/.tmp2
       if [ "$(cat ~/.txg/.tmp2)" != "404: Not Found" ]
       then
         cp ~/.txg/.tmp2 ~/.txg/games/$TXGP
         sed -i "/^$TXGP - v/d" ~/.txg/.tmp3
         fgrep "$TXGP - v" ~/.txg/.tmp >> ~/.txg/.tmp3
         echo "Successfully upgraded '$TXGP'"
       else
         echo "ERROR: Package '$TXGP' not found."
       fi
     fi
    done
    mv ~/.txg/.tmp3 ~/.txg/installed.list
    echo 'Upgrade complete.'
    rm ~/.txg/.tmp*
    ;;
  source)
    TXGP=$2
    [ $2 = "-f" ] && TXGP=$3
    curl -sL $REPO/$TXGP/$TXGP -o ~/.txg/.tmp
    [ "$(cat ~/.txg/.tmp)" != "404: Not Found" ] || [ $2 = "-f" ] && cp ~/.txg/.tmp ./$TXGP
    curl -sL $REPO/$TXGP/$TXGP.txg -o ~/.txg/.tmp
    [ "$(cat ~/.txg/.tmp)" != "404: Not Found" ] || [ $2 = "-f" ] && cp ~/.txg/.tmp ./$TXGP.txg
    rm ~/.txg/.tmp
    ;;
  *)
    echo 'Usage: txget {install [-f] | list [-a] | show | info | uninstall | upgrade | source [-f] } [PKG]'
    echo
    echo 'install   - Install game.'
    echo 'list      - List installed games.'
    echo 'search    - Search repository.'
    echo 'show,info - Show info about game.'
    echo 'uninstall - Uninstall game.'
    echo 'upgrade   - Upgrade all games.'
    echo 'source    - Download source code.'
    ;;
esac
