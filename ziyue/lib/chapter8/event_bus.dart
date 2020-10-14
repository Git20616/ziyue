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

}