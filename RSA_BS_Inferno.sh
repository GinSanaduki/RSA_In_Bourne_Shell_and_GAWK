#!/bin/sh
# RSA_BS_Inferno.sh
# sh RSA_BS_Inferno.sh 256
# sh RSA_BS_Inferno.sh 2048
# sh RSA_BS_Inferno.sh 4096

# Ported in Python version by moajo
# https://qiita.com/moajo/items/0ea9043f9688b05fa39a
# RSAを実装する - Qiita

# https://ja.wikipedia.org/wiki/RSA%E6%9A%97%E5%8F%B7
# First, select an appropriate positive integer e (usually a small number, often 65537 (= 2 ^ 16 + 1)).
e=65537
echo $1 | awk '{$0 = $0 + 0; if($0 < 1){exit 1;} exit;}'
test $? -ne 0 && exit 99
Half_Bit=`echo $1 | awk '{print int($0 / 2); exit;}'`

Rand_P=`sh PWGen_IMitation.sh`
Rand_Q=`sh PWGen_IMitation.sh`
File_P=`echo "Temp_pq_"$Rand_P".txt"`
File_Q=`echo "Temp_pq_"$Rand_Q".txt"`

rm -f Temp_Pseudo_Random_Number_Candidate_*.txt > /dev/null 2>&1

sh gen_prime.sh $Half_Bit > $File_P
sh gen_prime.sh $Half_Bit > $File_Q

p=`cat $File_P`
q=`cat $File_Q`

rm -f Temp_Pseudo_Random_Number_Candidate_*.txt Temp_pq_*.txt > /dev/null 2>&1

# Test
# p=199390545231628303217582041763976466091
# q=266248447515762748085597144508550801243

echo "p : "$p
echo "q : "$q
echo "e : "$e
d=`/usr/bin/gawk -M -f gen_d.awk -v e=$e -v p=$p -v q=$q`
echo "d : "$d

n=`echo "$p $q" | /usr/bin/gawk -M '{print $1 * $2; exit;}'`

echo "n : "$n

m=123456789
echo "m : "$m

# Encrypt
# Ciphertext
c=`echo "$m $e $n" | /usr/bin/gawk -M -f me_2.awk`
echo "c : "$c
# Decrypt
# 123456789
m_=`echo "$c $d $n" | /usr/bin/gawk -M -f me_2.awk`
echo "m_ : "$m_

