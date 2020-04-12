#!/usr/bin/gawk -f
# mr_primary_test.awk
# /usr/bin/gawk -M -f mr_primary_test.awk -v n=$ret Temp2_Pseudo_Random_Number_Candidate.txt

# Example.
# /usr/bin/gawk -M -f mr_primary_test.awk -v n=250382861499762566692523265395270151499 hogefuga.txt
# →exit 1
# /usr/bin/gawk -M -f mr_primary_test.awk -v n=233791696012664804049830952142275386911 piyopiyo.txt
# →exit 0
# /usr/bin/gawk -M -f mr_primary_test.awk -v n=194477678878883054729917878161521498021 fugafugafuga.txt
# →exit 0

BEGIN{
	EndCnt = 0;
	if(n == 1){
		EndCnt = 2;
		exit;
	}
	if(n == 2){
		EndCnt = 1;
		exit;
	}
	if(n % 2 == 0){
		EndCnt = 2;
		exit;
	}
	d = n - 1;
	s = 0;
	while(d % 2 != 0){
		d = d / 2;
		s++;
	}
}

{
	r[NR] = $0;
}

END{
	switch(EndCnt){
		case "1":
			exit;
		case "2":
			exit 1;
	}
	r_len = length(r);
	for(a in r){
		delete pl;
		if(modular_exp(r[a],d,n) != 1){
			for(rr = 0; rr < s; rr++){
				pl[rr] = (2 ** rr) * d;
			}
			flg = 0;
			for(p in pl){
				if(modular_exp(a, p, n) == 1){
					flg++;
					break;
				}
			}
			delete pl;
			if(flg == 0){
				exit 1;
			}
		}
	}
}

function modular_exp(me_a,me_d,me_n,me_res){
	me_res = 1;
	while(me_d != 0){
		if(and(me_d, 1) != 0){
			me_res = (me_res * me_a) % me_n;
		}
		me_a = (me_a * me_a) % me_n;
		me_d = rshift(me_d, 1);
	}
	return me_res;
}

