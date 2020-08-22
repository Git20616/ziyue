import 'package:flutter/cupertino.dart';

class ImageAndIcon extends StatelessWidget {
  final AssetImage _img = AssetImage("images/lysnickname.png");
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[

            ],
          ),
          Column(
            children: <Image>[
              Image(
                image: _img,
                height: 50.0,
                width: 100.0,
                fit: BoxFit.fill,
              ),
            ].map((e) {
              return Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 100.0,
                      child: e,
                    ),
                  ),
                  Text(
                    e.fit.toString(),
                    style: TextStyle(
                      fontFamily: "Narcissus",
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

}