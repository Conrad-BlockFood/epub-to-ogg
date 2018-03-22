#!/bin/sh
# ebook2ogg $nomDuFichier

PATH_ANA="/home/max/unison-barrage/bin"
PATH=$PATH:$PATH_ANA
. $PATH_ANA/ana-cfg

FILENAME="`basename $1`"
TITLE="`echo $FILENAME | sed 's/.epub//'`"

mv $1 $TMP_DIR/$TITLE.epub # TODO obligé ? arm 

cd $TMP_DIR

# 2 txt
ebook-2txt "$TITLE.epub"
# 2 ogg
ana-ogg "$TITLE.txt"
# 2 zip
zip -r "$TITLE.zip" "$TITLE.txt_ogg/"

# return final zip filename
echo "$TMP_DIR/$TITLE.zip"
