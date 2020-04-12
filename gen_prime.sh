#!/bin/sh
# gen_prime.sh
# sh gen_prime.sh bit
# sh gen_prime.sh 128 100
# bashdb gen_prime.sh 128 100
# sh gen_prime.sh 2048 100

echo $1 | awk '{$1 = $1 + 0; if($1 < 1){exit 1;} exit;}'
test $? -ne 0 && echo "Invalid Argument. The argument must be a number greater than 1." && exit 99;

MRPT_K=$2

Rands_01=`sh PWGen_IMitation.sh`
Temp_01=`echo "subdir/Temp_Pseudo_Random_Number_Candidate_"$Rands_01".txt"`

while :
do
	yes "sh gen_prime_sub.sh $1 $MRPT_K" | \
	head -n 8 | \
	# https://living-sun.com/ja/find/259642-ls-terminated-by-signal-13-when-using-xargs-find-xargs.html
	xargs -P 4 -I {} sh -c {} > $Temp_01
	grep -q '^0 ' $Temp_01
	test $? -eq 0 && break;
done

grep '^0 ' $Temp_01 | head -n 1 | cut -f 2 -d ' '
exit 0

