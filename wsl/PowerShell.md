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

### 使用
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
#### PowerShellGet
PowerShellGet 是一个 PowerShell 模块，其中包含用于向/从 NuGet 存储库发现、安装、发布和更新 PowerShell 模块（以及其他项目）的命令。 PowerShellGet 随 PowerShell 版本 5.0 及更高版本提供。 对于 PowerShell 版本 3.0 及更高版本，它可以作为单独的下载提供。

Microsoft 托管 PowerShell 库联机 NuGet 存储库。 存储库中包含的大多数模块不是由 Microsoft 编写的。 

公司可以托管自己的内部专用 NuGet 存储库，在这些存储库中，他们可以发布仅供内部使用的模块以及从其他源下载的模块（已验证其并非恶意模块）。

由于 PowerShell 库是不受信任的存储库，因此系统会提示你同意安装该模块。

使用 PowerShellGet 模块中包含的 Find-Module cmdlet，在 PowerShell 库中查找安装 MrToolkit 的模块。

```powershell
Find-Module -Name MrToolkit | Install-Module
Get-MrPipelineInput -Name Stop-Service # 用于确定接受管道输入的命令参数、接受的对象类型，以及是按值还是按属性名称接受管道输入 。
```

#### 格式设置
最常见的格式命令是 Format-Table 和 Format-List。 还可以使用 Format-Wide 和 Format-Custom，但不太常见。
```powershell
# 多个列输出 像sql表一样
Get-Service -Name w32time | Select-Object -Property Status, DisplayName, Can*
Get-Service -Name w32time | Select-Object -Property Status, DisplayName, Can* |
Format-Table

# 多个行输出
Get-Service -Name w32time
Get-Service -Name w32time | Format-List

# 无法通过管道将格式命令传送给大多数其他命令。 
# 可以将格式命令通过管道传送给一些 Out-* 命令，但仅此而已。 
# 因此，建议在行尾执行任何格式设置（右对齐格式）。
Get-Service -Name w32time | Format-List | Get-Member
```

#### 别名
PowerShell 包含一组内置别名，你也可以定义自己的别名。

Get-Alias cmdlet 用于查找别名。 如果已知命令的别名，则 Name 参数用于确定与该别名关联的命令。
```powershell
Get-Alias # 查看所有别名
Get-Alias -Name gcm
Get-Alias -Name gcm, gm
Get-Alias gm # Name 参数可忽略，它是位置参数。

Get-Alias -Definition Get-Command, Get-Member # 查找命令的别名
```

#### 提供程序
PowerShell 中的提供程序是一种允许文件系统访问数据存储的接口。 PowerShell 中提供了许多内置提供程序。

第三方模块（例如 Active Directory PowerShell 模块和 SQL Server PowerShell 模块）都添加了自己的 PowerShell 提供程序和 PSDrive。

```powershell
Get-PSProvider # 查看所有提供程序。如用于注册表、别名、环境变量、文件系统、函数、变量、证书和 WSMan 的内置提供程序。
Get-PSDrive # 显示由提供程序公开的驱动器，还显示 Windows 逻辑驱动器，其中包括映射到网络共享的驱动器。

Import-Module -Name ActiveDirectory, SQLServer # 导入第三方模块
```

#### 比较运算符
PowerShell 包含许多比较运算符，用于比较值或查找与特定模式匹配的值。

- -eq 等于 equal
- -ne 不等于 not equal
- -gt 大于 greater than
- -ge 大于或等于 greater than or equal
- -lt 小于 less than
- -le 小于或等于 less than or equal
- -Like	使用 * 通配符进行匹配
- -NotLike	不使用 * 通配符进行匹配
- -Match	匹配指定的正则表达式
- -NotMatch	不匹配指定的正则表达式
- -Contains	确定集合中是否包含指定的值
- -NotContains	确定集合是否不包含特定值
- -In	确定指定的值是否在集合中
- -NotIn	确定指定的值是否不在集合中
- -Replace	替换指定的值

以上列出的所有运算符都不区分大小写。 将 c 放置在运算符之前，可使其区分大小写。 例如，-ceq 是区分大小写的 -eq 比较运算符。

大于、大于或等于、小于和小于或等于均可用于字符串或数值。

```powershell
'PowerShell' -eq 'powershell' # 等于 不区分大小写
'PowerShell' -ceq 'powershell' # 等于 区分大小写
'PowerShell' -ne 'powershell' # 不等于 不区分大小写
5 -gt 5 # 大于
5 -ge 5 # 大于或等于
5 -lt 10 # 小于
'PowerShell' -like '*shell' # 执行“like”匹配
'PowerShell' -match '^*.shell$' # 使用正则表达式执行匹配

# 使用范围运算符将数字 1 到 10 存储在变量中。
$Numbers = 1..10
$Numbers -contains 15 # 确定它是否包含数字 15。
$Numbers -contains 10
$Numbers -notcontains 15 # 反转逻辑，以查看 $Numbers 变量是否不包含值。
$Numbers -notcontains 10

# PowerShell 版本 3.0 首次引入了“in”比较运算符。 它用于确定某个值是否“位于”数组中。 $Numbers 变量是数组，因为它包含多个值。
15 -in $Numbers # 换言之，-in 执行与 contains 比较运算符相同的测试，不过方向相反。
10 -in $Numbers
10 -notin $Numbers # not 反转 -in 运算符的逻辑。
15 -notin $Numbers

'PowerShell' -replace 'Shell' # 用于替换内容。 如果指定一个值，则会将该值替换为空值。 
'SQL Saturday - Baton Rouge' -Replace 'saturday','Sat'
'SQL Saturday - Baton Rouge'.Replace('saturday','Sat') # Replace 方法区分大小写
```

#### 循环

```powershell
'ActiveDirectory', 'SQLServer' |
   ForEach-Object {Get-Command -Module $_} |
     Group-Object -Property ModuleName -NoElement |
         Sort-Object -Property Count -Descending


$ComputerName = 'DC01', 'WEB01'
foreach ($Computer in $ComputerName) {
  Get-ADComputer -Identity $Computer
}

for ($i = 1; $i -lt 5; $i++) {
  Write-Output "Sleeping for $i seconds"
  Start-Sleep -Seconds $i
}

$number = Get-Random -Minimum 1 -Maximum 10
do {
  $guess = Read-Host -Prompt "What's your guess?"
  if ($guess -lt $number) {
    Write-Output 'Too low!'
  }
  elseif ($guess -gt $number) {
    Write-Output 'Too high!'
  }
}
until ($guess -eq $number)

$number = Get-Random -Minimum 1 -Maximum 10
do {
  $guess = Read-Host -Prompt "What's your guess?"
  if ($guess -lt $number) {
    Write-Output 'Too low!'
  } elseif ($guess -gt $number) {
    Write-Output 'Too high!'
  }
}
while ($guess -ne $number)

$date = Get-Date -Date 'November 22'
while ($date.DayOfWeek -ne 'Thursday') {
  $date = $date.AddDays(1)
}
Write-Output $date

# Break 旨在中断循环。 它通常与 switch 语句一起使用。
for ($i = 1; $i -lt 5; $i++) {
  Write-Output "Sleeping for $i seconds"
  Start-Sleep -Seconds $i
  break
}
# Continue 旨在跳到循环的下一次迭代。
while ($i -lt 5) {
  $i += 1
  if ($i -eq 3) {
    continue
  }
  Write-Output $i
}
# Return 旨在退出现有作用域。
$number = 1..10
foreach ($n in $number) {
  if ($n -ge 4) {
    Return $n
  }
}
```
#### 使用 WMI
默认情况下，PowerShell 附带可处理 Windows Management Instrumentation (WMI) 等其他技术的 cmdlet。 PowerShell 中存在多个本机 WMI cmdlet，且无需安装任何其他软件或模块。

从一开始，PowerShell 就具有可处理 WMI 的 cmdlet。 

PowerShell 版本 3.0 中引入了通用信息模型 (CIM) cmdlet。 CIM cmdlet 的设计目的是使其可以同时在 Windows 和非 Windows 计算机上使用。 由于 WMI cmdlet 已弃用，因此建议使用 CIM cmdlet 代替 WMI cmdlet。

所有 CIM cmdlet 都包含在一个模块中。 

在同一台计算机上运行多个查询时，为每个查询使用 CIM 会话比使用计算机名更有效。 创建 CIM 会话时只需建立一次连接。 然后，多个查询使用此同一会话检索信息。 如果使用计算机名，cmdlet 需要建立和断开与每个查询的连接。

Get-CimInstance cmdlet 默认使用 WSMan 协议，这意味着远程计算机需要 PowerShell 3.0 或更高版本才能进行连接。 实际上，PowerShell 版本并不那么重要，重要的是堆栈版本。 可以使用 Test-WSMan cmdlet 确定堆栈版本。 堆栈版本需为 3.0。 PowerShell 3.0 及更高版本提供该版本的堆栈。

较旧的 WMI cmdlet 使用 DCOM 协议，该协议与较低版本的 Windows 兼容。 而较新 Windows 版本上的防火墙通常会阻止 DCOM。 可使用 New-CimSessionOption cmdlet 创建可与 New-CimSession 一起使用的 DCOM 协议连接。 这样便可使用 Get-CimInstance cmdlet 与低至 Windows Server 2000 的 Windows 版本进行通信。 这也意味着，将 Get-CimInstance cmdlet 与配置为使用 DCOM 协议的 CimSession 一起使用时，远程计算机上不需要 PowerShell。

```powershell
Get-Command -Noun WMI* # 确定 PowerShell 中存在哪些 WMI cmdlet。

Get-Command -Module CimCmdlets # 获取 CIM cmdlet 的列表

Get-CimInstance -Query 'Select * from Win32_BIOS' # 使用 WMI 查询语言 (WQL) 来查询 WMI
Get-CimInstance -ClassName Win32_BIOS # 查询 WMI 的单项
Get-CimInstance -ClassName Win32_BIOS | Select-Object -Property SerialNumber
# 默认情况下，系统会在后台检索一些从不使用的属性。 在本地计算机上查询 WMI 时，这可能不会产生什么影响。 但是，如果开始查询远程计算机，前述检索不仅要花费更多的处理时间来返回相关信息，还会在网络中拉取不必要的额外信息。 Get-CimInstance 有一个可以限制检索到的信息的 Property 参数。 这会提升 WMI 查询的效率。
Get-CimInstance -ClassName Win32_BIOS -Property SerialNumber | Select-Object -Property SerialNumber
Get-CimInstance -ClassName Win32_BIOS -Property SerialNumber | Select-Object -ExpandProperty SerialNumber # ExpandProperty 返回简单字符串
(Get-CimInstance -ClassName Win32_BIOS -Property SerialNumber).SerialNumber # 使用点式语法


Get-CimInstance -ComputerName dc01 -ClassName Win32_BIOS # 查询远程主机信息，需要域管理员身份运行
$CimSession = New-CimSession -ComputerName dc01 -Credential (Get-Credential)
Get-CimInstance -CimSession $CimSession -ClassName Win32_BIOS

$DCOM = New-CimSessionOption -Protocol Dcom
$Cred = Get-Credential
$CimSession = New-CimSession -ComputerName sql03 -SessionOption $DCOM -Credential $Cred
Get-CimInstance -CimSession $CimSession -ClassName Win32_BIOS

Get-CimSession # 查看当前连接的 CimSessions 及其正在使用的协议。

$CimSession = Get-CimSession
Get-CimInstance -CimSession $CimSession -ClassName Win32_BIOS

Get-CimSession | Remove-CimSession # 删除所有 CIM 会话
```
#### 远程处理

```powershell
Get-Command -ParameterName ComputerName # 确定哪些命令具有 ComputerName 参数 

Enable-PSRemoting

# 一对一远程处理
$Cred = Get-Credential
Enter-PSSession -ComputerName dc01 -Credential $Cred

# 一对多远程处理
Invoke-Command -ComputerName dc01, sql02, web01 {Get-Service -Name W32time} -Credential $Cred
Invoke-Command -ComputerName dc01, sql02, web01 {Get-Service -Name W32time} -Credential $Cred | Get-Member

Invoke-Command -ComputerName dc01, sql02, web01 {(Get-Service -Name W32time).Stop()} -Credential $Cred
Invoke-Command -ComputerName dc01, sql02, web01 {Get-Service -Name W32time} -Credential $Cred

# 创建会话
$Session = New-PSSession -ComputerName dc01, sql02, web01 -Credential $Cred
Invoke-Command -Session $Session {(Get-Service -Name W32time).Start()}
Invoke-Command -Session $Session {Get-Service -Name W32time}

Get-PSSession | Remove-PSSession
```

#### 函数
在 PowerShell 中命名函数时，结合使用帕斯卡拼写法名称和已批准的谓词和单数名词。 建议在名词前面加上前缀以防止命名冲突。 例如：`<ApprovedVerb>-<Prefix><SingularNoun>`。

```powershell

Get-Verb | Sort-Object -Property Verb # ps批准的谓词的特定列表

function Get-Version { # 防止冲突 Get-PSVersion、Get-MrPSVersion
    $PSVersionTable.PSVersion
}

Get-ChildItem -Path Function:\Get-*Version # 查看函数
Get-ChildItem -Path Function:\Get-*Version | Remove-Item # 删除函数
Remove-Module -Name <ModuleName> # 卸载模块，来删除函数

function Test-MrParameter {

    param (
        $ComputerName
    )

    Write-Output $ComputerName

}

function Get-MrParameterCount {
    param (
        [string[]]$ParameterName
    )

    foreach ($Parameter in $ParameterName) {
        $Results = Get-Command -ParameterName $Parameter -ErrorAction SilentlyContinue

        [pscustomobject]@{
            ParameterName = $Parameter
            NumberOfCmdlets = $Results.Count
        }
    }
}

Get-MrParameterCount -ParameterName ComputerName, Computer, ServerName, Host, Machine
# 使用标准化参数。比如有 39 个命令具有 ComputerName 参数。 没有任何 cmdlet 具有 Computer、ServerName、Host 或 Machine 这样的参数 。

# 添加 CmdletBinding 会自动添加通用参数。 CmdletBinding 需要一个 param 块，但 param 块可以为空。
function Test-MrCmdletBinding {

    [CmdletBinding()] #<<-- This turns a regular function into an advanced function
    param (
        $ComputerName
    )

    Write-Output $ComputerName

}

Get-Command -Name Test-MrCmdletBinding -Syntax

# SupportsShouldProcess 会添加 WhatIf 和 Confirm 参数 。 只有做出更改的命令需要这些参数。
function Test-MrSupportsShouldProcess {

    [CmdletBinding(SupportsShouldProcess)]
    param (
        $ComputerName
    )

    Write-Output $ComputerName

}

Get-Command -Name Test-MrSupportsShouldProcess -Syntax

function Test-MrParameterValidation {

    [CmdletBinding()]
    param (
        [string]$ComputerName
    )

    Write-Output $ComputerName

}

# 指定了 String 作为 ComputerName 参数的数据类型 。 这将导致它只允许指定一个计算机名。
# 如果通过以逗号分隔的列表指定了多个计算机名，则会生成错误。
Test-MrParameterValidation -ComputerName Server01, Server02

# ComputerName 是必需的，如果未指定，该函数将提示输入名称。
function Test-MrParameterValidation {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$ComputerName
    )

    Write-Output $ComputerName

}

# 允许 ComputerName 参数具有多个值
function Test-MrParameterValidation {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string[]]$ComputerName
    )

    Write-Output $ComputerName

}

# 为 ComputerName 参数指定一个默认值（如果未指定）
# 默认值不能与必需参数一起使用。 需要将 ValidateNotNullOrEmpty 参数验证属性与默认值一起使用。
function Test-MrParameterValidation {

    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        [string[]]$ComputerName = $env:COMPUTERNAME
    )

    foreach ($Computer in $ComputerName) {
        #Attempting to perform some action on $Computer <<-- Don't use
        #inline comments like this, use write verbose instead.
        # 一种更好的选择是使用 Write-Verbose 而不是内联注释。
        Write-Verbose -Message "Attempting to perform some action on $Computer"
        Write-Output $Computer
    }

}

Test-MrVerboseOutput -ComputerName Server01, Server02 -Verbose # 通过 Verbose 参数调用函数时，会显示详细输出。

# 管道输入
# 管道输入一次输入一个项，这类似于在 foreach 循环中处理项的方式。 如果要接受数组作为输入，则至少需要一个 process 块才能处理所有项。 如果只接受单个值作为输入，则不需要 process 块，但仍建议指定它以保持一致性。
function Test-MrPipelineInput {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipeline)]
        [string[]]$ComputerName
    )

    PROCESS {
        Write-Output $ComputerName
    }

}

# 接受按属性名称显示的管道输入是类似的，但它是使用 ValueFromPipelineByPropertyName 参数属性指定的，并且可为任意数量的参数指定该输入，无需考虑数据类型。 
# 关键在于，通过管道传送的命令输出必须具有与参数名称或函数的参数别名匹配的属性名称。
function Test-MrErrorHandling {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipeline,
                   ValueFromPipelineByPropertyName)]
        [string[]]$ComputerName
    )

    PROCESS {
        foreach ($Computer in $ComputerName) {
            try {
                Test-WSMan -ComputerName $Computer
            }
            catch {
                Write-Warning -Message "Unable to connect to Computer: $Computer"
            }
        }
    }

}

# 将 ErrorAction 参数的值指定为 Stop，将非终止错误转换为终止错误 。
function Test-MrErrorHandling {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipeline,
                   ValueFromPipelineByPropertyName)]
        [string[]]$ComputerName
    )

    PROCESS {
        foreach ($Computer in $ComputerName) {
            try {
                Test-WSMan -ComputerName $Computer -ErrorAction Stop
            }
            catch {
                Write-Warning -Message "Unable to connect to Computer: $Computer"
            }
        }
    }

}

# 函数注释
function Get-MrAutoStoppedService {

<#
.SYNOPSIS
    Returns a list of services that are set to start automatically, are not
    currently running, excluding the services that are set to delayed start.

.DESCRIPTION
    Get-MrAutoStoppedService is a function that returns a list of services from
    the specified remote computer(s) that are set to start automatically, are not
    currently running, and it excludes the services that are set to start automatically
    with a delayed startup.

.PARAMETER ComputerName
    The remote computer(s) to check the status of the services on.

.PARAMETER Credential
    Specifies a user account that has permission to perform this action. The default
    is the current user.

.EXAMPLE
     Get-MrAutoStoppedService -ComputerName 'Server1', 'Server2'

.EXAMPLE
     'Server1', 'Server2' | Get-MrAutoStoppedService

.EXAMPLE
     Get-MrAutoStoppedService -ComputerName 'Server1' -Credential (Get-Credential)

.INPUTS
    String

.OUTPUTS
    PSCustomObject

.NOTES
    Author:  Mike F Robbins
    Website: http://mikefrobbins.com
    Twitter: @mikefrobbins
#>

    [CmdletBinding()]
    param (

    )

    #Function Body

}
```

#### 脚本模块
PowerShell 中的脚本模块只是一个文件，其中包含一个或多个保存为 .PSM1 文件而不是 .PS1 文件的函数。

所有模块都应该有一个模块清单。 模块清单包含有关模块的元数据。 模块清单文件的文件扩展名是 .PSD1。 并非所有扩展名为 .PSD1 的文件都是模块清单。 它们还可用于存储 DSC 配置的环境部分等用途。

```powershell
help New-Module # 在内存中创建动态模块，而不是脚本模块

# 查看自动加载模块的路径
$env:PSModulePath
$env:PSModulePath -split ';'

# New-ModuleManifest 用于创建模块清单。 Path 是所需的唯一值。但是，如果未指定 RootModule，则该模块将不起作用。 
# 如果决定使用 PowerShellGet 将模块上传到 NuGet 存储库，最好指定 Author 和 Description，因为该情况需要这些值 。
New-ModuleManifest -Path $env:ProgramFiles\WindowsPowerShell\Modules\MyScriptModule\MyScriptModule.psd1 -RootModule MyScriptModule -Author 'Mike F Robbins' -Description 'MyScriptModule' -CompanyName 'mikefrobbins.com'

Get-Module -Name MyScriptModule # 不带清单的模块版本为 0.0。 模块没有清单是一个致命的漏洞。
```

只有 Get-MrPSVersion 函数可供模块的用户使用，但 Get-MrComputerName 函数可供模块本身包含的其他函数使用。
```powershell
function Get-MrPSVersion {
    $PSVersionTable
}

function Get-MrComputerName {
    $env:COMPUTERNAME
}

Export-ModuleMember -Function Get-MrPSVersion
```

### 最佳实践
```powershell
Get-Verb
# 运行此命令时，将返回大多数命令遵循的谓词的列表。
# 此外，响应还会说明这些谓词执行哪些操作。 
# 由于大多数命令都遵循这种命名方式，因此，它设置了命令的预期操作，这样有助于你选择适当的命令，也可帮助你在创建命令时为其命名。

Get-Command
# 此命令会检索计算机上安装的所有命令的列表。

Get-Command -Name '*Process' # 根据名称筛选
Get-Command -Verb 'Get'
Get-Command -Noun U*
Get-Command -Verb Get -Noun U* # 根据名词和谓词进行筛选

Get-Command -ParameterType Process # 根据类型筛选

Get-Member
# 它在基于对象的输出上运行，并且能够发现可用于命令的对象、属性和方法。

Get-Process | Get-Member
Get-Process | Get-Member -MemberType Method
Get-Process | Get-Member | Select-Object Name, Definition
Get-Process | Get-Member | Select-Object TypeName -Unique

Get-Help
# 以命令名称为参数调用此命令，将显示一个帮助页面，其中说明了命令的各个部分。

Get-Command | Select-Object -First 3
Get-Process | Where-Object {$_.ProcessName -Like "p*"}

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





