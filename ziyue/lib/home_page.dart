import 'package:flutter/material.dart';

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
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _currentIndex = ++_currentIndex % 3;
    });
  }

  final List<BottomNavigationBarItem> _bottomNavItems = [
    BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(Icons.book),
      title: Text("入门"),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.green,
      icon: Icon(Icons.apps),
      title: Text("进阶"),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.red,
      icon: Icon(Icons.blur_linear),
      title: Text("实战"),
    ),
  ];

  int _currentIndex;
  final _pages = [PrimaryPage(), IntermediatePage(), SeniorPage()];
  final _colors = [Colors.blue, Colors.green, Colors.red];
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: _colors[_currentIndex],
      ),
      home: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(_title[_currentIndex]),
          backgroundColor: _colors[_currentIndex],
        ),
        body: _pages[_currentIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
          backgroundColor: _colors[_currentIndex],
        ), // This trailing comma makes auto-formatting nicer for build methods.
        persistentFooterButtons: <Widget>[
          RaisedButton(
            onPressed: () {},
            child: Text("底部1"),
            color: _colors[_currentIndex],
            textColor: Colors.white,
          ),
          RaisedButton(
            onPressed: () {},
            child: Text("底部2"),
            color: _colors[_currentIndex],
            textColor: Colors.white,
          ),
        ],
        bottomNavigationBar: BottomNavigationBar(
          items: _bottomNavItems,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.shifting,
          onTap: (index) {
            _changePage(index);
          },
        ),
      ),
    );
  }
}
