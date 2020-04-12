#!/usr/bin/gawk -f
# me_2.awk
# /usr/bin/gawk -M -f me_2.awk

{
	res = 1;
	while($2 != 0){
		if(and($2, 1) != 0){
			res = (res * $1) % $3;
		}
		$1 = ($1 * $1) % $3;
		$2 = rshift($2, 1);
	}
	print res;
	exit;
}

