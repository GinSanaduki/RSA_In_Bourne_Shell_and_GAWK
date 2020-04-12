#!/usr/bin/gawk -f
# gen_d.awk
# /usr/bin/gawk -M -f gen_d.awk -v e=$e -v p=$p -v q=$q
# /usr/bin/gawk -M -f gen_d.awk -v e=65537 -v p=281159412693774576922829919500816217599 -v q=208440021099280979408716252705880971887

# time /usr/bin/gawk -M -f gen_d.awk -v e=65537 -v p=281159412693774576922829919500816217599 -v q=208440021099280979408716252705880971887
# →32068724358901271243696931882169985055732982456858782992731388852479686712601
# real    0m0.563s
# user    0m0.000s
# sys     0m0.250s

BEGIN{
	p = p + 0;
	q = q + 0;
	if(p < 1 || q < 1){
		exit 99;
	}
	p--;
	q--;
	p_q = p * q;
	x = xgcd(e, p_q);
	# https://qiita.com/n4o847/items/d6504dd7fa411d1667ad
	# 負数の剰余の対策をより短く書いてみる - Qiita
	# https://shunirr.hatenablog.jp/entry/20120409/1333993409
	# 負数の剰余を計算してはならない - おともだちティータイム
	# 元ネタのpythonが最小非負剰余であり、awk(gawk)やbcはC(C99)で出来ているわけだから、
	# 絶対値最小剰余となる。
	xl = (x % p_q + p_q) % p_q;
	print xl;
}

function xgcd(xgcd_b, xgcd_n){
	x0 = 1;
	x1 = 0;
	y0 = 0;
	y1 = 1;
	while(xgcd_n != 0){
		# 除算については、gawkではpython版と同一の演算結果にならなかったため、
		# bcで突破した
		cmd = "echo \""xgcd_b" / "xgcd_n"\" | bc";
		# print cmd;
		Temp_xgcd_q = "";
		while(cmd | getline xgcd_q){
			sub(/\\/,"",xgcd_q);
			Temp_xgcd_q = Temp_xgcd_q xgcd_q;
		}
		close(cmd);
		sub(/\.[0-9]*/,"", Temp_xgcd_q);
		# xgcd_q = int(xgcd_b / xgcd_n);
		# sub(/\.[0-9]*/,"", xgcd_q);
		Temp_b = xgcd_b;
		xgcd_b = xgcd_n;
		xgcd_n = Temp_b % xgcd_n;
		Temp_x0 = x0;
		x0 = x1;
		x1 = Temp_x0 - Temp_xgcd_q * x1;
		Temp_y0 = y0;
		y0 = y1;
		y1 = Temp_y0 - Temp_xgcd_q * y1;
	}
	return x0;
}

