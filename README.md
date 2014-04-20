chat2spreadsheet
================

## 概要
HipChatに入れたコメントをスプレッドシート（Excel）にコピーして見やすくするためのテキスト整形（変換）スクリプトです。

## 使い方
1) HipChatに何か入れます。

![1](https://dl.dropboxusercontent.com/u/7779513/github/6.png)

2) だらっとコピー

![2](https://dl.dropboxusercontent.com/u/7779513/github/8.png)

3) テキストファイル（in.txt）に貼り付け

![3](https://dl.dropboxusercontent.com/u/7779513/github/7.png)

4) ターミナルで実行。別テキストファイル（out.txt）に出力

`$perl c2s.pl in.txt > out.txt`

![4](https://dl.dropboxusercontent.com/u/7779513/github/20.png)

5) 出力先（out.txt）を眺める

![5](https://dl.dropboxusercontent.com/u/7779513/github/9.png)

これをExcelにコピペすると...

6) それぞれの列（カテゴリ）に収まってる

![6](https://dl.dropboxusercontent.com/u/7779513/github/10.png)

8) Congrats!  \\(^o^)/

## 参考
### Blog entry
- [#Perl入学式 第2期最終回＆修了式に行ってきた＆LT発表した](http://d.hatena.ne.jp/note103/20140330/1396157903)

### Slide
- [Perl入学式の成果と過程](http://www.slideshare.net/note103/perl-entrance-lt-20140329)

## コンタクト
当スクリプトに関するご連絡は[Twitter(@note103)](https://twitter.com/note103)かIssues、プルリク等にてご遠慮なくどうぞ。
