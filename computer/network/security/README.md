## 网络安全





### 信息安全

信息安全三要素

- 保密性(Confidentiality)：信息在传输时不被泄露
- 完整性（Integrity）：信息在传输时不被篡改
- 有效性（Availability）：信息的使用者是合法的这三要素统称为CIA Triad。

### 密码系统

密码技术的一个基本功能是实现保密通信

- 明文（Plaintext）明文常用m或p表示。
- 密文(Ciphertext) 密文常用c表示。
- 加密（Encrypt ）
- 解密（Decrypt）也称为脱密。
- 密钥（Secret Key）密码算法中的一个可变参数，通常是一组满足一定条件的随机序列。
	+ 密钥常用k表示。在密钥k的作用下，加密变换通常记为Ek(·)，解密变换记为Dk(·)或Ek－1(·)。
	+ 用于加密算法的叫做加密密钥（ke），用于解密算法的叫做解密密钥（kd）。
    + 加密密钥和解密密钥可能相同，也可能不相同。


- 消息空间M（又称明文空间）：所有可能明文m的集合；
- 密文空间C：所有可能密文c的集合；
- 密钥空间K：所有可能密钥k的集合，其中每一密钥k由加密密钥ke和解密密钥kd组成，即k=（ke，kd）；
- 加密算法E：一簇由加密密钥控制的、从M到C的加密变换；
- 解密算法D: 一簇由解密密钥控制的、从C到M的解密变换。


五元组{ M，C，K，E，D }

从数学的角度来讲，一个密码系统就是一族映射。对m∈M，(ke，kd)∈K，有：Dkd(Eke(m))=m。

如果密码分析者可以仅由密文推出明文或密钥，或者可以由明文和密文推出密钥，那么就称该密码系统是可破译的。相反地，则称该密码系统不可破译。

#### 安全性

安全因素:
1) 一个是所使用密码算法本身的保密强度。
2) 另外一个方面就是密码算法之外的不安全因素。

评估方法:
1) 无条件安全性：假定攻击者拥有无限的计算资源，但仍然无法破译该密码系统。
2) 计算安全性：使用最好的方法攻破它所需要的计算远远超出攻击者的计算资源水平，则可以定义这个密码体制是安全的。
3) 可证明安全性：归结为某个经过深入研究的数学难题（如大整数素因子分解、计算离散对数等）


对于实际应用中的密码系统而言，由于至少存在一种破译方法，即强力攻击法，因此都不能满足无条件安全性，只提供计算安全性。密码系统要达到实际安全性，就要满足以下准则：
1) 破译该密码系统的实际计算量（包括计算时间或费用）十分巨大，以致于在实际上是无法实现的。
2) 破译该密码系统所需要的计算时间超过被加密信息有用的生命周期。例如，战争中发起战斗攻击的作战命令只需要在战斗打响前需要保密；重要新闻消息在公开报道前需要保密的时间往往也只有几个小时。
3) 破译该密码系统的费用超过被加密信息本身的价值。

如果一个密码系统能够满足以上准则之一，就可以认为是满足实际安全性的。

#### 柯克霍夫斯（Kerckhoffs）原则

一句话： “一切秘密寓于密钥之中”。

即使密码系统中的算法为密码分析者所知，也难以从截获的密文推导出明文或密钥。也就是说，密码体制的安全性仅应依赖于对密钥的保密，而不应依赖于对算法的保密。

因此，一个提供机密性服务的密码系统是实际可用的，必须满足的基本要求：
1) 系统的保密性不依赖于对加密体制或算法的保密，而仅依赖于密钥的安全性。 “一切秘密寓于密钥之中”是密码系统设计的一个重要原则。
2) 满足实际安全性，使破译者取得密文后在有效时间和成本范围内，确定密钥或相应明文在计算上是不可行的。
3) 加密和解密算法应适用于明文空间、密钥空间中的所有元素。
4) 加密和解密算法能有效地计算，密码系统易于实现和使用。


### 解码方法

密码分析者破译或攻击密码的方法主要有穷举攻击法、统计分析法和数学分析攻击法。

#### 穷举攻击法

穷举攻击法又称为强力或蛮力（Brute force）攻击。这种攻击方法是对截获到的密文尝试遍历所有可能的密钥，直到获得了一种从密文到明文的可理解的转换；或使用不变的密钥对所有可能的明文加密直到得到与截获到的密文一致为止。

#### 统计分析法

统计分析攻击就是指密码分析者根据明文、密文和密钥的统计规律来破译密码的方法。

#### 数学分析法

数学分析攻击是指密码分析者针对加解密算法的数学基础和某些密码学特性，通过数学求解的方法来破译密码。数学分析攻击是对基于数学难题的各种密码算法的主要威胁。


#### 攻击类型

在假设密码分析者已知所用加密算法全部知识的情况下，根据密码分析者对明文、密文等数据资源的掌握程度，可以将针对加密系统的密码分析攻击类型分为以下四种：
1. 唯密文攻击（Ciphtext-only attack）
	在惟密文攻击中，密码分析者不知道密码算法，但仅能根据截获的密文进行分析，以得出明文或密钥。由于密码分析者所能利用的数据资源仅为密文，这是对密码分析者最不利的情况。
1. 已知明文攻击（Plaintext-known attack）
	已知明文攻击是指密码分析者除了有截获的密文外，还有一些已知的“明文—密文对”来破译密码。密码分析者的任务目标是推出用来加密的密钥或某种算法，这种算法可以对用该密钥加密的任何新的消息进行解密。
1. 选择明文攻击（Chosen-plaintext attack）
	选择明文攻击是指密码分析者不仅可得到一些“明文—密文对”，还可以选择被加密的明文，并获得相应的密文。这时密码分析者能够选择特定的明文数据块去加密，并比较明文和对应的密文，已分析和发现更多的与密钥相关的信息。
	密码分析者的任务目标也是推出用来加密的密钥或某种算法，该算法可以对用该密钥加密的任何新的消息进行解密。
1. 选择密文攻击 (Chosen—ciphenext attack)
	选择密文攻击是指密码分析者可以选择一些密文，并得到相应的明文。密码分析者的任务目标是推出密钥。这种密码分析多用于攻击公钥密码体制。 

#### 攻击评估

衡量密码系统攻击的复杂性主要考虑三个方面的因素：
- 数据复杂性（Data Complexity）：用做密码攻击所需要输入的数据量；
- 处理复杂性（Processing Complexity）：完成攻击所需要花费的时间；
- 存储需求（Storage Requirement）：进行攻击所需要的数据存储空间大小。


攻击的复杂性取决于以上三个因素的最小复杂度，在实际实施攻击时往往要考虑这三种复杂性的折衷，如存储需求越大，攻击可能越快。

### 加密技术

#### 对称加密

采用单钥密码系统的加密方法，同一个密钥可以同时用作信息的加密和解密，这种加密方法称为对称加密，也称为单密钥加密。

常用的算法有：DES、3DES、TDEA、Blowfish、RC2、RC4、RC5、IDEA、SKIPJACK等。
1. DES（Data Encryption Standard）：数据加密标准，速度较快，适用于加密大量数据的场合；
2. 3DES（Triple DES）：是基于DES，对一块数据用三个不同的密钥进行三次加密，强度更高；
3. AES（Advanced Encryption Standard）：高级加密标准，是下一代的加密算法标准，速度快，安全级别高，支持128、192、256、512位密钥的加密；
4. Blowfish
5. RC4 也被叫做ARC4（Alleged RC4——所谓的RC4），因为RSA从来就没有正式发布过这个算法。

对称加密算法的优点是算法公开、计算量小、加密速度快、加密效率高。

对称加密算法的缺点是在数据传送前，发送方和接收方必须商定好秘钥，然后使双方都能保存好秘钥。


#### 非对称加密

需要两个密钥来进行加密和解密，这两个密钥是公开密钥（public key，简称公钥）和私有密钥（private key，简称私钥）。公开密钥与私有密钥是一对，如果用公开密钥对数据进行加密，只有用对应的私有密钥才能解密；如果用私有密钥对数据进行加密，那么只有用对应的公开密钥才能解密。

1976年，美国学者Dime和Henman为解决信息公开传送和密钥管理问题，提出一种新的密钥交换协议，允许在不安全的媒体上的通讯双方交换信息，安全地达成一致的密钥，这就是“公开密钥系统”。

非对称密码算法有很多，其中比较典型的是RSA算法，它的数学原理是大素数的分解。

但在实际应用中，公钥密码体制并没有完全取代私钥密码体制，这是因为公钥密码体制在应用中存在以下几个缺点：
1) 公钥密码是对大数进行操作，计算量特别浩大，速度远比不上私钥密码体制。
2) 公钥密码中要将相当一部分密码信息予以公布，势必对系统产生影响。
3) 在公钥密码中，若公钥文件被更改，则公钥被攻破。

### 数字证书

数字证书的特性有数据机密性、可认证性、数据完整性、不可否认性。

数字证书可分为加密证书与签名证书，作用分别是加密与身份认证。

加密证书是把数据资料加密，让非法用户尽管得到了加密过的资料，也不能获取正确的资料内容，因此数据加密能对数据进行保护，防止监听攻击，其重点是数据的安全性。

签名证书是用于鉴别某个身份的真实性，辨别身份后，系统才能按照不同的身份给出不同的权限，其重点是用户身份的真实性。



标准的X.509数字证书含以下内容：
1. 证书的版本信息。
2. 证书的序列号,每个证书均有且只有一个证书序列号。
3. 证书用的签名算法。
4. 证书的发行机构名称,命名规则通常用X.500格式。
5. 证书的有效期,目前通用的证书通常用UTC时间格式。
6. 证书所有人的名称,命名规则一般用X.500格式。
7. 证书所有人的公开密钥。
8. 证书发行者对证书的签名。

#### 数字签名（digital signature）

数字签名是公钥密码的逆应用：用私钥加密消息，用公钥解密消息。

用私钥加密的消息称为签名，只有拥有私钥的用户可以生成签名。

用公钥解密签名这一步称为验证签名，所有用户都可以验证签名(因为公钥是公开的)。

##### 生成签名
1. 对消息进行哈希计算，得到哈希值
1. 利用私钥对哈希值进行加密，生成签名
1. 将签名附加在消息后面，一起发送过去

##### 验证签名
1. 收到消息后，提取消息中的签名
1. 用公钥对签名进行解密，得到哈希值1。
1. 对消息中的正文进行哈希计算，得到哈希值2。
1. 比较哈希值1和哈希值2，如果相同，则验证成功。


##### 自签名，生成私有证书
用私钥对该私钥生成的证书请求进行签名，生成证书文件。

##### 自签名，生成CA证书
CA证书是一种特殊的自签名证书，可以用来对其它证书进行签名。


##### 认证机构(Certification Authority， CA)
一个可信的机构来颁发证书和提供公钥，只要是它提供的公钥，我们就相信是合法的。

##### 生成证书（CA）
1. 服务器将公钥A给CA（公钥是服务器的）
1. CA用自己的私钥B给公钥A加密，生成数字签名A
1. CA把公钥A，数字签名A，附加一些服务器信息整合在一起，生成证书，发回给服务器。

注：私钥B是用于加密公钥A的，私钥B和公钥A并不是配对的。

##### 验证证书（CA）
1. 客户端得到证书
1. 客户端得到证书的公钥B（通过CA或其它途径）
1. 客户端用公钥B对证书中的数字签名解密，得到哈希值
1. 客户端对公钥A进行哈希值计算
1. 两个哈希值对比，如果相同，则证书合法。

注：公钥B和上述的私钥B是配对的，分别用于对证书的验证（解密）和生成（加密）。

##### 证书作废
当用户私钥丢失、被盗时，认证机构需要对证书进行作废(revoke)。
要作废证书，认证机构需要制作一张证书作废清单(Certificate Revocation List)，简称CRL。
#### SSL/TLS 协议

SSL(Secure Sockets Layer，安全套接层)，及其继任者TLS（Transport Layer Security，传输层安全）是为网络通信提供安全及数据完整性的一种安全协议。TLS与SSL在传输层与应用层之间对网络连接进行加密。

SSL 3.0和TLS 1.0有轻微差别，但两种规范其实大致相同。

X.509是常见通用的证书格式。

所有的证书都符合为Public Key Infrastructure (PKI) 制定的 ITU-T X509 国际标准。

X.509 DER 编码(ASCII)的后缀是： .DER .CER .CRT
X.509 PEM 编码(Base64)的后缀是： .PEM .CER .CRT

`openssl [-inform der]`

.cer/.crt是用于存放证书，它是2进制形式存放的，不含私钥。
.pem跟crt/cer的区别是它以Ascii来表示。
.csr Certificate Signing Request 证书签名请求，这个并不是证书。用的req加密算法。
.key rsa证书 可加密


RFC4716/SSH2
PKCS8(PKCS8 public or private key)
PEM(PEM public key)

ssh-keygen 生成和格式转换
```shell
# 修改密码
ssh-keygen -p <keyname>

# idrsa openssh 格式转成 pem 格式
ssh-keygen -p -m pem -f id_rsa
# idrsa pem 格式转成 openssh 格式
ssh-keygen -p -f id_rsa

# 根据密钥输出 PEM/PKCS8/SSH2 公钥
ssh-keygen -f id_rsa -e -m PEM
ssh-keygen -f id_rsa -e -m PKCS8
ssh-keygen -f id_rsa -e -m RFC4716
```
PEM格式：RSA公私钥对常用的编码方式，OPENSSL以PEM格式为主，相对DER可读性更强，以BASE64编码呈现；

PKCS 全称是 Public-Key Cryptography Standards。是由 RSA 实验室与其它安全系统开发商为促进公钥密码的发展而制订的一系列标准，

PKCS 目前共发布过 15 个标准。 常用的有：

PKCS#7 Cryptographic Message Syntax Standard 加解密消息语法标准
PKCS#12 Personal Information Exchange Syntax Standard 个人信息交换语法标准

PKCS#7 常用的后缀是： .P7B .P7C .SPC 
PKCS#12 常用的后缀有： .P12 .PFX


p7r 是CA对证书请求的回复，只用于导入
p7b 以树状展示证书链(certificate chain)，同时也支持单个证书，不含私钥。二进制

pfx/p12 用于存放个人证书/私钥，主要是考虑分发证书，私钥是要绝对保密的，不能随便以文本方式散播。可以加密码保护，所以相对安全些。



RSA PKCS#1私钥PEM格式如：
开头 -----BEGIN RSA PRIVATE KEY-----
结尾 -----END RSA PRIVATE KEY-----

RSA PKCS#1公钥PEM格式如：
开头 -----BEGIN RSA PUBLIC KEY-----
结尾 -----END RSA PUBLIC KEY-----

RSA PKCS#8私钥PEM格式如：
开头 -----BEGIN PRIVATE KEY-----
结尾 -----END PRIVATE KEY-----

RSA PKCS#8公钥PEM格式如：
开头 -----BEGIN PUBLIC KEY-----
结尾 -----END PUBLIC KEY-----

PKCS#1密钥格式，多用于JS等其它程序加解密，属于比较老的格式标准。
PKCS#8密钥格式，多用于JAVA、PHP程序加解密中，为目前用的比较多的密钥、证书格式。
PKCS#1和PKCS#8的主要区别，从本质上说，PKCS#8格式增加验证数据段，保证密钥正确性。

通常加密数据长度为：
数据填充标志           输入数据长度                   输出数据长度    参数字符串
PKCS#1 v1.5           少于(密钥长度-11)字节     同密钥长度      -pkcs
PKCS#1 OAEP        少于(密钥长度-11)字节     同密钥长度       -oaep
PKCS#1 SSLv23      少于(密钥长度-11)字节     同密钥长度       -ssl
NO_PADDING        同密钥长度                       同密钥长度       -raw

NO_PADDING就必须明文和密钥大小一样了,1024位RSA对应128字节明文
PKCS1的得减去11字节存储PKCS1自己的数据,1024位RSA只能加密117字节明文

通过CA产生的出来的证书格式文件一般是以PFX P12格式发布给使用者（公钥与私钥），用户拿到证书后，可以通过IE来导入或直接双击向导安装证书，此时私钥安装到系统的私有密钥库中。使用时系统会自动查找到私钥。而最安全的方式还是使用其它USB硬件来存储，私钥将无法再从硬件锁只导出，并且支持硬件访问需要用户的密钥才能访问到硬件内的私钥，永远保证了私钥不出硬件锁！提高了安全性，灵活性，且可以移动的方便性。