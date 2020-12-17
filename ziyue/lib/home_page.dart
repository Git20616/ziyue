import 'package:flutter/material.dart';
import 'package:ziyue/routes/preference_page.dart';

import 'intermediate_page.dart';
import 'primary_page.dart';
import 'senior_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    setState(() {
      _currentIndex = ++_currentIndex % 3;
    });
  }

  List<BottomNavigationBarItem> _bottomNavItems(BuildContext context) {
    Color _color = Theme.of(context).primaryColor;
    List<BottomNavigationBarItem> _bottomNavItems = [
      BottomNavigationBarItem(
        backgroundColor: _color,
        icon: Icon(Icons.book),
        title: Text("入门"),
      ),
      BottomNavigationBarItem(
        backgroundColor: _color,
        icon: Icon(Icons.apps),
        title: Text("进阶"),
      ),
      BottomNavigationBarItem(
        backgroundColor: _color,
        icon: Icon(Icons.blur_linear),
        title: Text("实战"),
      ),
    ];
    return  _bottomNavItems;
  }

  int _currentIndex;
  final _pages = [PrimaryPage(), IntermediatePage(), SeniorPage()];
  final _title = ["入门篇", "进阶篇", "实战篇"];

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  void _changePage(int index) {
    if(index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title[_currentIndex],),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PreferencePage()));
            },
          ),
        ],
        leading: null,
      ),
      body: _pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ), // This trailing comma makes auto-formatting nicer for build methods.
      persistentFooterButtons: <Widget>[
        RaisedButton(
          onPressed: () {},
          child: Text("底部1"),
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
        ),
        RaisedButton(
          onPressed: () {},
          child: Text("底部2"),
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
        ),
      ],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavItems(context),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        onTap: (index) {
          _changePage(index);
        },
      ),

    );
  }
}
