## Windows PowerShell

PowerShell 是来自 Microsoft 的任务自动化和配置管理框架，由命令行 shell 和相关的脚本语言组成。最初只是一个 Windows 组件，称为 Windows PowerShell，随着 PowerShell Core的推出，它于2016年8月18日开源和支持跨平台。前者建立在.NET Framework 之上，后者建立在.NET Core 之上。

在 PowerShell 中，管理任务通常由 cmdlet（读作command-lets）执行，cmdlet 是实现特定操作的专用.NET类。它们通过访问不同数据存储（如文件系统或注册表）中的数据来工作，这些数据通过提供程序提供给 PowerShell 。第三方开发人员可以向 PowerShell 添加 cmdlet 和提供程序。Cmdlet 可以被脚本使用，而脚本又可以被打包成模块。

PowerShell 提供对 COM 和 WMI 的访问，使管理员能够在本地和远程 Windows 系统上执行管理任务，以及支持远程 Linux 系统和网络设备管理的 WS-Management 和 CIM。PowerShell 还提供了一个托管API，通过它可以将 PowerShell 运行时嵌入到其他应用程序中。然后，这些应用程序可以使用 PowerShell 功能来实现某些操作，包括那些通过图形界面公开的操作。Microsoft Exchange Server 2007已使用此功能将其管理功能公开为 PowerShell cmdlet 和提供程序，并实现图形管理工具作为 PowerShell 主机调用必要的 cmdlet。包括Microsoft SQL Server 2008在内的其他 Microsoft 应用程序也通过 PowerShell cmdlet 公开其管理接口。

PowerShell 包括其自身广泛的，基于控制台的帮助（类似于 Unix shells 里的 man page）。通过“Get-Help”cmdlet 访问。可以通过“Update-Help”cmdlet 从 Internet 检索更新本地的帮助内容。或者，根据具体情况可以通过 Get-Help -online 切换到网络获取帮助。

### 背景
用于个人计算机的 Microsoft Windows 的每个版本都包含用于管理操作系统的命令行解释器(command line interpreter，CLI)。它的前身 MS-DOS 完全依赖于 CLI。它们是 MS-DOS 和 Windows 9x 中的 COMMAND.COM，以及 Windows NT 系列操作系统中的 cmd.exe。两者都支持一些基本的内部命令。出于其他目的，必须编写单独的控制台应用程序。它们还包括一种基本的脚本语言（批处理文件），可用于自动执行各种任务。但是，它们不能用于自动化图形用户界面(graphical user interface，GUI) 功能的所有方面，部分原因是命令行等效操作是有限制的，并且脚本语言是初级的。在Windows Server 2003 中，情况有所改善，但脚本支持仍不令人满意。

Microsoft 试图通过在1998年随Windows 98引入Windows Script Host及其基于主机的命令行cscript.exe。它与Active Script引擎集成，并允许使用兼容语言编写脚本，例如 JScript 和 VBScript，利用应用程序通过组件对象模型(component object model，COM)公开的API。但是，它也有自己的不足：它的文档不是很容易访问，并且在经历了几次备受瞩目的利用其安全规定中的弱点的计算机病毒之后，它很快就获得了系统漏洞载体的美誉。不同版本的 Windows 提供了各种特殊用途的命令行解释器（例如netsh和WMIC）以及它们自己的命令集，但它们不能互操作。

##### Monad
到2002年，Microsoft 已开始开发一种新的命令行管理方法，包括名为 Monad（也称为 Microsoft Shell 或 MSH）的 CLI。其背后的想法于 2002年8月由其首席架构师 Jeffrey Snover 发表在名为“Monad Manifesto”的白皮书中。在2017年的一次采访中，Snover 解释了 PowerShell 的起源，他说他一直试图让 Unix 工具在 Windows 上可用，但由于“ Windows 和 Linux 之间的核心架构差异”而未能奏效。具体而言，他指出 Linux 将所有内容视为ASCII文本文件，而 Windows 将所有内容视为“返回结构化数据的API”。​​它们从根本上是不兼容的，这导致他采取了不同的方法。

Monad 是一个新的可扩展 CLI，具有全新的设计，能够自动执行一系列核心管理任务。Microsoft 于2003年10月在洛杉矶的专业发展大会上首次公开展示了 Monad。几个月后，他们开放了内部测试版，最终导致了公开测试版。Microsoft 于2005年6月17日发布了第一个 Monad 公开测试版，2005年9月11日发布了 Beta 2，2006年1月10日发布了 Beta 3。

##### PowerShell
2006年4月25日，在 Monad 最初发布后不久，Microsoft 宣布 Monad 已更名为 Windows PowerShell，将其定位为其管理技术产品的重要组成部分。同时发布了 PowerShell 的 Release Candidate (RC) 1。更改名称和 RC 的一个重要方面是它现在是 Windows 的一个组件，而不仅仅是一个附加组件。

PowerShell v1 的 Release Candidate 2 于2006年9月26日发布，最终版本于2006年11月14日发布到网络上。用于早期 Windows 版本的 PowerShell 于2007年1月30日发布。PowerShell v2.0 开发在 PowerShell v1 发布之前就开始了。在开发过程中，Microsoft 发布了三个社区技术预览(community technology preview，CTP)。Microsoft 向公众提供了这些版本。Windows PowerShell v2.0 的最后一个 CTP 版本于2008年12月发布。

PowerShell v2.0 已于2009年8月完成并发布，作为 Windows 7 和 Windows Server 2008 R2 的组成部分。适用于 Windows XP、Windows Server 2003、Windows Vista 和 Windows Server 2008 的 PowerShell 版本于2009年10月发布，可供32位和64位平台下载。在 TechNet 杂志2009年10月的一期中，Microsoft 称精通 PowerShell“是 Windows 管理员在未来几年需要的最重要的技能”。

Windows 10 为 PowerShell 提供了一个测试框架。

2016年8月18日，Microsoft 宣布他们已经使 PowerShell 开源和跨平台，支持 Windows、macOS、CentOS 和 Ubuntu。源代码已发布在 GitHub 上。向开源的转变创造了 PowerShell 的第二个化身，称为“PowerShell Core”，它在.NET Core上运行。它不同于“Windows PowerShell”，后者在完整的.NET Framework上运行。从 5.1 版开始，PowerShell Core 与 Windows Server 2016 Nano Server 捆绑在一起。


### 版本
PowerShell 最初使用代号“Monad”，于 2003 年 10 月在洛杉矶举行的专业开发者大会上首次公开展示。仍然支持所有主要版本，并且每个主要版本都具有与先前版本的向后兼容性。

#### Windows PowerShell 1.0
PowerShell 1.0 于 2006 年 11 月发布，适用于Windows XP SP2、Windows Server 2003 SP1和Windows Vista。它是Windows Server 2008的可选组件。

#### Windows PowerShell 2.0
PowerShell 2.0 与 Windows 7和Windows Server 2008 R2 集成，并针对带有 Service Pack 3 的 Windows XP、带有 Service Pack 2 的 Windows Server 2003和带有 Service Pack 1 的 Windows Vista 发布。 

PowerShell v2 包括对脚本语言和托管 API 的更改，此外还包括 240 多个新 cmdlet。 

PowerShell 2.0 的新特性包括：  

- PowerShell 远程处理：使用WS-Management，PowerShell 2.0 允许在远程计算机或大量远程计算机上调用脚本和 cmdlet。
- 后台作业：也称为PSJob，它允许异步调用命令序列（脚本）或管道。作业可以在本地机器或多台远程机器上运行。PSJob 中的交互式 cmdlet 会阻止作业的执行，直到提供用户输入为止。
- 事务：启用 cmdlet，开发人员可以执行事务性操作。PowerShell 2.0 包括用于启动、提交和回滚PSTransaction 的事务 cmdlet，以及用于管理和引导事务到参与 cmdlet 和提供程序操作的功能。PowerShell Registry 提供程序支持事务。
- 高级功能：这些是使用 PowerShell 脚本语言编写的 cmdlet。最初称为“脚本 cmdlet”，此功能后来更名为“高级功能”。
- SteppablePipelines：这允许用户控制何时调用 cmdlet的BeginProcessing()、ProcessRecord()和EndProcessing()函数。
- 模块：这允许脚本开发人员和管理员在独立的、可重用的单元中组织和分区 PowerShell 脚本。来自模块的代码在其自己的自包含上下文中执行，并且不会影响模块外部的状态。模块可以使用脚本定义受限的运行空间环境。它们具有持久状态以及公共和私人成员。
- 数据语言：PowerShell 脚本语言的域特定子集，允许将数据定义与脚本分离，并允许在运行时将本地化的字符串资源导入脚本（脚本国际化）。
- 脚本调试：它允许在 PowerShell 脚本或函数中设置断点。可以在行、行和列、命令和变量的读或写访问上设置断点。它包括一组通过脚本控制断点的 cmdlet。
- 事件：此功能允许监听、转发和处理管理和系统事件。事件处理允许 PowerShell 主机收到有关其托管实体的状态更改的通知。它还使 PowerShell 脚本能够订阅ObjectEvents、PSEvents和WmiEvents并同步和异步处理它们。
- Windows PowerShell 集成脚本环境 (ISE)：PowerShell 2.0 包括基于 GUI 的 PowerShell 主机，该主机在选项卡式 UI中提供集成调试器、语法突出显示、选项卡完成和多达 8 个支持 PowerShell Unicode 的控制台（运行空间），以及功能仅运行脚本中的选定部分。
- 网络文件传输：本机支持使用后台智能传输服务(BITS)在机器之间进行优先级、节流和异步文件传输。
- 新 cmdlet：包括Out-GridView在WPF GridView对象中显示表格数据、在允许它的系统上以及是否安装并启用了 ISE。
- 新运算符: -Split、-Join和 Splatting ( @) 运算符。
- 使用 Try-Catch-Finally 处理异常：与其他 .NET 语言不同，这允许单个 catch 块有多种异常类型。
- Nestable Here-Strings：PowerShell Here-Strings已得到改进，现在可以嵌套。
- 块注释：PowerShell 2.0 支持使用<#和#>作为分隔符的块注释。
- 新 API：新 API 的范围从将 PowerShell 解析器和运行时的更多控制交给主机，到创建和管理运行空间 ( RunspacePools)集合以及创建仅允许调用已配置的 PowerShell 子集的受限运行空间的能力. 新的 API 还支持参与由 PowerShell 管理的事务

#### Windows PowerShell 3.0
PowerShell 3.0 与Windows 8和Windows Server 2012集成。Microsoft 还为Windows 7 Service Pack 1、Windows Server 2008 Service Pack 1 和Windows Server 2008 R2 Service Pack 1提供了 PowerShell 3.0 。 

PowerShell 3.0 是更大的软件包Windows Management Framework 3.0 (WMF3) 的一部分，该软件包还包含支持远程处理的WinRM服务。Microsoft 发布了几个WMF3社区技术预览版。Windows Management Framework 3.0 的早期社区技术预览 2 (CTP 2) 版本于 2011 年 12 月 2 日发布。 Windows Management Framework 3.0 于 2012 年 12 月正式发布并包含在 Windows 8 和 Windows Server 中默认为 2012 年。

PowerShell 3.0 中的新功能包括：  : 33–34

- 计划作业：可以使用Windows 任务计划程序基础结构将作业计划为在预设的时间和日期运行。
- 会话连接：会话可以断开并重新连接。远程会话对临时网络故障的容忍度更高。
- 改进的代码编写：添加了代码完成(IntelliSense) 和代码段。PowerShell ISE 允许用户使用对话框来填写 PowerShell cmdlet 的参数。
- 委派支持：可以将管理任务委派给没有此类任务权限的用户，而无需授予他们永久的额外权限。
- 帮助更新：可以通过 Update-Help 命令更新帮助文档。
- 自动模块检测：每当调用来自该模块的命令时，都会隐式加载模块。代码完成也适用于卸载的模块。
- 新命令：添加了数十个新模块，包括管理磁盘get-WmiObject win32_logicaldisk、卷、防火墙、网络连接和打印机的功能，这些功能以前是通过 WMI 执行的。

#### Windows PowerShell 4.0
PowerShell 4.0 与Windows 8.1和Windows Server 2012 R2集成。Microsoft 还为Windows 7 SP1、Windows Server 2008 R2 SP1 和Windows Server 2012提供了 PowerShell 4.0 。

PowerShell 4.0 中的新功能包括：

- 所需状态配置：  声明性语言扩展和工具，可以使用DMTF管理标准和WS-Management协议为系统部署和管理配置数据
- 新的默认执行策略：在 Windows 服务器上，默认执行策略现在是RemoteSigned。
- 保存帮助：现在可以为安装在远程计算机上的模块保存帮助。
- 增强的调试：调试器现在支持调试工作流、远程脚本执行和跨 PowerShell 会话重新连接保留调试会话。
- -PipelineVariable 开关：一个新的普遍存在的参数，用于将当前管道对象公开为用于编程目的的变量
- 管理物理和Hyper-V虚拟化网络交换机的网络诊断
- Where 和 ForEach方法语法提供了一种过滤和迭代对象的替代方法。

#### Windows PowerShell 5.0
包含 PowerShell 5.0 的 Windows 管理框架 (WMF) 5.0 RTM 于 2016 年 2 月 24 日重新发布到 Web 上，此前发布的初始版本存在严重错误。

主要功能包括：

- 为面向对象编程创建类的新class 关键字
- enum创建枚举的新关键字
- OneGet支持Chocolatey 包管理器的cmdlet 
- 将对交换机管理的支持扩展到第 2 层网络交换机。
- 调试 PowerShell 后台作业和其他进程中托管的 PowerShell 实例（每个进程都称为“运行空间”）
- 所需状态配置 (DSC) 本地配置管理器 (LCM) 2.0 版
- DSC 部分配置
- DSC 本地配置管理器元配置
- 使用 PowerShell 类创作 DSC 资源

#### Windows PowerShell 5.1
它于2016 年 8 月 2 日与Windows 10 周年更新一起发布，并在Windows Server 2016 中发布。 PackageManagement 现在支持代理，PSReadLine 现在支持 ViMode，并且添加了两个新的 cmdlet：Get-TimeZone 和 Set-TimeZone。LocalAccounts 模块允许添加/删除本地用户帐户。 PowerShell 5.1 的预览版已于 2016 年 7 月 16 日发布，适用于 Windows 7、Windows Server 2008、Windows Server 2008 R2、Windows Server 2012 和 Windows Server 2012 R2，并于 2017 年 1 月 19 日发布。

PowerShell 5.1 是第一个包含“桌面”和“核心”两个版本的版本。“桌面”版是在 .NET Framework 堆栈上运行的传统 Windows PowerShell 的延续。“Core”版本在 .NET Core 上运行，并与 Windows Server 2016 Nano Server 捆绑在一起。为了换取更小的占用空间，后者缺少一些功能，例如管理剪贴板或将计算机加入域的 cmdlet、WMI 版本 1 cmdlet、事件日志 cmdlet 和配置文件。这是专为 Windows 制作的 PowerShell 的最终版本。

#### PowerShell Core 6
PowerShell Core 6.0 于 2016 年 8 月 18 日首次发布，当时 Microsoft 推出了 PowerShell Core 并决定使该产品跨平台、独立于 Windows、免费和开源。它于 2018 年 1 月 10 日在 Windows、macOS和Linux上全面上市。它有自己的支持生命周期，并遵守 Windows 10 引入的 Microsoft 生命周期策略：仅支持最新版本的 PowerShell Core。Microsoft 预计每六个月发布一个 PowerShell Core 6.0 次要版本。

此版本 PowerShell 中最显着的变化是扩展到其他平台。对于 Windows 管理员，此版本的 PowerShell 不包含任何主要的新功能。在 2018 年 1 月 11 日接受社区采访时，PowerShell 团队被要求列出 Windows IT 专业人员从 Windows PowerShell 5.1 迁移到 PowerShell Core 6.0 时会发生的最令人兴奋的 10 件事；对此，Microsoft 的 Angel Calvo 只能说出两个：跨平台和开源。

据 Microsoft 称，PowerShell 6.1 的新功能之一是“与 Windows 10 和Windows Server 2019 中1900 多个现有 cmdlet 的兼容性”。尽管如此，在完整版的更改日志中仍无法找到这些 cmdlet 的详细信息。Microsoft 后来声称这个数字是不够的，因为 PowerShell Core 未能取代 Windows PowerShell 5.1 并在 Windows 上获得牵引力。然而，它在 Linux 上很流行。

PowerShell Core 6.2 主要侧重于性能改进、错误修复以及更小的 cmdlet 和语言增强功能，以提高开发人员的工作效率。

#### PowerShell 7
PowerShell 7 是 PowerShell Core 6.x 产品以及 Windows PowerShell 5.1 的替代品，后者是最后一个受支持的 Windows PowerShell 版本。 开发的重点是使 PowerShell 7 成为 Windows PowerShell 5.1 的可行替代品，即在与 Windows 附带的模块的兼容性方面与 Windows PowerShell 几乎相同。

PowerShell 7 中的新功能包括：

- -Parallel用于ForEach-Object帮助处理并行处理的cmdlet的开关
- 在与内置 Windows 模块的兼容性方面与 Windows PowerShell 几乎相同
- 新的错误视图
- 该Get-Errorcmdlet的
- 允许有条件地执行管道中的下一个 cmdlet 的管道链接运算符（&&和||）
- 的：运营商三元操作
- 该??=只分配一个值给一个变量时操作变量的现有值是空
- 该??运营商空合并
- 跨平台Invoke-DscResource（实验性）
- 返回Out-GridViewcmdlet
- -ShowWindow开关的返回Get-Help

### 最佳实践
PowerShell 中的编译命令称为 cmdlet。 Cmdlet 的发音为“command-let”（而不是 CMD-let）。 Cmdlet 名称采用单数形式的“动词-名词”命令形式，这样更易于被发现。

```powershell
$PSVersionTable # 版本信息

Get-ExecutionPolicy # 查看执行策略 
Set-ExecutionPolicy # 设置执行策略
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
# Restricted 当执行策略设置为“受限”时，PowerShell 脚本根本无法运行。 这是所有 Windows 客户端操作系统上的默认设置。
# RemoteSigned 远程签名

Get-Process # 用于确定正在运行哪些进程
Get-Service # 用于检索服务及其状态的列表

Get-Command # 帮助查找命令。 运行不带任何参数的 Get-Command 会返回系统上所有命令的列表。
Get-Help # 首先根据提供的输入来搜索命令名称的通配符匹配项。 如果找不到匹配项，它将搜索帮助主题本身；如果还找不到匹配项，则返回错误。
Get-Member # 可帮助发现可用于命令的对象、属性和方法。 任何生成基于对象的输出的命令都可以通过管道传递到 Get-Member。

# 与通常的看法相反，Get-Help 可用于查找没有帮助主题的命令。

Get-Help -Name Get-Help
Get-Help -Name Get-Help -Full
help -Name Get-Help -Full
help Get-Help -Full

help Get-Help -Parameter Name
help Get-Command -Full | Out-GridView # 管道，一个命令的输出可以用作另一个命令的输入。 
help process # 同 help *process*

Get-Help -Name Get-Command -Full
Get-Help -Name Get-Command -Detailed
Get-Help -Name Get-Command -Examples
Get-Help -Name Get-Command -Online
Get-Help -Name Get-Command -Parameter Noun
Get-Help -Name Get-Command -ShowWindow

Update-Help

Get-Command -Noun Process
Get-Command -Name *service*
Get-Command -Name *service* -CommandType Cmdlet, Function, Alias

Get-Command | Get-Random | Get-Help -Full # 随机一个命令的帮助信息

# 属性
Get-Service -Name w32time
Get-Service -Name w32time | Get-Member

Get-Command -ParameterType ServiceController
Get-Service -Name w32time | Select-Object -Property *
Get-Service -Name w32time | Select-Object -Property Status, Name, DisplayName, ServiceType

# 方法
Get-Service -Name w32time | Get-Member -MemberType Method
(Get-Service -Name w32time).Stop()
Get-Service -Name w32time | Start-Service -PassThru

Get-Process -Name PowerShell
Get-Process -Name PowerShell | Get-Member

# 如果命令没有生成输出，则无法通过管道将其传递到 Get-Member。 由于 Start-Service 默认不生成任何输出，在尝试通过管道将其传递到 Get-Member 时会生成错误。
# 可以使用 Start-Service cmdlet 指定 PassThru 参数，以使其生成输出，然后通过管道将输出传递到 Get-Member，这样不会出错。
Start-Service -Name w32time -PassThru | Get-Member

Get-Command -Module ActiveDirectory
Get-ADUser -Identity mike | Get-Member
Get-ADUser -Identity mike -Properties * | Get-Member

$Users = Get-ADUser -Identity mike -Properties *
$Users | Get-Member
$Users | Select-Object -Property Name, LastLogonDate, LastBadPasswordAttempt
Get-ADUser -Identity mike -Properties LastLogonDate, LastBadPasswordAttempt

$Service = 'w32time'; Get-Service -Name $Service # 分号分隔
Get-Service | Where-Object Name -eq w32time # 筛选左侧

Get-Service |
Select-Object -Property DisplayName, Running, Status |
Where-Object CanPauseAndContinue

Get-Service |
Where-Object CanPauseAndContinue |
Select-Object -Property DisplayName, Status

```

#### 端口转发

netsh(Network Shell) 是一个windows系统本身提供的功能强大的网络配置命令行工具。 导出配置脚本：netsh -c interface ip dump > c:\interface.txt 导入配置脚本：netsh -f c:\interface.txt。

```powershell
netsh interface portproxy show all

netsh interface portproxy add v4tov4 listenport=8000 listenaddress=192.168.12.132 connectport=8000 connectaddress=127.0.0.1

netsh interface portproxy delete v4tov4 listenport=8000 listenaddress=192.168.12.132
```



#### scoop——Windows下的包管理系统
要求powershell3或以上版本， .NET Framework 4.5或以上版本。
```
$PSVersionTable.PSVersion.Major   #查看Powershell版本
$PSVersionTable.CLRVersion.Major  #查看.NET Framework版本
```

##### 安装 scoop
在 PowerShell 中输入下面内容，保证允许本地脚本的执行：
```
set-executionpolicy remotesigned -scope currentuser
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')

or

Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iwr -useb get.scoop.sh | iex
```


##### 安装其他软件
```
scoop search git
scoop install git

scoop install aria2
scoop config aria2-max-connection-per-server 16
scoop config aria2-split 16
scoop config aria2-min-split-size 1M

scoop uninstall 7zip # 卸载

scoop update #更新 scoop
scoop update 7zip # 更新7zip
scoop * # 更新全部

scoop bucket add extras # 添加官方维护的extras bucket
scoop bucket add versions

scoop install calibre gimp inkscape latex zotero

scoop bucket add scoopbucket https://github.com/yuanying1199/scoopbucket # 添加第三方bucket

scoop install scoopbucket/cajviewerlite

```

- "extras": "https://github.com/lukesampson/scoop-extras.git",
- "versions": "https://github.com/scoopinstaller/versions",
- "nightlies": "https://github.com/scoopinstaller/nightlies",
- "nirsoft": "https://github.com/kodybrown/scoop-nirsoft",
- "php": "https://github.com/nueko/scoop-php.git",
- "nerd-fonts": "https://github.com/matthewjberger/scoop-nerd-fonts.git",
- "nonportable": "https://github.com/oltolm/scoop-nonportable",
- "java": "https://github.com/se35710/scoop-java",
- "games": "https://github.com/Calinou/scoop-games"

#### Chocolatey——Windows下的包管理系统

##### 管理员权限运行cmd.exe或powershell.exe

##### 安装 Chocolatey
```cmd
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

##### 安装其他软件
```
choco install ${packagename} -y
cinst ${packagename} -y

choco install git.install
choco install 7zip.install

choco install googlechrome

choco install jdk8

choco install nodejs.install // 最新版本，当前是11.6.0
choco install nodejs-lts     // lts的最新版本，当前是10.15.0

choco install vscode

choco install intellijidea-community // 社区版
choco install intellijidea-ultimate  // 旗舰版

choco install jdk8 googlechrome vscode 7zip // 一次安装多个软件包
choco install nodejs.install --version 0.10.35 // 安装指定版本
```

##### 根据配置安装所有软件
```
choco install dev-package.config // 安装dev-package.config文件内描述的所有软件包
```
```xml
<?xml version="1.0" encoding="utf-8"?>
    <packages>
      <package id="jdk8" />
      <package id="googlechrome" version="71.0.3578.98" />
      <package id="vscode" />
      <package id="7zip" />
    </packages>
```





