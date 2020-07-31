import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Page1 extends StatefulWidget {
  @override
  Page1State createState() {
    return Page1State();
  }
}

class Page1State extends State<Page1> {
  String fullName = '';
  TextEditingController myController = TextEditingController();
  FocusNode focusNode = new FocusNode();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
//    myController.addListener(() {
//        final text = myController.text.toLowerCase();
//        myController.value = myController.value.copyWith(
//          text: text,
//          selection:
//          TextSelection(baseOffset: text.length, extentOffset: text.length),
//          composing: TextRange.empty,
//        );
//    }
//    );
    focusNode = new FocusNode();

    // listen to focus changes
    focusNode.addListener(
        () => print('focusNode updated: hasFocus: ${focusNode.hasFocus}'));
  }

  @override
  void setFocus() {
    FocusScope.of(context).requestFocus(focusNode);
  }

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
              'Flutter Text Field Test',
              style: TextStyle(color: Colors.white),
            )),
        body: Center(
            child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: TextField(
              key: Key('fullname'),
              focusNode: focusNode,
              controller: myController,
              autofocus: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full Name',
              ),
              onChanged: (text) {
                setState(() {
//                    fullName = text;
                  //you can access nameController in its scope to get
                  // the value of text entered as shown below
                  fullName = myController.text;
                });
                print(text);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(fullName),
          )
        ])));
  }
}
