
一、Matlab 由来和现状

1.
70年代中期，Cleve Moler博土及其同事在美国国家基金会的帮助下，开发了LINPACK和EISPACK的FORTRAN语言子程序库，这两个程序库代表了当时矩阵运算的最高水平。

到了70年代后期，身为美国新墨西哥州大学计算机系系主任的CIeve Moler，在给学生上线性代数课时，为了让学生能使用这两个子程序库，同时又不用在编程上花费过多的时间，开始着手用FORTRAN语言为学生编写使用LINPACK和EISPACK的接口程序，他将这个程序取名为MATLAB，其名称是由MATrix和 LABoratory（矩阵实验室）两个单词的前三个字母所合成。

在1978年，Malab就面世了。这个程序获得了很大的成功，受到了学生的广泛欢迎。在以后的几年里，Matlab在多所大学里作为教学辅助软件使用，并作为面向大众的免费软件广为流传。

将MATLAB商品化的不是Cleve Moler,而是一个名叫Jack Little的人。当免费的MATLAB软件到Stanford大学，Jack Little正在该校主修控制，便接触到了当时MATLAB，直觉告诉他，这是一个具有巨大发展潜力的软件。因此他在毕业沒多久，就开始用C语言重新编写了MATLAB的核心。在Moler的协助下，于1984年成立MathWorks公司，首次推出MATLAB商用版。在其商用版推出的初期，MATLAB就以其优秀的品质（高效的数据计算能力和开放的体系结构）占据了大部分数学计算软件的市场，原来应用于控制领域里的一些封闭式数学计算软件包（如英国的UMIST、瑞典的LUND和SIMNON、德国的KEDDC）就纷纷被淘汰或在MATLAB上重建。

MATLAB早期成功的两大因素是：选用了C语言及选定PC为主要平台，这似乎和微软的成功有相互呼应之妙。
MATLAB的设计方向应该一直是以顾客的需求与软件的完整性为首要目标
Cleve Moler至今仍是该公司的首席科学家

2.
1992年，支持Windows 3.x的MATLAB 4.0版本推出，增加了Simulink，Control，Neural  Network，Signal Processing等专用工具箱。
1993年11月，MathWorks公司推出了Matlab 4.1，其中主要增加了符号运算功能。当升级至Matlab 4.2c，这一功能在用户中得到广泛应用。
1997年，Matlab 5.0版本问世了,实现了真正的32位运算，加快数值计算，图形表现有效。
2001年初，MathWorks公司推出了Matlab 6.0（R12）。
2002年7月，推出了Matlab 6.5(R13)，在这一版本中Simulink升级到了5.0，性能有了很大提高，另一大特点是推出了JIT程序加速器，Matlab的计算速度有了明显的提高。
2005年9月，推出了MAILAB 7.1(Release14 SP3)，在这一版本中Simulink升级到了6.3，软件性能有了新的提高，用户界面更加友好。值得说明的是，Matlab V7.1版采用了更先进的数学程序库，即“LAPACK”和“BLAS”。

3.
MATLAB是MATLAB产品家族的计算核心与基础，是集高性能数值计算与数据可视化于一体的高效编程语言。
MATLAB Toolboxes 围绕着MATLAB这个计算核心，形成了诸多针对不同应用领域的算法程序包，被称为专用工具箱（Toolbox），这些工具箱的列表以及每个工具箱的使用详见MATLAB在线帮助文档。MATLAB本身所提供的工具箱大概有40多个，另外还有其他公司或研究单位开发提供的工具箱，这些工具箱的总数已有100多个，而且新的工具箱还在不断增加。如果你有特别的应用领域，可以首先到网上查找是否已有相关的工具箱，很可能已有人将你要做的应用程序作成工具箱了。
MATLAB Compiler这种编译器可以将MATLAB程序文件编译生成标准的C/C++语言文件，而生成的标准的C/C++文件可以被任何一种C/C++编译器编译生成函数库或可执行文件，以提高程序的运行效率。

Simulink是窗口图形方式的、专门用于连续时间或离散时间的动态系统建模、分析和仿真的核心。
Simulink Blocksets 围绕着Simulink仿真核心所开发的应用程序包，称为模块集（Blocksets）,MATLAB产品提供许多专用模块集，如Communication Blockset、DSP Blockset、SimPowerSystem Blockset、Signal Processing Blockset等，详见MATLAB在线帮助文档。

Real-Time Workshop (RTW)是一种实时代码生成工具，它能够根据Simulink模型生成程序源代码，并打包、编译所生成的源代码生成实时应用程序。
Stateflow是基于有限状态机理论针对复杂的事件驱动系统进行建模、仿真的工具。
Stateflow Coder是基于Stateflow状态图生成高效、优化的程序代码。

从现有的Simulink 和Stateflow自动生成C语言程序代码的功能、定点运算模块集（Fixed-point Blockset）与C语言程序代码到VHDL（Very High Speed Integrated Circuit Hardware Description Language，一种标准的硬件电路设计语言 ）的自动转换功能，可以看出，高级的系統仿真或低级的芯片算法设计，都可用MATLAB、Simulink、Stateflow及相关的工具箱来完成。






它以高性能的数组运算（包括矩阵运算）为基础，不仅实现了大多数数学算法的高效运行函数和数据可视化，而且提供了非常高效的计算机高级编程语言，在用户可参与的情况下，各种专业领域的工具箱不断开发和完善，MATLAB取得了巨大的成功，已广泛应用于科学研究、工程应用，用于数值计算分析、系统建模与仿真。



Matlab成为线性代数、自动控制理论、数字信号处理、时间序列分析、动态系统仿真、图像处理等诸多课程的基本教学工具
已广泛应用于科学研究、工程应用，用于数值计算分析、系统建模与仿真。

重点介绍MATLAB的数据可视化、数值计算的基本步骤以及如何使用MATLAB语言编写整洁、高效、规范的程序。并涉及到一些具体的专业应用工具箱（如：信号处理工具箱、图像处理工具箱等）。










二、Matlab 使用帮助


数值显示格式设置
缺省显示格式：简洁的短（short g）格式
窗口命令及语法格式：format  显示格式关键字
       如：format long   %15位数字显示
常见通用命令
命令			含义
clc			清除命令窗口的显示内容
clear		清除Matlab工作空间中保存的变量
who或whos		显示Matlab工作空间中的变量信息
dir			显示当前工作目录的文件和子目录清单
cd			显示或设置当前工作目录
type			显示指定m文件的内容
help或doc		获取在线帮助
quit或exit		关闭/推出MATALB

MATLAB提供的帮助信息有两类
1.简单纯文本帮助信息
help
lookfor（条件比较宽松）例：inverse
2.窗口式综合帮助信息（文字、公式、图形）
doc
helpwin



三、Matlab 基础语法


变量命令规则
变量名、函数名对字母的大小写是敏感的。如myVar与myvar表示两个不同的变量。
变量名第一个字母必须是英文字母。
变量名可以包含英文字母、下划线和数字。
变量名不能包含空格、标点。
变量名最多可包含63个字符（6.5及以后的版本）。

Matlab的数只采用习惯的十进制表示，可以带小数点和负号;其缺省的数据类型为双精度浮点型（double）。

Matlab预定义的变量
变量名	意义
ans	最近的计算结果的变量名
eps	MATLAB定义的正的极小值=2.2204e-16
pi	圆周率π
inf	∞值，无限大
i或j	虚数单元，sqrt(-1)
NaN	非数，0/0、∞/ ∞
〖说明〗
每当MATLAB启动完成，这些变量就被产生。
MATLAB中，被0除不会引起程序中断，给出报警的同时用inf或NaN给出结果。
用户只能临时覆盖这些预定义变量的值，Clear或重启MATLAB可恢复其值。

〖说明〗
不以分号结尾，会输出该语句的结果值

简单计算 +-*/\ ^ sin pi sqrt exp
>>(12+2*(7-4))/3^2
〖说明〗
Matlab用“\”和”/”分别表示“左除”和“右除”。对标量而言，两者没有区别。对矩阵产生不同影响。

多项式方程求解
2x^5-3x^3+71x^2-9x+13=0
p = [2,0,-3,71,-9,13]; %建立多项式系数向量
x = roots(p)；         %求根
p2 = poly(x)；         %由根求多项式

多项式的乘法(conv指令)
a=[1 2 3 4];b=[1 4 9 16];c=conv(a, b);d=conv(c,d)
多项式的除法(deconv)
c=[1 6 20 50 75 84 64];
b=[1 4 9 16];
[q,r]=deconv(c,b)
多项式的导数 (polyder)
c=[1 6 20 50 75 84 64];
d=polyder(c)
p = polyder(P,Q);      %求P*Q的导函数
[p,q] = polyder(P,Q);  %求P/Q的导函数，导数分子存入p,分母存入q
一般函数的导数
MATLAB中没有直接提供数值导数的函数，只有计算向前差分的函数diff，其调用格式为：
diff(c)    计算向量c的向前差分
diff(c,n)    计算向量c的n阶向前差分
差分/间距=近似导数
多项式的估值(polyval)
p=[1  4  -7  -10];
y=polyval(p, 2);       % x=2 求y值

求解线性方程组
2x+3y-1z=2
8x+2y+3z=4
45x+3y+9z=23
方式一：
a = [2,3,-1;8,2,3;45,3,9];%建立系数矩阵a
b = [2;4;23];             %建立列向量b
x = inv(a)*b;             %or x = a\b 矩阵的逆或左除
方式二：
syms x y z  %建立符号变量
[x,y,z]=solve(2*x+3*y-z-2,8*x+2*y+3*z-4,45*x+3*y+9*z-23)

求解定积分
I=f(0~1)xln(1+x)dx
方式一：
quad('x.*log(1+x)',0,1)
方式二：
syms x
nt(x*log(1+x),0,1)

一般说来，quadl比quad更有效。
[q,fcnt] = quadl(fun,a,b,tol,trace)
输入量fun为被积函数的句柄。
输入量a, b分别是积分的下限、和上限，都必须是确定的数值;
输入量tol是一个标量，控制绝对误差;可以缺省;
输入量trace为非0值时，将随积分的进程逐点画出被积分函数;可以缺省;
输出参数fcnt返回函数的执行次数,可以缺省。
Note：quad的调用格式与quadl相同。

多项式曲线拟合
x=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
y=[1.2, 3, 4, 4, 5, 4.7, 5, 5.2, 6, 7.2]
一次多项式拟合：
p1 = polyfit(x,y,1)
三次多项式拟合：
p3 = polyfit(x,y,3)
plot 原始数据、一次拟合曲线和三次拟合曲线
x2=1:0.1:10;
y1=polyval(p1,x2)
y3=polyval(p3,x2)
plot( x, y, '*', x2, y1, ':', x2, y3)
〖说明〗plot LineSpec '*' Asterisk 加星号 ':' Dotted line 点虚线
plot(y)
plot(y,'ks')
plot(y,'LineWidth',5)
plot(x,y,'ks')             %LineSpec black (k) square (s) red (r) star (*)
plot(x,y,'ro-','LineWidth',5)
plot(t,y,'DurationTickFormat','mm:ss') %format time axis
title('Sample Plot')
ylabel('ylabel (yunit)')
legend('a','b')

figure % new figure
ax1 = subplot(2,1,1); % top subplot 2行1列 第一行的图
ax2 = subplot(2,1,2); % bottom subplot 2行1列 第二行的图
plot(ax1,x,y)
title(ax1,'Top title')
ylabel(ax1,'Top ylabel')


复数及其运算
z1=3+4i，z2=1+2i, z3=2e^(πi/6)。计算z=z1z2/z3
z1=3+4*i, z2=1+2*i, z3=2*exp(i*pi/6), z=z1*z2/z3
z_real=real(z), z_image=imag(z),% real 求复数实部 imag 求复数虚部
z_angle=angle(z), z_length=abs(z),% angle 求复数角度? abs 求复数?


Matlab矩阵(数组)的表示
数组定义：按行(row)和列(column)顺序排列的实数或复数的有序集，被称为数组。
对m行、n列的2维数组a：计为m×n的数组a；行标识、列标识均从1开始

数组的分类
一维数组，也称为向量(vector) 。
   行向量(row vector)、列向量(column vector)。
二维数组(矩阵matrix)。
多维数组。

有效矩阵：每行元素的个数必须相同，每列元素的个数也必须相同。

创建一维数组变量
1.使用方括号“[ ]”操作符 行元素间用空格或英文的逗点“,”分开 列元素用分号“;”分开
x=[1 3 pi 3+5*i]  %or x=[1, 3, pi, 3+5*i]
y=[1; 2; 3]
2.使用冒号“:”操作符 x=Start:Increment:End
x=1:10 %Increment=1
y=1:2:10
y=(1:3)’    % “’”表示矩阵的转置
3.利用函数linspace x= linspace(x1, x2, n) x1起点、x2终点、n个数（缺省100）
x=linspace(1,2,5)
x=1.0000    1.2500    1.5000    1.7500    2.0000
4.利用函数logspace

创建二维数组变量
1.使用方括号“[ ]”操作符
z=[1 2 3;4 5 6;7 8 9] %or z=[1:3;4:6;7:9]
a=[1 2 3]; b=[2 3 4];
c=[a;b]; % 2行3列
c1=[a b]; % 1行6列

2.函数方法
函数ones(生成全1矩阵)、zeros (生成全0矩阵) 、reshape
“help elmat”获得基本的矩阵生成和操作函数列表

ones(3) 3x3数组
ones(3,4) 3x4数组

reshape 数组元素从上到下按列排列，先排第一列，然后第二列，…
a=-4:4
b=reshape(a, 3, 3)

数组元素的标识
1.“全下标（subscript）”标识
b(2);a(2,3)
2.“单下标”（index）标识
设想把二维数组的所有列，按先后顺序首尾相接排成“一维长列”，然后自上往下对元素位置执行编号。参照reshape
标识的变换：sub2ind、ind2sub
sub2ind(size(a),2,1)
sub2ind(size(a),[2 2],[1 1])
[i,j]=ind2sub(size(a),2)
[i,j]=ind2sub(size(a),[2 4])

a(3)       %寻访a的第3个元素
a([1 2 5])   %寻访a的第1、2、5个元素组成的子数组
a(1:3)   %寻访前3个元素组成的子数组
a(3:-1:1)  %由前3个元素倒序构成的子数组
a(3:end-1) % 函数end作为参数使用，返回最后一个元素的下标
a([1 2 2 5])   %数组元素可以被任意重复访问

Index exceeds matrix dimensions.
下标值超出了数组的维数，导致错误
Subscript indices must either be real positive integers or logicals.
下标值只能取正整数或逻辑值

a(3)=0           %修改数组a的第3元素值为0
a([2 5])=[1 1]   %修改数组多个值
a(:)=1:9         %修改数组全部的值 ":"表示全部 注意元素的排列顺序参照reshape
a(1,:)=1:3       %修改数组第一行全部的值
a([1 3],:)=1:3   %修改数组第一、三行全部的值

size、length函数
a=ones(4,6)*6
m=size(a)        %size函数返回变量的大小，即变量数组的行列数
len=length(a)    %length函数返回变量数组的最大维数

多维数组
将两个二维（平面）数组叠在一起，就构成三维数组，第三维称为「页」(Page)
三维数组元素的寻址：可以(行、列、页)来确定。

多维数组的建立
A(:, :, 1) = [1 0 2 5; 4 1 8 7; 3 2 6 3];
A(:, :, 2) = [3 5 4 1; 2 6 2 1; 4 2 3 0]

MATLAB数组支持线性代数中所有的矩阵运算。
建立特有的数组运算符，如：“.*”、“./”等。
         MATLAB数组运算符列表
运算		 	运算符		含义说明
加        	  +       相应元素相加
减      	  	  -		  相应元素相减
乘      	  	  *		  矩阵乘法
点乘      	  .* 	  相应元素相乘
幂	 	  	  ^ 	  矩阵幂运算
点幂	  	 	  .^	  相应元素进行幂运算
左除或右除	  \或/	  矩阵左除或右除
左点除或右点除   .\或./	  A的元素被B的对应元素除
转置	 	  	  ' 	  矩阵的转置

关系运算
Matlab提供了6种关系运算符：
<、>、<=、>=、==、~=（不等于）
关系运算符的运算法则：
1、当两个标量进行比较时，直接比较两数大小。若关系成立，结果为1，否则为0。
2、当两个维数相等的矩阵进行比较时，其相应位置的元素按标量关系进行比较，并给出结果，形成一个维数与原来相同的0、1矩阵。
3、当一个标量与一个矩阵比较时，该标量与矩阵的各元素进行比较，结果形成一个与矩阵维数相等的0、1矩阵。
P = rem(A,3)==0 %被3除，求余 P也是矩阵

逻辑运算
Matlab提供了3种逻辑运算符：
&（与）、|（或）、~（非）
逻辑运算符的运算法则：
1、在逻辑运算中，确认非零元素为真（1），零元素为假（0）。
2、当两个维数相等的矩阵进行比较时，其相应位置的元素按标量关系进行比较，并给出结果，形成一个维数与原来相同的0、1矩阵；
3、当一个标量与一个矩阵比较时，该标量与矩阵的各元素进行比较，结果形成一个与矩阵维数相等的0、1矩阵；
4、算术运算优先级最高，逻辑运算优先级最低。
x = 0:pi/100:3*pi;
y = sin(x);
y1 = (y>=0).*y;   %消去负半波 y>=0是0、1矩阵

A = [4,15,-45,10,6;56,0,17,-45,0];
find(A>=10 & A<=20) %找到非零元素的位置

数据分析与统计
最大值和最小值 max min
向量X
y=max(X) 返回向量X的最大值存入y，如果X中包含复数元素，则按模取最大值；
[y,I]=max(X)：返回向量X的最大值存入y，最大值的序号存入I，如果X中包含复数元素，则按模取最大值。

矩阵A
y=max(A)：返回一个行向量，向量的第i个元素是矩阵A的第i列上的最大值；
[Y,U]=max(A)：返回行向量Y和U，Y向量记录A的每列的最大值，U向量记录每列最大值的行号；
max(A,[],dim)：dim取1或2。dim取1时，该函数和max(A)完全相同；dim取2时，该函数返回一个列向量，其第i个元素是A矩阵的第i行上的最大值。

求和与求积
sum(X)：返回向量X各元素的和。
prod(X)：返回向量X各元素的乘积。
sum(A)：返回一个行向量，其第i个元素是A的第i列的元素和。
prod(A)：返回一个行向量，其第i个元素是A的第i列的元素乘积。
sum(A,dim)：当dim为1时，该函数等同于sum(A)；当dim为2时，返回一个列向量，其第i个元素是A的第i行的各元素之和。
prod(A,dim)：当dim为1时，该函数等同于prod(A)；当dim为2时，返回一个列向量，其第i个元素是A的第i行的各元素乘积。

sum(A(:)) 对矩阵所有元素求和

平均值与中值
mean(X)：返回向量X的算术平均值。
median(X)：返回向量X的中值。
mean(A)：返回一个行向量，其第i个元素是A的第i列的算术平均值。
median(A)：返回一个行向量，其第i个元素是A的第i列的中值。
mean(A,dim)：当dim为1时，该函数等同于mean(A)；当dim为2时，返回一个列向量，其第i个元素是A的第i行的算术平均值。
median(A,dim)：当dim为1时，该函数等同于median(A)；当dim为2时，返回一个列向量，其第i个元素是A的第i行的中值。

std(X):返回向量X的标准差
std(A):返回一个行向量，其第i个元素是A的第i列的标准差
std(A,w):当w为0时，开根之前除以数据个数N -1；当w为1时，除以数据个数N
std(A,w,dim):当dim为1时，该函数等同于median(A)；当dim为2时，返回一个列向量，其第i个元素是A的第i行的标准差


字符串
字符（Characters）可以构成一个字符串（Strings），或字符数组(character array)。
一个字符串是被视为一个行向量（row vector）。
字符串中的每一个字符（含空格），以其 ASCII 码的形式存放于行向量中，是该字符串变量的一个元素（element）。

MATLAB处理字符(Characters)与字符串(Strings)的相关指令大部分都放在下列目录之中：
{MATLAB根目录}\toolbox\matlab\strfun
其中的「strfun」就是代表「String Functions」。
help strfun 或是 help strings

Matlab 用「单引号」来界定一个字符串。
可以使用方括号“[ ]”直接连接多个字符串变量，得到一个新字符串变量。
str1 = 'I like MATLAB,';	    % 建立字串变量 str1
str2 = ' JavaScript, and Perl!';	    % 建立字串变量str2
str3 = [str1 str2]	        % 直接连接str1及str2，以建立str3

sentence = 'I''ve got a date!'; % ''表示字符串中的单引号
length(sentence)	% 计算字字符串sentence的长度
sentenceAscii = double(sentence)   %查看 sentence 的 ASCII 码
sentence2 = char(sentenceAscii)	     % 将 ASCII 码恢复成字符串形式

chinese = ‘今日事，今日毕';
out1 = class(chinese)      % out1 的值是 “char”
x = chinese+1;
out2 = ischar(x)	           % out2 的值是 0，代表 x 不是字符串变量

一个字符数组变量存储多行字符串
departments = [‘ee  ’; ‘cs  ’; ‘econ’]
departments = char(‘ee’, ‘cs’, ‘econ’)      % 注意空格及「,」的使用

departments = char('ee', 'cs', 'econ');
dept1 = departments(1,:);	% (1,:)代表第一行的全部元素
dept2 = deblank(dept1);	    % 使用 deblank 指令清除尾部的空格字符
len1 = length(dept1)		% 显示变量 dept1 的长度=4
len2 = length(dept2)		% 显示变量 dept2 的长度=2

字符串的操作-比较
str1 = 'today';
str2 = 'tomorrow';
str3 = 'today';
out1 = strcmp(str1, str2)	   % 比较字符串 str1 和 str2
out1 = 0                       % 0 表示字符串 str1 和 str2不同
out2 = strcmp(str1, str3)	   % 比较字符串 str1 和 str3
out2 = 1                       % 1 表示字符串 str1 和 str3相同

空数组（empty array）
有一维是0的数组即为空数组
空数组不占据存储空间
最简单的空数组：0 x 0的矩阵
 复杂的空数组：0 x 5 or 10 x 0
例如：>>a=[]; b=ones(0,5);
*空数组并非全0数组

数组维数的减小
1.删除数组的某列和行
>>a = magic(4), a(:,2)=[] % 置空／删除 第2列
2.删除(2-D、3-D)数组的单个元素
使用“全下标”方式，不能删除单个元素
>>a(1, 2)=[]   %系统会警告信息
使用“单下标”可以删除单个元素
>>a(2:4)=[]   %数组a将变为向量
使用“[]”同样可以减小字符数组的维数


元胞数组（cell array）（单元数组)
1.特殊的数据类型，在一个数组中存放各种不同类型的数据
2.每个单元相当于一个“盒子”
3.“盒子”可存储各种不同类型的MATLAB数据

创建方法
赋值语句
    1.元胞索引(cell indexing)方式
       格式：a(1, 2)={… … …}
    2.元胞内容索引(content indexing)方式
       格式：a{1, 2}=[…]  or ‘…’
    3.直接用大括号一次把所有元素括起来
    b = {'James Bond', [1 2;3 4;5 6]; pi, ones(5)}
    “{ }” 表示空元胞数组
    4.Cell indexing方式创建元胞数组
    >> a(1,1) = {[1 4 3; 0 5 8; 7 2 9]};
    >> a(1,2) = {'Anne Smith'};
    >> a(2,1) = {3+7i};
    >> a(2,2) = {-pi:pi/10:pi};
    5.Content indexing方式创建元胞数组
    >> b{1,1} = 'James Bond' ;
    >> b{1,2} = [1 2;3 4;5 6];
    >> b{2,1} = pi;
    >> b{2,2} = zeros(5);
b(1,3) = {1:3};  % or b{1,3} = 1:3;
cell函数
    b = cell(2, 3)
注意：每个cell占有4个字节的空间
celldisp显示元胞数组的全部内容
celldisp(a)  %or a{:} 显示全部内容
cellplot(a)   %图形方式显示元胞数组的结构

元胞数组的连接
Exam: 连接元胞数组a、b，生成元胞数组c。
c=[a b]     % or c=[a; b]

读取元胞数组中的内容
直接取用元胞数组的整个元胞（单元）>>b, d=b{1, 2} % 第1行、第2列元胞
取用元胞数组某元胞內的数据单位 >>e = b{1,2}(3,1) % 第1行、第2列元胞的第3行第一列数据
一次读取或刪除多个元胞
f=a(1,:)       % 读取元胞数组a第1行的所有元胞。
a(1,:) = []    % 删除元胞数组a第1行的所有元胞。




四、结构与结构数组的概念


程序控制结构
顺序结构
    数据的输入
         A = input（提示信息，选项）；
        ’s’选项，允许用户输入一个字符串。
    数据的输出
        disp(输出项）
    程序的暂停
        pause(延迟秒数) 延迟秒数缺省为 直到用户按任一键后程序继续执行。跟0值是不一样的。
选择结构
    if语句
        1.单分支if语句
        if 条件
            语句组
        end
        2.双分支if语句
        if 条件
            语句组 1
        else
            语句组  2
        end
        3.分支if语句
        if 条件1
            语句组 1
        elseif  条件2
            语句组  2
        …
        elseif  条件m
            语句组  m
        else
            语句组n
        end
    switch语句
        switch 表达式    % 应为一个标量或一个字符串
        case 表达式1     % 可以为一个标量或一个字符串，还可以为一个元胞矩阵。
                语句组1
        case 表达式2
                语句组2
        …
        case 表达式m
                语句组m
        otherwise
                 语句组 n
        end
        例:
        price = input(‘请输入商品价格’）；
        switch fix（price/100)
            case{0,1}                       %价格小于200
                rate = 0;
            case{2,3,4}
                rate = 3/100;             %价格大于等于200但小于500
            case num2cell(5:9)
                rate = 5/100;              %价格大于等于500但小于1000
             case num2cell(10:24)
                rate = 8/100;              %价格大于等于1000但小于2500
             case num2cell(25:49)
                rate = 10/100;            %价格大于等于2500但小于5000
              otherwise
                 rate = 14/100;           %价格大于等于5000
        end
        price = price*(1-rate)       %输出商品实际销售价格
    try语句
        try
            语句组1
        catch
            语句组2
        end
循环结构
    for语句
        for 循环变量 =表达式1：表达式2：表达式3
            循环体语句
        end
        其中表达式1的值为循环变量的初值，表达式2的值为步长，表达式3的值为循环变量的终值。步长为1时，表达式2可以省略。
    while语句
        while条件
               循环体语句
        end
    break语句
        终止循环的执行。
    continue语句
        跳过本次循环，执行下一次循环。



五、函数文件的基本结构
function  输出形参表 = 函数名（输入形参表）
注释说明部分
函数体语句

当输出形参多于一个时，应该用方括号括起来。
1. 关于函数文件名
    函数文件名通常由函数名再加上扩展名.m组成。
    当函数文件名与函数名不同时，Matlab将忽略函数名而确认文件名
    因此调用时使用函数文件名。
2. 关于注释说明部分
    注释说明包括3部分：
    ① 紧随引导行之后以%开头的第一注释行。
        这一行一般包括大写的函数文件名和函数功能简要描述，供lookfor
       关键词查询和help在线帮助时使用。
    ② 第一注释行及之后连续的注释行。
        通常包括函数输入/输出参数的含义及调用格式说明等信息，构成全
        部在线帮助文本。
    ③ 与在线帮助文本相隔一空行的注释行。
          包括函数文件编写和修改的信息，如作者和版本等。
3. 关于return语句
     如果在函数文件中插入了return语句，则执行到该语句就结束函数的执行，流程转至调用该函数的位置。通常也不使用return语句。

例5.10 编写函数文件，求半径为r的圆的面积和周长。
函数文件如下：
function [s,p] = fcircle(r)
% FCIRCLE calculate the area and perimeter of a circle of radii r
% r       圆半径
% s       圆面积
% p      圆周长

%2006年2月30日编
s = pi*r*r;
p = 2*pi*r;

六、函数调用
函数调用的一般格式是：
[输出实参表] = 函数名(输入实参表）
注意：函数调用时，各实参出现的顺序、个数，应与函数定义时相同。

在Matlab中，函数可以嵌套调用，即一个函数可以调用别的函数。
一个函数调用自身称为函数的递归调用。
function f = factor(n)
if n<=1
 f = 1;
else
 f = factor(n-1)*n;  %递归调用求(n-1)!
end

函数参数的可调性
Matlab用两个预定义变量nargin和nargout分别记录调用该函数时的输入实参和输出实参的个数

Matlab中，函数文件中的变量是局部变量。
全局变量用global命令定义，格式为：global 变量名


Matlab矩阵分析与处理
特殊矩阵
    常见的特殊矩阵有零矩阵、幺矩阵、单位矩阵等，这类特殊矩阵在应用中具有通用性。
    zeros：产生全0矩阵（零矩阵）。
    ones： 产生全1矩阵（幺矩阵）。
    eye：   产生单位矩阵。
    rand：产生0~1间均匀分布的随机矩阵。
    randn：产生均值为0，方差为1的标准正态分布随机矩阵。
对角阵与三角阵  只有对角线上有非零元素的矩阵称为对角矩阵
    提取矩阵的对角线元素函数：diag
        diag(A,k)提取第k条对角线的元素。k=0,+1,-1,...
    构造对角矩阵
        diag([1,2,-1,4]) % diag(A,k)

矩阵的逆
inv(A)

用矩阵求逆方法求解线性方程组
Ax=b   =>  x=b*A^-1
x = inv(A)*b   %x = A\b

矩阵行列式值
det(A)

元素排序
Matlab中对向量X排序的函数是sort(X), 函数返回一个对X中的元素按升序排列的新向量。
sort函数也可以对矩阵A的各列（或行）重新排序，其调用格式为：
   [Y,I] = sort(A,dim)
dim=1,按列排序；dim=2,按行排序，Y是排序后的矩阵。
按某1行或列排序呢？
sortrows(A,col)  按照第col列的元素升序排列所有的行 col默认1 如果col为负数，则排序时为降序

数据插值
一维数据插值：被插值函数有一个单变量。
采用的方法有：线性方法、最近方法、三次样条和三次插值。
在Matlab中实现这些插值的函数是interp1，其调用格式如下：
Y1 = interp1(X,Y,X1,method）
函数根据X，Y的值，计算函数在X1处的值。
X,Y是两个等长的已知向量，分别描述采样点和样本值；
X1是一个向量或标量，描述欲插值的点；
Y1是一个与X1等长的插值结果。
method是插值方法，允许的取值为：
（1）‘linear’：线性插值。默认的插值方式。它是把插值点靠近的两个数据点用直线连接，然后在直线上选取对应插值点的数据。
（2）‘nearest’：最近点插值。根据已知插值点与已知数据点的远近程度进行插值。插值点优先选择较近的数据点进行插值。
（3）‘cubic’：3次多项式插值。根据已知数据求出一个3次多项式，然后根据该多项式进行插值。
（4）‘spline’：3次样条插值。指在每个分段内构造一个3次多项式，使其满足插值条件外，在各节点处具有光滑的条件。


曲线拟合
在matlab中，用polyfit函数来求得最小二乘拟合多项式的系数，再用polyval函数按所得的多项式计算所给出点上的函数近似值。
polyfit函数的调用格式为：
[P,S] = polyfit(X,Y,m)
函数根据采样点X和采样点函数值Y，产生一个m次多项式P及其在采样
点的误差向量S。其中X、Y是两个等长的向量，P是一个长度为m+1的
向量，P的元素是多项式系数。
polyval函数的功能是按多项式的系数计算x点多项式的值。




显著性检验  用于实验处理组与对照组或两种不同处理的效应之间是否有差异，以及这种差异是否显著的方法。
原假设为真时，放弃原假设，称为第一类错误，概率为a  显著性水平 0.01 0.05 0.10
原假设不真时，不放弃原假设，称为第二类错误，概率为b
进行显著性检验是为了消除Ⅰ类错误和Ⅱ类错误
t检验 t'检验 U检验 方差分析 X2检验 零反应检验



相关分析和回归分析
自变量取值一定时，因变量的取值带有一定随机性的两个变量之间的关系叫做相关关系。
注：
（1）相关关系是一种不确定性关系；
（2）对具有相关关系的两个变量进行统计分析的方法叫回归分析。

相关性假设有，进行回归模型分析，通过拟合效果修正相关性假设和回归模型。
如果效果差且不能再改进，可以认定无相关性；
效果好，满足使用，则回归模型合格，相关性强。

相关分析对称地对待任何（两个）变量，两个变量都被看作是随机变量
回归分析对变量的处理方法存在不对称性，即区分因变量（被解释变量）和自变量（解释变量）：前者是随机变量，后者不是

线性相关性检验  显著性水平0.05\0.01 自由度：样本数-2
相关系数r  越接近1说明回归方程拟合程度越好
r>0.75，相关性很强；r<0.25，相关性很弱；其它，相关性一般
统计量K^2
偏差:实际观察值与回归平均值的差
残差:实际观察值与回归估计值的差 随机误差

step1：根据散点图粗略判断变量间是否线性相关，是否可用回归模型来拟合数据；
step2：通过残差判断模型拟合的效果，判断原始数据是否存在可疑数据（残差分析）
残差图：如果残差点均匀地落在水平的带状区域中，说明选用的模型比较合适，带状区域越宰，说明模型拟合精度越高，回归方程的预报精度越高。
最佳拟合曲线：

SST总偏差平方和：每个数据偏差的平方和 解释变量和随机误差的总效应
SSR回归平方和：总偏差平方和 - 残差平方和（随机误差的效应SSE）
相关指数R^2 R^2越接近1说明回归方程拟合程度越好 R^2就是相关系数r的平方
 R^2 = 1-残差平方和/总偏差平方和 = 回归平方和／总偏差平方和

SSE（Error sum of squares）
RSS（Regression sum of squares）
TSS（Total sum of squares）
r2 = 1 - SSE/TSS;         % R-square statistic
F = (RSS/(p-1))/s2;       % F statistic for regression
prob = fpval(F,p-1,nu); % Significance probability for regression 回归的显著性概率


多元线性回归
(1)b=regress(y，x)
[b，bint，r，rint，stats] = regess(y，x，alpha)
% 对一元线性回归，取k=1即可。alpha为显著性水平(缺省时设定为0.05)
b 回归系数估计值向量，b(1)常数项
bint为回归系数估计值的置信区间，
r，rint为残差及其置信区间，
stats是用于检验回归模型的统计量，有四个数值，
    第一个是R^2；
    第二个是F统计量值，用于检验模型是否通过检验。通过查F分布表，如果F>F分布表中对应的值，则通过检验。
    第三个是与统计量F对应的概率P，越接近0越好，当P<α时拒绝H0，回归模型成立！！！
    第四个是 an estimate of the error variance（一个错误的方差估计）。
画出残差及其置信区间，用命令rcoplot(r,rint)

(2)fitlm(x,y)

非线性回归
[beta,r,j] = nlinfit(x，y，'model’，beta0)

逐步回归
stepwise(x，y，inmodel，alpha)






七、附录

MATLAB Compiler
MATLABCompiler能够将你的matlab程序转换为自包含（self-contained）的应用程序和组件，这样你就可以将程序发放给你的终端用户，而且终端用户无需安装matlab就可以运行这些程序。MATLAB Compiler能够生成的应用或者组件包括下面这几类：
1、独立的应用程序
2、C和C++共享库（动态链接库，在Windows平台上是DLL，在Linux平台下是.so文件）
3、Excel插件
4、COM和.NET对象

MCR的全称是MATLAB Component Runtime，它是一组独立的共享库，通过它能够执行在MATLAB中编写的M文件。MCR支持MATLAB语言的所有功能。
CTF的全称是Component TechnologyFile，这是一种归档技术，通过它，MATLAB将可部署文件包装起来。需要注意的是，位于CTF归档文件中的所有M文件都采用了AES（Advanced EncryptionStandard）进行加密，AES的对成密钥则通过1024位的RSA密钥保护。除此之外，CTF还对归档文件进行了压缩。显然，通过这种方式，可以只将可知行的应用程序或者组件发布给终端用户，而保证源代码不被泄漏。

MATLAB Compiler的构建过程分为下面五步：
1、分析依赖关系
2、代码生成
3、创建归档文件（archive）
4、编译
5、链接

>> mcc -?       %or help mcc 获取mcc的帮助信息
>> mcc -m hello % compiler application
>> mcc -l hello % compiler dll

mcc -W 'java:com.dhms.mat,Mat,1.0' -T link:lib -d /Volumes/work/MATLAB/mat/for_testing class{Mat:/Volumes/work/MATLAB/mat.m}

mcc -W lib:mat -T link:lib -d /Volumes/work/MATLAB/mat/for_testing -v /Volumes/work/MATLAB/mat.m



