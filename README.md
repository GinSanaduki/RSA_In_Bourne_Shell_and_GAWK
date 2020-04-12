# RSA_In_Bourne_Shell_and_GAWK
AWK (GAWK) and Bourne Shell implementation for the purpose of understanding RSA from the specification

# Usage.
```bash
sh RSA_BS_Inferno.sh BitSize
sh RSA_BS_Inferno.sh 256
sh RSA_BS_Inferno.sh 2048
sh RSA_BS_Inferno.sh 4096
```

# 素数を見つけるのに相当マシンパワーを割くのと、運が悪いと本当になかなかみつからないので、
# 根気よくいくか、素直にまともなRSA実装かpythonとかでやることをオススメします。
* 本当に素数を見つけるのが大変なんだとわかるんですよ。

# あと、bcコマンドが必要です。
* 除算結果がどうしてもgawkのMPFRライブラリでカバーしきれなかったので・・・。
* 負数に対する除算の余りの結果は、pythonなどの最小非負剰余に合わせています。  
  * gawkやbcはC（C99）でできていますから、絶対値最小剰余です。
  詳しくは  
  https://shunirr.hatenablog.jp/entry/20120409/1333993409  
  負数の剰余を計算してはならない - おともだちティータイム  
  や  
  https://qiita.com/n4o847/items/d6504dd7fa411d1667ad  
  負数の剰余の対策をより短く書いてみる - Qiita  
  をみてね。

