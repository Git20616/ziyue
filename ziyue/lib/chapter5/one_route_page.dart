import 'package:flutter/material.dart';

class OneRoutePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OneRoutePageState();
  }
}

class OneRoutePageState extends State<OneRoutePage>
    with SingleTickerProviderStateMixin {
  int _selectIndex = 1; //维护底部导航的索引
  // 定义一个Controller，用于TabBar
  TabController _tabController;
  List tabs = ["关注", "推荐", "热点", "国际", "美食"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      print("controller index is ${_tabController.index}");
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("App Name"),
        actions: <Widget>[
          //导航栏右侧菜单
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        // 如果给Scaffold添加了抽屉菜单，默认情况下Scaffold会自动将AppBar的leading设置为菜单按钮，点击它便可打开抽屉菜单。
        // 下边我们手动设置按钮
        leading: Builder(
          builder: (context) {
            return UnconstrainedBox(
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: CircleAvatar(
                  backgroundImage: AssetImage("images/avatar.jpg"),
                  child: FlatButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer(); //打开抽屉菜单
                    },
                    child: null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        bottom: TabBar(
          // 通过controller监听tab菜单的切换，从而切换tab页面
          // 手动实现tab页面滑动切换，需要在滑动过程中更新TabBar指示器的偏移
          // Material库提供了一个TabBarView组件，可以轻松实现tab页面滑动切换
          // Material组件库也提供了一个PageView 组件，它和TabBarView功能相似
          controller: _tabController,
          tabs: tabs
              .map((item) => Tab(
                    text: item,
                  ))
              .toList(),
        ),
      ),
      drawer: MyDrawer(), //drawer左抽屉菜单，endDrawer右抽屉菜单
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((item) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              item,
              textScaleFactor: 3.0,
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: _getBottomAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onItemTaped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  // 可用于底部Tab导航栏的组件对象
  BottomNavigationBar _getBottomNavBar() => BottomNavigationBar(
    //底部导航
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text("Home"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.business),
        title: Text("Business"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.school),
        title: Text("School"),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          IconData(
            0xe626,
            fontFamily: "IconFont",
          ),
        ),
        title: Text("Travel"),
      ),
    ],
    currentIndex: _selectIndex,
    onTap: _onItemTaped,
    type: BottomNavigationBarType.fixed,
    fixedColor: Colors.white,
    backgroundColor: Colors.blue,
    showUnselectedLabels: true, //未选中时，是否显示文字
  );

  // BottomAppBar 组件，它可以和FloatingActionButton配合实现“打洞”效果
  // 需要自己实现切换效果
  BottomAppBar _getBottomAppBar() => BottomAppBar(
    color: Colors.white,
    shape: CircularNotchedRectangle(), //底部导航栏打一个圆形的洞
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround, //均分导航栏横向空间
      children: <Widget>[
        IconButton(icon: Icon(Icons.home), onPressed: () {},),
        SizedBox(), //中间位置空出
        IconButton(icon: Icon(Icons.business), onPressed: () {},),
      ],
    ),
  );

}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: MediaQuery.removePadding( //移除容器内部补白
        context: context,
        removeTop: true, //移除抽屉菜单顶部的默认留白
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval( //子组件为正方形时剪裁为内贴圆形，为矩形时，剪裁为内贴椭圆
                      child: Image.asset(
                        "images/avatar.jpg",
                        width: 80.0,
                      ),
                    ),
                  ),
                  Text(
                    "放牛娃",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.add),
                    title: Text("Add Account"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Manage accounts"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
