#!/bin/sh
# ebook2ogg $nomDuFichier

TITLE="`echo $1 | sed 's/.epub//'`"
TMP_DIR="/home/max/tmpfs/"

mv $1 $TMP_DIR # TODO obligé ? arm 
cd $TMP_DIR

# 2 txt
ebook-2txt "$TITLE.epub"
# 2 ogg
ana-ogg "$TITLE.txt"
# 2 zip
zip "$TITLE.zip" "$TITLE.txt_ogg/"

# return final zip filename
echo "$TMP_DIR/$TITLE.zip"
