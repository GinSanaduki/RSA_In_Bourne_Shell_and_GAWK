#!/bin/sh
# gen_prime_sub.sh
# sh gen_prime_sub.sh bit
# sh gen_prime_sub.sh 128 100
# bashdb gen_prime_sub.sh 128 100
# sh gen_prime_sub.sh 2048 100

echo $1 | awk '{$1 = $1 + 0; if($1 < 1){exit 1;} exit;}'
test $? -ne 0 && echo "Invalid Argument. The argument must be a number greater than 1." && exit 99;

MRPT_K=$2

Rands_01=`sh PWGen_IMitation.sh`
Rands_02=`sh PWGen_IMitation.sh`
Temp_01=`echo "subdir/Temp_Pseudo_Random_Number_Candidate_"$Rands_01".txt"`
Temp_02=`echo "subdir/Temp_Pseudo_Random_Number_Candidate_"$Rands_02".txt"`

ret=`sh Odd_Pseudo_Random_Number_Candidate.sh $1`
: > $Temp_01
: > $Temp_02
while :
do
	yes "sh Pseudo_Random_Number_Candidate.sh $1" | \
	head -n $MRPT_K | \
	xargs -P 0 -I {} sh -c {} | \
	/usr/bin/gawk -M  -v Compare=$ret '{if($0 <= Compare){print;}}' | \
	sort -k 1,1 | \
	uniq >> $Temp_01
	Cnt=`wc -l $Temp_01 | cut -f 1 -d ' '`
	test $Cnt -ge $MRPT_K && break
done

sort -k 1,1 $Temp_01 | \
uniq | \
head -n $MRPT_K > $Temp_02
rm -f $Temp_01

/usr/bin/gawk -M -f mr_primary_test.awk -v n=$ret $Temp_02
RetCode=$?
echo "$RetCode $ret"

exit 0

