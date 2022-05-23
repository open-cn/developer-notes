## 网络

linux里面的ifconfig -a命令，这个命令通常会得到如下的结果

eth0 Link encap:Ethernet HWaddr 00:01:4A:03:5B:ED
inet addr:192.168.11.2 Bcast:192.168.11.255 Mask:255.255.255.0
inet6 addr: fe80::201:4aff:fe03:5bed/64 Scope:Link
UP BROADCAST RUNNING MULTICAST MTU:1500 Metric:1
RX packets:2819 errors:0 dropped:0 overruns:0 frame:0
TX packets:76 errors:0 dropped:0 overruns:0 carrier:0
collisions:0 txqueuelen:1000
RX bytes:241609 (235.9 KiB) TX bytes:9596 (9.3 KiB)

lo Link encap:Local Loopback
inet addr:127.0.0.1 Mask:255.0.0.0
inet6 addr: ::1/128 Scope:Host
UP LOOPBACK RUNNING MTU:16436 Metric:1
RX packets:2713 errors:0 dropped:0 overruns:0 frame:0
TX packets:2713 errors:0 dropped:0 overruns:0 carrier:0
collisions:0 txqueuelen:0
RX bytes:3516032 (3.3 MiB) TX bytes:3516032 (3.3 MiB)

eth0就是以太网接口
lo则是loopback接口


wget 's major strong side compared to curl is its ability to download recursively.
wget is command line only. ...
curl supports FTP , FTPS , HTTP , HTTPS , SCP , SFTP , TFTP , TELNET , DICT , LDAP , LDAPS , FILE , POP3 , IMAP , SMTP , RTMP and RTSP . 
telnet mailhost smtp
GET example.org > xyzfilename


wget [url]
supports HTTP, HTTPS, FTP


curl -O [URL]
supports FTP, FTPS, Gopher, HTTP, HTTPS, SCP, SFTP, TFTP, TELNET, DICT, LDAP, LDAPS, FILE, POP3, IMAP, SMB/CIFS, SMTP, RTMP, RTSP

-L         Follow redirects
-s         Silent mode. Don't output anything
-o FILE    Write output to <file> instead of stdout
-w FORMAT  What to output after completion
-i         I don't actually download, just discover the final URL




curl -o thatpage.html http://www.netscape.com/  内容保存为一个文件
curl -O http://www.netscape.com/index.html 内容文件保存到本地 url不是文件时会报错


curl google.com 等同 curl http://google.com
curl http://google.com => redict to http://www.google.com
curl http://www.google.com => google html
curl -L http://google.com  => google html





why curl -L https://www.google.com (not http) has no effect, while https://www.google.com is ok in google chrome location?



