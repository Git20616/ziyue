// 订阅者 回调签名
typedef void EventCallBack(arg);

// 注意：Dart中实现单例模式的标准做法就是使用static变量+工厂构造函数的方式，这样就可以保证new EventBus()始终返回都是同一个实例。
class EventBus {
  // 私有构造函数
  EventBus._internal();

  // 保存单例
  static EventBus _singleton = new EventBus._internal();

  // 工厂构造函数
  // 当执行构造函数并不总是创建这个类的一个新实例时，则使用 factory 关键字。
  factory EventBus() => _singleton;

  // 保存事件订阅者队列， key: 事件名，value: 对应的订阅者队列
  var _emap = new Map<String, List<EventCallBack>>();

  // 添加订阅者
  void on(String eventName, EventCallBack callBack) {
    if(eventName == null || callBack == null) return;
    _emap[eventName] ??= new List<EventCallBack>(); //a??=b a为空时赋值，否则保持不变
    _emap[eventName].add(callBack);
  }

  // 移除订阅者
  void off(String eventName, [EventCallBack callBack]) {
    //1.对象就是传引用
    //2.原始类型就是传值
    //3.String等immutable类型因为没有提供自身修改的函数，每次操作都是新生成一个对象，所以要特殊对待。可以认为是传值。
    List<EventCallBack> list = _emap[eventName];
    if(eventName == null || list == null) return;
    if(callBack == null) {
      _emap[eventName] = null;
    } else {
      list.remove(callBack);
    }
  }

  // 触发事件，事件触发后，该事件的所有订阅者都会被调用
  void emit(String eventName, [arg]) {
    var list = _emap[eventName];
    if(list == null) return;
    //反向遍历，防止订阅者在回调中移除自身带来的下标错位
    for(int i = list.length - 1; i >= 0; --i) {
      list[i](arg);
    }
  }
}

// 定义一个top-level（全局）变量，页面引入该文件后可以直接使用bus
EventBus bus = new EventBus();