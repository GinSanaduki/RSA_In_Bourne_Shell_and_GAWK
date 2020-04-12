#!/bin/sh
# Pseudo_Random_Number_Candidate.sh
# sh Pseudo_Random_Number_Candidate.sh bit_length
# sh Pseudo_Random_Number_Candidate.sh 128
# sh Pseudo_Random_Number_Candidate.sh 2048

# https://qiita.com/moajo/items/0ea9043f9688b05fa39a
# RSAを実装する - Qiita

echo $1 | awk '{$1 = $1 + 0; if($1 < 1){exit 1;} exit;}'
test $? -ne 0 && echo "Invalid Argument. The argument must be a number greater than 1." && exit 99;

# The maximum and minimum bits must be 1.
# The largest bit is used to keep the number of digits.
# To make the smallest bit odd (even numbers are not prime numbers).
# BitRange=$(($1 - 2))
# Remainder=$(($BitRange % 4))
Remainder=$(($1 % 4))
# BitRange_Mof4=$(($BitRange + $Remainder))
BitRange_Mof4=$(($1 + $Remainder))
Split4=$(($BitRange_Mof4 / 4))

od -A n -t u4 /dev/urandom | \
head -n $Split4 | \
awk '{for(i = 1; i <= NF; i++){print $i % 2;}}' | \
# head -n $BitRange | \
head -n $1 | \
# /usr/bin/gawk -M 'BEGIN{ret = 1;}{ret = ret * 2 + $0;}END{print ret * 2 + 1;}'
/usr/bin/gawk -M '{ret = ret * 2 + $0;}END{print ret;}'

exit 0

