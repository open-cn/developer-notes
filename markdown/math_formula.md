## Math Formula
数学公式

### Latex 语法
- 指数和下标可以用^和_后加相应字符来实现。
- 平方根（square root）的输入命令为：\sqrt，n 次方根相应地为: \sqrt[n]。方根符号的大小由LATEX自动加以调整。也可用\surd 仅给出符号。
- 命令\overline 和\underline 在表达式的上、下方画出水平线。
- 命令\overbrace 和\underbrace 在表达式的上、下方给出一水平的大括号。
- 向量（Vectors）通常用上方有小箭头（arrow symbols）的变量表示。这可由\vec 得到。另两个命令\overrightarrow 和\overleftarrow在定义从A 到B 的向量时非常有用。
- 分数（fraction）使用\frac{...}{...} 排版。一般来说，1/2 这种形式更受欢迎，因为对于少量的分式，它看起来更好些。
- 积分运算符（integral operator）用\int 来生成。求和运算符（sum operator）由\sum 生成。乘积运算符（product operator）由\prod 生成。上限和下限用^ 和_来生成，类似于上标和下标。
- {ccc}是指元素的对齐方法（居中），此外还有l和r的参数可选，分别表示左和右。
- \hline表示水平线，而竖线可以使用|来表示。
- 横排列的点 ⋯ 用`\cdots`表示，列排列的点 ⋮ 用`\vdots`表示，斜排列的点 ⋱ 用`\ddots`表示。
- \big，\Big，\bigg，\Bigg。按着顺序，它们控制的括号不断变大；\left放在左边括号前面，\right放在右边括号前面，它们能自动控制不同层次括号的大小。


#### 矩阵写法
从本质上来说，array是将一些事物对齐显示的阵列，所以也可以对齐其他数学对象。

##### 矩阵转置符号
```
A^T
A^\mathrm{T}
A^\mathsf{T}
A^\top
A^\intercal
A^{^T}
A^{\scriptscriptstyle T}
```

##### 复杂写法
```
\begin{array}{ccc}
    1 & 0 & 0\\\\
    0 & 1 & 0\\\\
    0 & 0 & 1\\\\
\end{array}
```
在latex中，如果想给这种形式的矩阵加一个()或者[]，并不能直接往代码里添加个()或者[]，毕竟矩阵太大。通常来说，要使用像\left(和\right)来表示。当然()也可以换成[]，甚至是||，不过第三个代表的已经不是矩阵了，而是一个行列式。
```
\left[
    \begin{array}{ccc}
        1 & 0 & 0\\\\
        0 & 1 & 0\\\\
        0 & 0 & 1\\\\
    \end{array}
\right]
```

##### 简化写法
latex中，有一些专门的参数可以生成矩阵，像pmatrix(带()的矩阵)、bmatrix(带[]的矩阵)、vmatrix(行列式)
```
<!--带`()`的矩阵-->
\begin{pmatrix}
    1 & 0 & 0\\\\
    0 & 1 & 0\\\\
    0 & 0 & 1\\\\
\end{pmatrix}

<!--带`[]`的矩阵-->
\begin{bmatrix}
    1 & 0 & 0\\\\
    0 & 1 & 0\\\\
    0 & 0 & 1\\\\
\end{bmatrix}

<!--行列式-->
\begin{vmatrix}
    1 & 0 & 0\\\\
    0 & 1 & 0\\\\
    0 & 0 & 1\\\\
\end{vmatrix}
```

#### Latex 数学符号对应表
- 希腊字母
- 运算符符号
- 关系符号
- 箭头符号
- 括号符号
- 其他符号

##### 希腊字母
| 字母 | 实现        | 字母 | 实现     |
| ---- | ----------- | ---- | -------- |
| α    | \alpha      | A    | \Alpha   |
| β    | \beta       | B    | \Beta    |
| γ    | \gamma      | Γ    | \Gamma   |
| δ    | \delta      | Δ    | \Delta   |
| ϵ    | \epsilon    | E    | \Epsilon |
| ε    | \varepsilon |      |          |
| ζ    | \zeta       | Z    | \Zeta    |
| η    | \eta        | H    | \Eta     |
| θ    | \theta      | Θ    | \Theta   |
| ϑ    | \vartheta   |      |          |
| ι    | \iota       | I    | \Iota    |
| κ    | \kappa      | K    | \Kappa   |
| λ    | \lambda     | Λ    | \Lambda  |
| μ    | \mu         | M    | \Mu      |
| ν    | \nu         | N    | \Nu      |
| ξ    | \xi         | Ξ    | \Xi      |
| ο    | \omicron    | O    | \Omicron |
| π    | \pi         | Π    | \Pi      |
| ϖ    | \varpi      |      |          |
| ρ    | \rho        | P    | \Rho     |
| ϱ    | \varrho     |      |          |
| σ    | \sigma      | Σ    | \Sigma   |
| ς    | \varsigma   |      |          |
| τ    | \tau        | T    | \Tau     |
| υ    | \upsilon    | Υ    | \Upsilon |
| ϕ    | \phi        | Φ    | \Phi     |
| φ    | \varphi     |      |          |
| χ    | \chi        | X    | \Chi     |
| ψ    | \psi        | Ψ    | \Psi     |
| ω    | \omega      | Ω    | \Omega   |

var开头的只有小写希腊字母，没有大写。

##### 运算符符号
| 符号 | 实现             | 名称       |
| ---- | ---------------- | ---------- |
| ±    | \pm              | 加减       |
| ∓    | \mp              | 减加       |
| ×    | \times           | 乘         |
| ÷    | \div             | 除         |
| ⋅    | \cdot            | 点         |
| ∗    | \ast             | 星号       |
| ⋆    | \star            | 五角星     |
| †    | \dagger          | 剑号       |
| ‡    | \ddagger         | 双剑号     |
| ⨿    | \amalg           | amalg      |
| ∩    | \cap             | 圆帽       |
| ∪    | \cup             | 圆杯       |
| ⊎    | \uplus           | 圆杯加号   |
| ⊓    | \sqcap           | 方帽       |
| ⊔    | \sqcup           | 方杯       |
| ∨    | \vee             | 正V        |
| ∧    | \wedge           | 倒V        |
| ∖    | \setminus        | 集差       |
| ≀    | \wr              | 环积       |
| ∘    | \circ            | 圆圈       |
| ∙    | \bullet          | 实心圆     |
| ⊘    | \oslash          | 圆圈斜线   |
| ⊙    | \odot            | 圆圈点     |
| ◯    | \bigcirc         | 大圆圈     |
| △    | \bigtriangleup   | 大正三角形 |
| ▽    | \bigtriangledown | 大倒三角形 |
| ◃    | \triangleleft    | 左三角形   |
| ▹    | \triangleright   | 右三角形   |
| ⊕    | \oplus           | 圆圈加号   |
| ⊖    | \ominus          | 圆圈减号   |
| ⊗    | \otimes          | 圆圈乘号   |
| ⊥    | \bot             | 倒T        |
| ⊤    | \top             | 正T        |
| ∑    | \sum             | 求和       |
| ∏    | \prod            | 乘积       |
| ∫    | \int             | 积分       |
| ∮    | \oint            | 围道积分   |
| ⨄    | \biguplus        | 大圆杯加号 |
| ⨁    | \bigoplus        | 大圆圈加号 |
| ⋁    | \bigvee          | 大V        |
| ⋂    | \bigcap          | 大圆帽     |
| ⨂    | \bigotimes       | 大圆圈乘号 |
| ⋀    | \bigwedge        | 大倒V      |
| ⋃    | \bigcup          | 大圆杯     |
| ⨀    | \bigodot         | 大圆圈点   |
| ⨆    | \bigsqcup        | 大方杯     |

##### 关系符号
| 符号 | 实现          | 名称           |
| ---- | ------------- | -------------- |
| <    | <             | 小于           |
| >    | >             | 大于           |
| ≤    | \leq          | 小于等于       |
| ≥    | \geq          | 大于等于       |
| ≪    | \ll           | 远小于         |
| ≫    | \gg           | 远大于         |
| ≠    | \neq          | 不等于         |
| ≐    | \doteq        | 点等于         |
| ∼    | \sim          | 相似于         |
| ≃    | \simeq        | 近似等于       |
| ≈    | \approx       | 约等于         |
| ≍    | \asymp        | 趋于           |
| ≅    | \cong         | 全等于         |
| ≡    | \equiv        | 恒等于         |
| ⊂    | \subset       | 子集           |
| ⊃    | \supset       | 超集           |
| ⊆    | \subseteq     | 子集或等于     |
| ⊇    | \supseteq     | 超集或等于     |
| ⊑    | \sqsubseteq   | 方形子集或等于 |
| ⊒    | \sqsupseteq   | 方形超集或等于 |
| ∈    | \in           | 包含于         |
| ∋    | \ni           | 包含           |
| ∉    | \notin        | 不包含于       |
| ⊨    | \models       | Models         |
| ⊢    | \vdash        | 竖线短横       |
| ⊣    | \dashv        | 短横竖线       |
| ⊥    | \perp         | 垂直           |
| ∣    | \mid          | 中线           |
| ∥    | \parallel     | 平行           |
| ∝    | \propto       | 成比例         |
| ⋈    | \bowtie       | 领结           |
| ≺    | \prec         | 先于           |
| ⪯    | \preceq       | 先于等于       |
| ≻    | \succ         | 后于           |
| ⪰    | \succeq       | 后于等于       |
| ≮    | \nless        | 不小于         |
| ≯    | \ngtr         | 不大于         |
|     | \nleqslant    | 不小于等于     |
|     | \ngeqslant    | 不大于等于     |
| ≢    | \not\equiv    | 不恒等于       |
| ≉    | \not\approx   | 不约等于       |
| ≆    | \not\cong     | 不全等于       |
| ≁    | \not\sim      | 不相似于       |
| ≄    | \not\simeq    | 不近似等于     |
| ⊭    | \not\models   | Not Models     |
| ∌    | \not\ni       | 不包含         |
| ⊁    | \not\succ     | 不后于         |
| ⪰̸    | \not\succeq   | 不后于等于     |
| ⊀    | \not\prec     | 不先于         |
| ⪯̸    | \not\preceq   | 不先于等于     |
| ∦    | \not\parallel | 不平行         |
| ⊄    | \not\subset   | 非子集         |
| ⊅    | \not\supset   | 非超集         |
| ⊈    | \not\subseteq | 非子集或等于   |
| ⊉    | \not\supseteq | 非超集或等于   |

##### 箭头符号
| 符号 | 实现                | 名称               |
| ---- | ------------------- | ------------------ |
| ←    | \leftarrow          | 左箭头             |
| ⇐    | \Leftarrow          | 左双线箭头         |
| ⟵    | \longleftarrow      | 长左箭头           |
| ⟸    | \Longleftarrow      | 长双线左箭头       |
| →    | \rightarrow         | 右箭头             |
| ⇒    | \Rightarrow         | 右双线箭头         |
| ⟶    | \longrightarrow     | 长右箭头           |
| ⟹    | \Longrightarrow     | 长双线右箭头       |
| ↔    | \leftrightarrow     | 左右双向箭头       |
| ⇔    | \Leftrightarrow     | 左右双向双线箭头   |
| ⟷    | \longleftrightarrow | 长左右双向箭头     |
| ⟺    | \Longleftrightarrow | 长左右双向双线箭头 |
| ↩    | \hookleftarrow      | 弯钩左箭头         |
| ↪    | \hookrightarrow     | 弯钩右箭头         |
| ↽    | \leftharpoondown    | 下半钩左箭头       |
| ⇁    | \rightharpoondown   | 下半钩右箭头       |
| ↼    | \leftharpoonup      | 上半钩左箭头       |
| ⇀    | \rightharpoonup     | 上半钩右箭头       |
| ↑    | \uparrow            | 上箭头             |
| ⇑    | \Uparrow            | 上双线箭头         |
| ↓    | \downarrow          | 下箭头             |
| ⇓    | \Downarrow          | 下双线箭头         |
| ↕    | \updownarrow        | 上下双向箭头       |
| ⇕    | \Updownarrow        | 上下双向双线箭头   |
| ↙    | \swarrow            | 左斜下箭头         |
| ↗    | \nearrow            | 右斜上箭头         |
| ↖    | \nwarrow            | 左斜上箭头         |
| ↘    | \searrow            | 右斜下箭头         |
| ↦    | \mapsto             | 映射箭头           |
| ⟼    | \longmapsto         | 长映射箭头         |

##### 括号符号
| 符号 | 实现       | 名称         |
| ---- | ---------- | ------------ |
| {    | \lbrace    | 左花括号     |
| }    | \rbrace    | 右花括号     |
| [    | \lbrack    | 左方括号     |
| ]    | \rbrack    | 右方括号     |
| ⟨    | \langle    | 左尖括号     |
| ⟩    | \rangle    | 右尖括号     |
| ⌈    | \lceil     | 左上半框括号 |
| ⌉    | \rceil     | 右上半框括号 |
| ⌊    | \lfloor    | 左下半框括号 |
| ⌋    | \rfloor    | 右下半框括号 |
| \|   | \vert      | 竖线         |
| ∥    | \Vert      | 双竖线       |
| ∖    | \backslash | 反斜线       |

##### 其他符号
| 符号 | 实现      | 名称          |
| ---- | --------- | ------------- |
| ∞    | \infty    | 无穷          |
| ∃    | \exists   | 存在          |
| ∀    | \forall   | 任取          |
| ¬    | \neg      | 取反号        |
| ∇    | \nabla    | 劈形          |
| △    | \triangle | 三角形        |
| ∠    | \angle    | 角            |
| ∂    | \partial  | 偏导数        |
| ∅    | \emptyset | 空集          |
| ′    | \prime    | 质数          |
| :    | \colon    | 冒号          |
| ℜ    | \Re       | 实部          |
| I    | \Im       | 虚部          |
| …    | \ldots    | 下三连点      |
| ⋯    | \cdots    | 中三连点      |
| ⋮    | \vdots    | 竖三连点      |
| ⋱    | \ddots    | 斜三连点      |
| √    | \surd     | 不尽根号      |
| .    | \ldotp    | 句点          |
| →    | \to       | 结论          |
| ←    | \gets     | 条件          |
| ℵ    | \aleph    | Aleph         |
| ℏ    | \hbar     | 普朗克常数    |
| ℘    | \wp       | 手写体大写P   |
| ℓ    | \ell      | 手写体小写l   |
| ı    | \imath    | 数学小写无点i |
| ȷ    | \jmath    | 数学小写无点j |

### MATLAB
latex(S) returns the LaTeX form of the symbolic expression S.

```matlab
syms x phi
latex(x^2 + 1/x)
latex(sin(pi*x) + phi)

ans =
    '\frac{1}{x}+x^2'

ans =
    '\varphi +\sin\left(\pi \,x\right)'
```

LaTeX can also be used to Format Title, Axis Labels, and Ticks. See doc latex.

