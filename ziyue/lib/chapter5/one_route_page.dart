import 'package:flutter/material.dart';

class OneRoutePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OneRoutePageState();
  }
}

class OneRoutePageState extends State<OneRoutePage> {
  int _selectIndex = 1; //维护底部导航的索引
  // 定义一个Controller，用于TabBar
  TabController _tabController;
  List tabs = ["关注", "推荐", "热点", "国际", "美食"];

  @override
  void initState() {
    super.initState();
//    _tabController = TabController(length: tabs.length, vsync: this);
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
            onPressed: () {},
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
      ),
      drawer: MyDrawer(), //抽屉菜单
      bottomNavigationBar: BottomNavigationBar(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  void _onItemTaped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer();
  }
}
