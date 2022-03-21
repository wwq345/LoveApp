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



## Future Function4  version1

### 1.Function

1. 还是去做登陆，已经做好了loginview
2. 解决了textfield的问题
3. 解决navigationBar跳转的问题

### 2.Bug

1. navigationBar跳转的问题

   > 是共用一个视图，所以你刷新自然就会回到初始界面，当前页面是不可以，emm重新构建，就是emm you got it，

2. LoginView为什么最下面的button会被键盘顶上去，按照教程做的效果也不一样，目前采用的是disable see的形式，之后需要改进

3. 为什么点击头像，滑下去或者点击其他的取消之后，会被取消登陆状态？？

   > 这个视图更新机制的问题，还是说这个environmentobject每次都传入新的object的原因

### 3.question

1. LoginView，为什么这次，我在子视图中更改就不行了呢？明明刚才那个视图还好好的。（好吧是我自己少弄了一个state）



## Future Function 4 version 2.1

### 1.function

1. 解决了4.1的bug的视图更新的问题，而且run也没问题

   > 使用了stateobject，而不是environmentobject，这个environment会有生成时间的问题？（大概），state这个会存到一个更emmm持久的地方（SwiftUI framework internal memory）？明显在我做的时候，state的不会随着视图刷新被丢弃，enironment就会，这部分到底谁更持久有待讨论，不然的话就会出现，当你去加载子视图，然后在回来的时候，原来的view已经销毁，数据被丢弃了，所以就会回到未登录的状态，version1.1应该还没有解决这个问题，可以试着看看
   >
   > 其实，如果从根的角度来讲的话，就不应该把根上的数据定义为environment，只有子视图应该定义为environment吧
   >
   > error： Thread 1: Fatal error: No observable object of type 

2. 做持久化，登陆等搭好服务器继续

2. text后面可以text1，text2之类的

### 2.Bug

1. 其他的4.1bug继续

2. homeview的那个work什么怎么没了？

   > Simulator 开启的是dark mode，字体默认为白色，就透明看不到了，应该是这样的，后面改了文字颜色就好了

3. The layer is using dynamic shadows which are expensive to render. If possible try setting `shadowPath`, or pre-rendering the shadow into an image and putting it under the layer. This is a runtime bug?

   > 莫名出现莫名消失



## Future Function 5  - version2.2

### 1.Function

1. 几乎解决了之前的bug（好吧其实是我放弃了之前的做法，emmm解决一个就不能解决第二个）
2. 之后的话，就可以加入收藏这些小功能
3. 继续调整一下视图
4. topBar的那个隐藏

### 2.Bug

1. CourseDetail上面的布局的问题，会挡住他的topbar的的返回的地方，应该解决一下



## FutureFunction 6   -version3 

### 1.Function

1. 可喜可贺，几乎解决了比较重大的bug，前面提到的问题基本都解决了
2. 重新书写的tabBar还是不完美不过，可以调整
3. 剩下的就是一些预想功能的实现，比如收藏列表啊，还有识别的那个button可以想办法插进去，可能是教程之后会做的事情
3. 退出app之后也可以保存登陆状态

### 2.Bug

1. Course在展开跳转到新的页面之后，button点击不能改变state

   > 前面有个view给挡住了，我说呢，为啥子点不了，但是我找不到那个view啊
   >
   > 这个view好像是在生成这个视图的时候出现的
   >
   > 为什么会Copy我的最上面的一层视图啊？不理解

2. topbar点击回来的时候为什么登陆了还会有提醒登陆的alert，关键是我根本没有点击啊

   > 没找出原因为什么，但是不绑定就好了

3. updateView点击的时候

   > 会出一个提示log：**Unable to simultaneously satisfy constraints**-->这个好像是navigationbartitle的问题，具体原因得问hansi哥了



## Future Function6 -version 4

### 1.Function

1. Login 和 register的功能，emmm感觉如同胡乱在写一

   > 可能就是胡乱写的

2. 对应的user有对应的头像和name

3. 对应的user有不同的course，update，和不同的detail
