import 'package:flutter/material.dart';
import 'package:ziyue/routes/bloc_counter_page.dart';

class SeniorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Center(
        child: Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocCounterPage(),
                    ));
              },
              child: Text("Bloc"),
            ),
          ],
        ),
      ),
    );
  }
}
