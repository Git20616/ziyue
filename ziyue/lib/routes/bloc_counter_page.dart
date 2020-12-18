import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziyue/blocs/counter_bloc.dart';

class BlocCounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("基于Bloc的计数器"),
        ),
        body: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            int numb = 0;
            if (state is CounterChangeState) {
              numb = state.numb;
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("$numb", style: TextStyle(fontSize: 20),),
                  RaisedButton(
                    onPressed: () {
                      BlocProvider.of<CounterBloc>(context).add(CounterIncrementedEvent());
                    },
                    color: Theme.of(context).primaryColor,
                    child: Text("增加"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      BlocProvider.of<CounterBloc>(context).add(CounterDecrementedEvent());
                    },
                    color: Theme.of(context).primaryColor,
                    child: Text("减少"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      BlocProvider.of<CounterBloc>(context).add(CounterRetriedEvent());
                    },
                    color: Theme.of(context).primaryColor,
                    child: Text("重置"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
