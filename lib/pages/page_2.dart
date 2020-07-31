import 'package:flutter/material.dart';


class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            key: Key('backBtn'),
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text(
            'Flutter Text Label Test',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          child: Center(
            child: Text('Page2', key: Key('page2GreetingLbl')),
          ),
        ));
    ;
  }
}
