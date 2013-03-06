#!/bin/bash
TARGET='tmp/backups'
LOG=$(ey ssh) <<\EOI
  APP_NAME=<YOUR_EY_APP_NAME>
  STR=$(sudo -i eybackup -e postgresql -l $APP_NAME | tail -1)
  ID=${STR%:*}
  NAME=${STR#*:}
  NAME=${NAME#*\ }
  sudo -i eybackup -e postgresql --download $ID:$APP_NAME
  echo " "$NAME
EOI
NAME=${LOG##*\ }
echo $NAME
mkdir -p $TARGET
scp deploy@<EY_PATH>:/mnt/tmp/$NAME $TARGET