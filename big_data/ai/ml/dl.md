## 深度学习

Deep Learning

### 概述

深度学习框架组件包括TensorFlow、Caffe、MXNet及PyTorch等深度学习框架。

深度学习支持的框架包括TensorFlow（开源TF1.4和1.8版本）、MXNet 0.9.5和Caffe rc3。TensorFlow和MXNet支持用户自己编写的Python 代码，Caffe支持用户自定义网络文件。

TensorFlow-v1.2
TensorFlow-v1.4

深度强化学习(DRL)、自动机器学习(AutoML)和图神经网络(GNN)。

#### 起源

1943年，心里学家麦卡洛克和数学逻辑学家皮兹发表论文《神经活动中内在思想的逻辑演算》，提出了MP模型。MP模型是模仿神经元的结构和工作原理，构成出的一个基于神经网络的数学模型，本质上是一种“模拟人类大脑”的神经元模型。MP模型作为人工神经网络的起源，开创了人工神经网络的新时代，也奠定了神经网络模型的基础。

1949年，加拿大著名心理学家唐纳德·赫布在《行为的组织》中提出了一种基于无监督学习的规则——海布学习规则(Hebb Rule)。海布规则模仿人类认知世界的过程建立一种“网络模型”，该网络模型针对训练集进行大量的训练并提取训练集的统计特征，然后按照样本的相似程度进行分类，把相互之间联系密切的样本分为一类，这样就把样本分成了若干类。海布学习规则与“条件反射”机理一致，为以后的神经网络学习算法奠定了基础，具有重大的历史意义。

20世纪50年代末，在MP模型和海布学习规则的研究基础上，美国科学家罗森布拉特发现了一种类似于人类学习过程的学习算法——感知机学习。并于1958年，正式提出了由两层神经元组成的神经网络，称之为“感知器”。感知器本质上是一种线性模型，可以对输入的训练集数据进行二分类，且能够在训练集中自动更新权值。感知器的提出吸引了大量科学家对人工神经网络研究的兴趣，对神经网络的发展具有里程碑式的意义。

但随着研究的深入，在1969年，“AI之父”马文·明斯基和LOGO语言的创始人西蒙·派珀特共同编写了一本书籍《感知器》，在书中他们证明了单层感知器无法解决线性不可分问题（例如：异或问题）。由于这个致命的缺陷以及没有及时推广感知器到多层神经网络中，在20世纪70年代，人工神经网络进入了第一个寒冬期，人们对神经网络的研究也停滞了将近20年。

1982年，著名物理学家约翰·霍普菲尔德发明了Hopfield神经网络。Hopfield神经网络是一种结合存储系统和二元系统的循环神经网络。Hopfield网络也可以模拟人类的记忆，根据激活函数的选取不同，有连续型和离散型两种类型，分别用于优化计算和联想记忆。但由于容易陷入局部最小值的缺陷，该算法并未在当时引起很大的轰动。

##### 发展

直到1986年，深度学习之父杰弗里·辛顿提出了一种适用于多层感知器的反向传播算法——BP算法。BP算法在传统神经网络正向传播的基础上，增加了误差的反向传播过程。反向传播过程不断地调整神经元之间的权值和阈值，直到输出的误差达到减小到允许的范围之内，或达到预先设定的训练次数为止。BP算法完美的解决了非线性分类问题，让人工神经网络再次的引起了人们广泛的关注。

但是由于八十年代计算机的硬件水平有限，如：运算能力跟不上，这就导致当神经网络的规模增大时，再使用BP算法会出现“梯度消失”的问题。这使得BP算法的发展受到了很大的限制。再加上90年代中期，以SVM为代表的其它浅层机器学习算法被提出，并在分类、回归问题上均取得了很好的效果，其原理又明显不同于神经网络模型，所以人工神经网络的发展再次进入了瓶颈期。

##### 爆发

2006年，杰弗里·辛顿以及他的学生鲁斯兰·萨拉赫丁诺夫正式提出了深度学习的概念。他们在世界顶级学术期刊《科学》发表的一篇文章中详细的给出了“梯度消失”问题的解决方案——通过无监督的学习方法逐层训练算法，再使用有监督的反向传播算法进行调优。该深度学习方法的提出，立即在学术圈引起了巨大的反响，以斯坦福大学、多伦多大学为代表的众多世界知名高校纷纷投入巨大的人力、财力进行深度学习领域的相关研究。而后又在迅速蔓延到工业界中。

2012年，在著名的ImageNet图像识别大赛中，杰弗里·辛顿领导的小组采用深度学习模型AlexNet一举夺冠。AlexNet采用ReLU激活函数，从根本上解决了梯度消失问题，并采用GPU极大的提高了模型的运算速度。同年，由斯坦福大学著名的吴恩达教授和世界顶尖计算机专家Jeff Dean共同主导的深度神经网络——DNN技术在图像识别领域取得了惊人的成绩，在ImageNet评测中成功的把错误率从26％降低到了15％。深度学习算法在世界大赛的脱颖而出，也再一次吸引了学术界和工业界对于深度学习领域的关注。

随着深度学习技术的不断进步以及数据处理能力的不断提升，2014年，Facebook基于深度学习技术的DeepFace项目，在人脸识别方面的准确率已经能达到97%以上，跟人类识别的准确率几乎没有差别。这样的结果也再一次证明了深度学习算法在图像识别方面的一骑绝尘。

2016年，随着谷歌公司基于深度学习开发的AlphaGo以4:1的比分战胜了国际顶尖围棋高手李世石，深度学习的热度一时无两。后来，AlphaGo又接连和众多世界级围棋高手过招，均取得了完胜。这也证明了在围棋界，基于深度学习技术的机器人已经超越了人类。

2017年，基于强化学习算法的AlphaGo升级版AlphaGo Zero横空出世。其采用“从零开始”、“无师自通”的学习模式，以100:0的比分轻而易举打败了之前的AlphaGo。除了围棋，它还精通国际象棋等其它棋类游戏，可以说是真正的棋类“天才”。此外在这一年，深度学习的相关算法在医疗、金融、艺术、无人驾驶等多个领域均取得了显著的成果。所以，也有专家把2017年看作是深度学习甚至是人工智能发展最为突飞猛进的一年。

所以在深度学习的浪潮之下，不管是AI的相关从业者还是其他各行各业的工作者，都应该以开放、学习的心态关注深度学习、人工智能的热点动态。人工智能正在悄无声息的改变着我们的生活！

### TensorFlow

TensorFlow 是一个端到端开源机器学习平台。它拥有一个全面而灵活的生态系统，其中包含各种工具、库和社区资源，可助力研究人员推动先进机器学习技术的发展，并使开发者能够轻松地构建和部署由机器学习提供支持的应用。


1. 轻松地构建模型
	- TensorFlow 提供多个抽象级别，因此您可以根据自己的需求选择合适的级别。您可以使用高阶 Keras API 构建和训练模型，该 API 让您能够轻松地开始使用 TensorFlow 和机器学习。
	+ 如果您需要更高的灵活性，则可以借助即刻执行环境进行快速迭代和直观的调试。对于大型机器学习训练任务，您可以使用 Distribution Strategy API 在不同的硬件配置上进行分布式训练，而无需更改模型定义。
1. 随时随地进行可靠的机器学习生产
	+ TensorFlow 始终提供直接的生产途径。不管是在服务器、边缘设备还是网络上，TensorFlow 都可以助您轻松地训练和部署模型，无论您使用何种语言或平台。
	+ 如果您需要完整的生产型机器学习流水线，请使用 TensorFlow Extended (TFX)。要在移动设备和边缘设备上进行推断，请使用 TensorFlow Lite。请使用 TensorFlow.js 在 JavaScript 环境中训练和部署模型。
1. 强大的研究实验：
	+ 构建和训练先进的模型，并且不会降低速度或性能。借助 Keras Functional API 和 Model Subclassing API 等功能，TensorFlow 可以助您灵活地创建复杂拓扑并实现相关控制。为了轻松地设计原型并快速进行调试，请使用即刻执行环境。
	+ TensorFlow 还支持强大的附加库和模型生态系统以供您开展实验，包括 Ragged Tensors、TensorFlow Probability、Tensor2Tensor 和 BERT。

#### 安装
使用 Python 的 pip 软件包管理器安装 TensorFlow。
```shell
# Requires the latest pip
pip install --upgrade pip

# Current stable release for CPU and GPU
pip install tensorflow

# Or try the preview build (unstable)
pip install tf-nightly
```

TensorFlow 2 软件包需要使用高于 19.0 的 pip 版本（对于 macOS 来说，则需要高于 20.3 的 pip 版本）。

##### 版本

对于 TensorFlow 1.x，CPU 和 GPU 软件包是分开的：
- tensorflow==1.15：仅支持 CPU 的版本
- tensorflow-gpu==1.15：支持 GPU 的版本（适用于 Ubuntu 和 Windows）

TensorFlow 2 软件包：
- tensorflow：支持 CPU 和 GPU 的最新稳定版（适用于 Ubuntu 和 Windows）
- tf-nightly：预览 build（不稳定）。Ubuntu 和 Windows 均包含 GPU 支持。

##### GPU 支持

对于 Ubuntu 和 Windows，需要安装支持 CUDA® 的显卡，才能实现 GPU 支持。

为了实现 TensorFlow GPU 支持，需要各种驱动程序和库。为了简化安装并避免库冲突，建议您使用支持 GPU 的 TensorFlow Docker 映像（仅限 Linux）。此设置方式只需要 NVIDIA® GPU 驱动程序。

Ubuntu2004
```shell
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
sudo apt-get update
sudo apt-get -y install cuda
```

Windows 设置
```powershell
# 将 CUDA®、CUPTI 和 cuDNN 安装目录添加到 %PATH% 环境变量中。例如，如果 CUDA® 工具包安装到 C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.0，并且 cuDNN 安装到 C:\tools\cuda，请更新 %PATH% 以匹配路径：

SET PATH=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.0\bin;%PATH%
SET PATH=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.0\extras\CUPTI\lib64;%PATH%
SET PATH=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.0\include;%PATH%
SET PATH=C:\tools\cuda\bin;%PATH%
```

#### CUDA

统一计算设备架构（Compute Unified Device Architecture，CUDA），是显卡厂商NVIDIA推出的一种通用并行计算平台和编程模型。

CUDA™架构使GPU能够解决复杂的计算问题。它包含了CUDA指令集架构（ISA）以及GPU内部的并行计算引擎。开发人员可以使用C语言来为CUDA™架构编写程序，所编写出的程序可以在支持CUDA™的处理器上以超高性能运行。

2008年NVIDIA推出CUDA SDK2.0版本，大幅提升了CUDA的使用范围。

CUDA3.0已经开始支持C++和FORTRAN。

目前为止基于 CUDA 的 GPU 销量已达数以百万计，软件开发商、科学家以及研究人员正在各个领域中运用 CUDA，其中包括图像与视频处理、计算生物学和化学、流体力学模拟、CT 图像再现、地震分析以及光线追踪等等。

### Caffe

Caffe是一个清晰、可读性高、快速的深度学习框架，详情请参见Caffe官网。<http://caffe.berkeleyvision.org>


### MXNet

MXNet是一个深度学习框架，支持命令和符号编程，可以运行在CPU和GPU集群上。

### PyTorch


