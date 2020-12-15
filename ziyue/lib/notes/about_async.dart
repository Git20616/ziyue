//flutter函数中使用async*,async使得函数异步执行。

// 1、async返回Stream，并通过yield关键字生成Stream流的值。
Stream<int> countForOneMinute() async* {
  for(int i=0; i<=60; ++i) {
    await Future.delayed(const Duration(seconds: 1));
    yield i; //生成一个Stream的值
  }
}

// 2、async返回Future，直接返回泛型值即可
Future<int> doSomeLongTask() async {
  await Future.delayed(const Duration(seconds: 1));
  return 1;
}

/*
  类别	  关键字 	返回类型	      搭档
多元素同步	sync*	  Iterable<T>	  yield、yield*
单元素异步	async	  Future<T>     await
多元素异步	async*	Stream<T>	    yield、yield* 、await
* */