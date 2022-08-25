## ECMAScript

ECMAScript 是一种由Ecma国际（前身为欧洲计算机制造商协会，European Computer Manufacturers Association）通过 ECMA-262 标准化的脚本程序设计语言。

### 概述

#### 起源

- 1997年06月，ECMAScript 1.0版发布。
- 1998年6月，ECMAScript 2.0版发布。
    格式修正，以使得其形式与ISO/IEC16262国际标准一致。
- 1999年12月，ECMAScript 3.0版发布，成为JavaScript的通行标准，得到了广泛支持。
    + 强大的正则表达式，更好的文字链处理，新的控制指令，异常处理，错误定义更加明确，数输出的格式化及其它改变。
- 2007年10月，ECMAScript 4.0版草案发布，对3.0版做了大幅升级，预计次年8月发布正式版本。
    + 草案发布后，由于4.0版的目标过于激进，各方对于是否通过这个标准，发生了严重分歧。反对JavaScript的大幅升级，主张小幅改动。
- 2008年7月，ECMA开会决定，中止ECMAScript 4.0的开发，将其中涉及现有功能改善的一小部分，发布为ECMAScript 3.1，而将其他激进的设想扩大范围，放入以后的版本。该版本的项目代号起名为Harmony（和谐）。会后不久，ECMAScript 3.1就改名为ECMAScript 5。
- 2009年12月，ECMAScript 5.0版正式发布。
    + 添加 "strict mode"（严格模式），添加 JSON 支持。
    + Harmony项目则一分为二，一些较为可行的设想定名为JavaScript.next继续开发，后来演变成ECMAScript 6；一些不是很成熟的设想，则被视为JavaScript.next.next，在更远的将来再考虑推出。
- 2011年6月，ECMAscript 5.1版发布，并且成为ISO国际标准（ISO/IEC 16262:2011）。
- 2013年3月，ECMAScript 6草案冻结，不再添加新功能。新的功能设想将被放到ECMAScript 7。
- 2013年12月，ECMAScript 6草案发布。然后是12个月的讨论期，听取各方反馈。
- 2015年6月17日，ECMAScript 6发布正式版本，即ECMAScript 2015。
    + 添加类和模块
- 2016 ECMAScript 7发布正式版本，即ECMAScript 2016。
    + 增加指数运算符`**`，增加 Array.prototype.includes
- 2016 ECMAScript 8发布正式版本，即ECMAScript 2017。
    + Object.values/Object.entries、字符串填充、Object.getOwnPropertyDescriptor、尾随逗号、异步函数、共享内存和原子等。
- 2016 ECMAScript 9发布正式版本，即ECMAScript 2018。


### ECMAScript 5


Object/array literal extensions:
    Getter accessorsc
    Setter accessorsc
    Trailing commas in object literalsc
    Trailing commas in array literalsc
    Reserved words as property names

Object static methods
    Object.create
    Object.defineProperty
    Object.defineProperties
    Object.getPrototypeOf
    Object.keys
    Object.seal
    Object.freeze
    Object.preventExtensions
    Object.isSealed
    Object.isFrozen
    Object.isExtensible
    Object.getOwnPropertyDescriptor
    Object.getOwnPropertyNames

Array methods
    Array.isArray
    Array.prototype.indexOf
    Array.prototype.lastIndexOf
    Array.prototype.every
    Array.prototype.some
    Array.prototype.forEach
    Array.prototype.map
    Array.prototype.filter
    Array.prototype.reduce
    Array.prototype.reduceRight
    Array.prototype.sort: compareFn must be function or undefined
    Array.prototype.sort: compareFn may be explicit undefined

String properties and methods
    Property access on strings
    String.prototype.trim

Date methods
    Date.prototype.toISOString
    Date.now
    Date.prototype.toJSON

Function.prototype.bind
JSON

Immutable globals
    undefined
    NaN
    Infinity

Miscellaneous
    Function.prototype.apply permits array-likes
    parseInt ignores leading zeros
    Function "prototype" property is non-enumerable
    Arguments toStringTag is "Arguments"
    Zero-width chars in identifiers
    Unreserved words
    Enumerable properties can be shadowed by non-enumerables
    Thrown functions have proper "this" values

Strict mode
    reserved words
    "this" is undefined in functions
    "this" is not coerced to object in primitive methods
    "this" is not coerced to object in primitive accessors
    legacy octal is a SyntaxError
    assignment to unresolvable identifiers is a ReferenceError
    assignment to eval or arguments is a SyntaxError
    assignment to non-writable properties is a TypeError
    eval or arguments bindings is a SyntaxError
    arguments.caller removed or is a TypeError
    arguments.callee is a TypeError
    (function(){}).caller and (function(){}).arguments is a TypeError
    arguments is unmapped
    eval() can't create bindings
    deleting bindings is a SyntaxError
    deleting non-configurable properties is a TypeError
    "with" is a SyntaxError
    repeated parameter names is a SyntaxError
    function expressions with matching name and argument are valid

"use strict" 指令
它不是一条语句，但是是一个字面量表达式，在 JavaScript 旧版本中会被忽略。
目的是指定代码在严格条件下执行。严格模式下你不能使用未声明的变量。






### ECMAScript 6(2015)

Optimisation
    proper tail calls (tail call optimisation)
Syntax
    default function parameters
    rest parameters
    spread syntax for iterable objects
    object literal extensions
    for..of loops
    octal and binary literals
    template literals
    RegExp "y" and "u" flags
    destructuring, declarations
    destructuring, assignment
    destructuring, parameters
    Unicode code point escapes
    new.target
Bindings
    const
    let
    block-level function declaration
Functions
    arrow functions
    class
    super
    generators
Built-ins
    typed arrays
    Map
    Set
    WeakMap
    WeakSet
    Proxy
    Reflect
    Promise
    Symbol
    well-known symbols
Built-in extensions
    Object static methods
    function "name" property
    String static methods
    String.prototype methods
    RegExp.prototype properties
    Array static methods
    Array.prototype methods
    Number properties
    Math methods
    Date.prototype[Symbol.toPrimitive]
Subclassing
    Array is subclassable
    RegExp is subclassable
    Function is subclassable
    Promise is subclassable
    miscellaneous subclassables
Misc
    prototype of bound functions
    Proxy, internal 'get' calls
    Proxy, internal 'set' calls
    Proxy, internal 'defineProperty' calls
    Proxy, internal 'deleteProperty' calls
    Proxy, internal 'getOwnPropertyDescriptor' calls
    Proxy, internal 'ownKeys' calls
    Object static methods accept primitives
    own property order
    Updated identifier syntax
    miscellaneous
Annex b
    non-strict function semantics
    `__proto__` in object literals
    `Object.prototype.__proto__`
    String.prototype HTML methods
    RegExp.prototype.compile
    RegExp syntax extensions
    HTML-style comments



### ECMAScript 2016

Features
    exponentiation (`**`) operator
    `Array.prototype.includes`

misc
    generator functions can't be used with "new"
    generator throw() caught by inner generator
    strict fn w/ non-strict non-simple params is error
    nested rest destructuring, declarations
    nested rest destructuring, parameters
    Proxy, "enumerate" handler removed
    Proxy internal calls, Array.prototype.includes


### ECMAScript 2017

Features
    Object static methods
    String padding
    trailing commas in function syntax
    async functions
    shared memory and atomics

misc
    RegExp "u" flag, case folding
    arguments.caller removed

annex b
    Object.prototype getter/setter methods
    Proxy internal calls, getter/setter methods
    assignments allowed in for-in head in non-strict mode


### ECMAScript 2018

Features
    object rest/spread properties
    Promise.prototype.finally
    s (dotAll) flag for regular expressions
    RegExp named capture groups
    RegExp Lookbehind Assertions
    RegExp Unicode Property Escapes
    Asynchronous Iterators
misc
    Proxy "ownKeys" handler, duplicate keys for non-extensible targets
    template literal revision


### ECMAScript 2019

Features
    Object.fromEntries
    string trimming
    Array.prototype.{flat, flatMap}
misc
    optional catch binding
    Symbol.prototype.description
    Function.prototype.toString revision
    JSON superset
    Well-formed JSON.stringify


### ECMAScript 2020

Features
    String.prototype.matchAll
    BigInt
    Promise.allSettled
    globalThis
    optional chaining operator
    nullish coalescing operator


### ECMAScript next

Candidate (stage 3)
    WeakReferences
    instance class fields
    static class fields
    private class methods
    numeric separators
    String.prototype.replaceAll
    Promise.any
    Legacy RegExp features in JavaScript
    Logical Assignment

Draft (stage 2)
    Generator function.sent Meta Property
    Class and Property Decorators
    Realms
    throw expressions
    Set methods
    ArrayBuffer.prototype.transfer
    Map.prototype.upsert
    Array.isTemplateObject
    Iterator Helpers

Proposal (stage 1)
    do expressionsc
    Observable
    Frozen Realms API
    Math.signbit
    Math extensions proposal
    Promise.try
    `.of` and `.from` on collection constructors
    the pipeline operator
    extensible numeric literals
    partial application syntax
    Object.freeze and Object.seal syntax
    String.prototype.codePoints
    Getting last item from array
    Collections methods
    Math.seededPRNG
    { BigInt, Number }.fromString
    Object iteration

Strawman (stage 0)
    bind (::) operator
    String.prototype.at
    additional meta properties
    method parameter decorators
    function expression decorators
    Reflect.isCallable / Reflect.isConstructor
    zones
    syntactic tail calls
    object shorthand improvements

Pre-strawman
    Metadata reflection API


### ECMAScript intl

Intl object
Intl.Collator
Intl.Collator.prototype.compare
Intl.Collator.prototype.resolvedOptions
NumberFormat
DateTimeFormat
String.prototype.localeCompare
Number.prototype.toLocaleString
Array.prototype.toLocaleString
Object.prototype.toLocaleString
Date.prototype.toLocaleString
Date.prototype.toLocaleDateString
Date.prototype.toLocaleTimeString


### ECMAScript non-standard

SIMD (Single Instruction, Multiple Data)

decompilation
optional "scope" argument of "eval"

function "caller" property
function "arity" property
function "arguments" property
Function.prototype.isGenerator

class extends null
`__count__`
`__parent__`
`__noSuchMethod__`
Array generics
String generics

Array comprehensions (JS 1.8 style)
Array comprehensions (ES draft style)
Expression closures
ECMAScript for XML (E4X)
"for each..in" loops
Sharp variables

Iterator
`__iterator__`
Generators (JS 1.8)
Generator comprehensions (JS 1.8 style)
Generator comprehensions (ES draft style)

RegExp "x" flag
Callable RegExp
RegExp named groups

String.prototype.quote
String.prototype.replace flags

Date.prototype.toLocaleFormat
Date.parse produces NaN for invalid dates

Object.prototype.watch
Object.prototype.unwatch
Object.prototype.eval
Object.observe

error "stack"
error "lineNumber"
error "columnNumber"
error "fileName"
error "description"

global

Proxy "ownKeys" handler, duplicate keys for non-extensible targets (ES 2017 semantics)


参考文档
<https://github.com/mdn/browser-compat-data>
<https://caniuse.com>
<http://kangax.github.io/compat-table/es6/>


