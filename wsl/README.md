## Windows linux



netsh(Network Shell) 是一个windows系统本身提供的功能强大的网络配置命令行工具。 导出配置脚本：netsh -c interface ip dump > c:\interface.txt 导入配置脚本：netsh -f c:\interface.txt。

```
netsh interface portproxy show all

netsh interface portproxy add v4tov4 listenport=8000 listenaddress=192.168.12.132 connectport=8000 connectaddress=127.0.0.1

netsh interface portproxy delete v4tov4 listenport=8000 listenaddress=192.168.12.132
```
















































