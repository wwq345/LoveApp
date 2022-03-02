# Future Function

### 1.DateCoureListView

#### 1.function

1. 应该有一个data，然后里面可以自由更改这个showAllScreen，image，text，然后之后点击的时候就不是更改binding了，因为showAllScreen是一个卡片属性，所以就直接改卡片的属性就ok
2. 学习了多少，我们可以按照ischeck / count来确定，甚至可以当用户浏览few seconds自动checked

#### 2.bug

1. 不知道为啥animation没有用





## Future Function 2

### 1.function

1. 实现了1.1，解决了1的bug
2. 希望实现这个view的固定长宽比，实现跨设备的视图良好
2. contentful，这功能挺鸡肋的感觉，好像意思就是说我不用去自己在文件里面写存储，放到这个地方来存，我觉得duck不必

### 2.bug

1. 当你在scrollerview的时候，会发现在fullScreen的条件下会仍然可以ScrollerView，文本的scrollerview会和屏幕的scrollerview同时生效

   > 解决方案预计是加入一个fullScreen的状态，但是，如何更改这个fullScreen的状态，其实应该是遍历这个list里面所有的showAllScreen，而且第二个问题就是说如何allScreen我想展示的那一个card



## Future Function3

### 1.function

1. 解决了2.1的bug，用函数解决的（我是真的c）
2. 与数据库联系，可以自己做一个那种springboot + mybatis的一个东西去连接数据库读数据，毕竟就是访问url的过程
3. 实现登陆功能，基本的那种登陆吗，显示account，切换，记录头像（这种估计要数据库联系）



### 2.bug

1. animation still doesn't work

   > 我觉得可能就是因为当我禁用这个之后，其实本身只是展示，自然就没有动画的change了，因为相当于是我一个页面上展示了两个页面，但是我仍旧是一个页面（展示两种状态，而状态是静态的），所以这个bug就没办法，除非我换一种做法，不在本页面上

2. LoginView,我的textField字体没有啊

3. TopBar切换到CardView之后，点击展开居然会跳回去？为什么？再次点击才会变，而且topbar不消失

2. 我的textfield为什么会默认有一个字符的占位符



## Future Function4

### 1.Function

1. 还是去做登陆，已经做好了loginview
2. 解决了textfield的问题
3. 解决navigationBar跳转的问题

### 2.Bug

1. navigationBar跳转的问题

2. LoginView为什么最下面的button会被键盘顶上去，按照教程做的效果也不一样，目前采用的是disable see的形式，之后需要改进

3. 为什么点击头像，滑下去或者点击其他的取消之后，会被取消登陆状态？？

   > 这个视图更新机制的问题，还是说这个environmentobject每次都传入新的object的原因

### 3.question

1. LoginView，为什么这次，我在子视图中更改就不行了呢？明明刚才那个视图还好好的。（好吧是我自己少弄了一个state）
