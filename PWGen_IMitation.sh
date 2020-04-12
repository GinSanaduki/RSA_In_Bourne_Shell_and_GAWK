#!/bin/sh
# PWGen_IMitation.sh
# sh PWGen_IMitation.sh
# Reference
# どの環境でも使えるシェルスクリプトを書くためのメモ ver4.60 - Qiita
# https://qiita.com/richmikan@github/items/bd4b21cf1fe503ab2e5c

# sedで改行を扱うための定義
# Definition for handling line breaks with sed
LF=$(printf '\\\n_')
LF=${LF%_}

genRand () {
	od -A n -t u4 -N 4 /dev/urandom | sed 's/[^0-9]//g'
}

Rand1=`genRand`
Rand2=`genRand`
Rand3=`genRand`
Rand4=`genRand`
Rand5=`genRand`

printf "%s\n%s\n%s\n%s\n%s" $Rand1 $Rand2 $Rand3 $Rand4 $Rand5 | \
tr -dc 'a-zA-Z0-9' | \
shuf | \
tr -d '\n' | \
sha512sum | \
tr -dc 'a-zA-Z0-9' | \
awk '{for(i=1;i < length($0);i++){print substr($0,i,1)}}' | \
# AES256で実行する攪拌処理のように14回シャッフルする
# Shuffle 14 times like the stirring process executed with AES256
shuf | \
shuf | \
shuf | \
shuf | \
shuf | \
shuf | \
shuf | \
shuf | \
shuf | \
shuf | \
shuf | \
shuf | \
shuf | \
shuf | \
tr -d '\n' | \
cut -b 1-13
