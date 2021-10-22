







传递函数作为后代
false,null,undefined和true都是合理的后代。但是通常他们不会被渲染。需要注意的是，0不是false。




当ref属性用在通过类定义的组件里的时候，ref获取到的是加载的类组件。
在函数定义的组件中是不可以使用ref的，因为它不具有实例。

使用ref回调是操作DOM的一种固定模式。可以简写为ref={input => this.textInput = input}。

遗留的API：字符串Refs
以前的版本中可以通过this.refs.textInput来引用，但是这会引起问题。这个api将来会在某个版本移除，所以应该用回调的模式使用ref。



  

  
避免视图刷新    复写生命周期方法shouldComponentUpdate
shouldComponentUpdate(nextProps, nextState) {
  return true;
}
大多数情况下，就使用React.PureComponent就可以了，不用自己实现shouldComponentUpdate。
浅对比(shallow comparsion)
setState() 或者 props 变动时 影响的组件要尽量少    封装那些props和state不会变化的嵌套组件
列表组件 list 或者 ul li React通过比较key来决定是否更新列表。

diff 
获取到两个 dom 树之后，React首先会比较两个根元素。
如果根元素类型不一样，React会重新渲染整个树。旧根元素下的所有组件会卸载，状态会销毁。
如果根元素类型一样，React会查看元素的所有属性，保留相同的，更新变化的。此时，React会同时遍历新旧根元素的子组件



当组件更新的时候，并不重新创建新的元素。所以组件的状态都会保持。React直接更新组件的Props，而不会去比较它。组件回调componentWillReceiveProps()和componentWillUpdate()方法。接着，回调render()函数，然后再对比组件中的差异。






使用不可变的数据结构
Immutable.js是另外一种解决问题的方法。它通过结构分享，提供了永久的，不可变的集合。








汇集React Native学习资料、工具、组件、开源App、以及相关新闻等。
http://www.awesome-react-native.com/
https://github.com/jondot/awesome-react-native

贾鹏辉的学习资源精选仓库
https://github.com/crazycodeboy/react-native-awesome
http://www.devio.org/tags/#React Native


https://github.com/react-native-training/react-native-elements
https://github.com/GeekyAnts/NativeBase


