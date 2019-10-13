import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ispend_app/models/spendKind.dart';
import 'package:ispend_app/models/spending.dart';
import 'package:ispend_app/models/user.dart';
import 'package:ispend_app/network/apiManager.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title, this.user}) : super(key: key);

  final String title;
  final User user;

  @override
  _HomeScreenState createState() =>
      _HomeScreenState(user.username, user.cookie);
}

// List spendKindsIDs = ["sk_travel", "sk_food", "sk_nightlife", "sk_rent"];
List<String> spendKindsIDs = [];

class _HomeScreenState extends State<HomeScreen> {
  String username;
  String cookie;
  TextEditingController _currencyCtrl = TextEditingController();
  TextEditingController _amountCtrl = TextEditingController();
  String _choosenSpendKindID = '';
  int _counter = 0;

  List<Spending> spends = new List();
  List<SpendKind> spendKinds = new List();

  _HomeScreenState(String username, String cookie) {
    this.username = username;
    this.cookie = cookie;
    this.spends = spends;

    APIManager.getSpends(username).then((apiResp) {
      if (apiResp.isError) {
        print(" > error getting spends: " + apiResp.message);
        return;
      }

      setState(() {
        for (int i = 0; i < apiResp.data.length; i++) {
          Spending spend = Spending.fromJsonMap(apiResp.data[i]);
          spends.add(spend);
        }
        print("received " + spends.length.toString() + " spends");
      });
    });

    APIManager.getSpendKinds(username).then((apiResp) {
      if (apiResp.isError) {
        print(" > error getting spend kinds: " + apiResp.message);
        return;
      }

      for (int i = 0; i < apiResp.data.length; i++) {
        SpendKind spendKind = SpendKind.fromJsonMap(apiResp.data[i]);
        spendKinds.add(spendKind);
        spendKindsIDs.add(spendKind.id.toString());
        print("adding spend kind: " + spendKind.id.toString());
      }

      _choosenSpendKindID = spendKinds.first.id;

      print("received " + apiResp.data.length.toString() + " spend kinds");
    });

    // print("received spends: " + this.spends.length.toString());
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      print("incrementing counter: " + _counter.toString());
      _counter++;
    });
  }

  void _setSpendKindID(String spendKindID) {
    setState(() {
      _choosenSpendKindID = spendKindID;
      print("new choosen spend kind ID: " + _choosenSpendKindID);
    });
  }

  _showError(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  _showMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 70, horizontal: 0), // all(28.0),
            child: AlertDialog(
              title: Text('Add Spend'),
              content: Column(
                children: <Widget>[
                  TextField(
                    controller: _currencyCtrl,
                    decoration: InputDecoration(hintText: "Specify currency"),
                  ),
                  TextField(
                    controller: _amountCtrl,
                    decoration: InputDecoration(hintText: "Specify amount"),
                  ),
                  // TODO: this crap probably has to be a stateful widget
                  //    in order for the selected spend kind ID to change visually too
                  DropdownButton<String>(
                    value: _choosenSpendKindID,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      _setSpendKindID(newValue);
                    },
                    items: spendKindsIDs
                        .map<DropdownMenuItem<String>>((dynamic value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('ADD'),
                  onPressed: () {
                    print(' > sending new spending: ' +
                        _amountCtrl.text +
                        ' ' +
                        _currencyCtrl.text);
                    double amount =
                        double.tryParse(_amountCtrl.text.trim()) ?? '0';
                    // TODO: choose kind from a list, taken from server, rather than this
                    SpendKind spendKind =
                        new SpendKind(id: _choosenSpendKindID, name: "empty");
                    Spending newSpending = new Spending(
                        currency: _currencyCtrl.text.trim(), amount: amount);
                    APIManager.sendNewSpending(username, newSpending)
                        .then((apiResp) {
                      if (apiResp.isError) {
                        _showError("Error: " + apiResp.message);
                      } else {
                        cookie = apiResp.data;
                        _showMessage("New Spending added!");
                      }
                      Navigator.of(context).pop();
                    });
                  },
                ),
                new FlatButton(
                  child: new Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      color: Colors.blueGrey,
                    ),
                  ),
                  Align(
                    alignment: Alignment(-1, -1),
                    child: Text('Top Left!'),
                  ),
                  Align(
                    alignment: Alignment(0, 0),
                    child: Text('Centered!'),
                  ),
                  Align(
                    alignment: Alignment(1, 1),
                    child: Text('Bottom Right!'),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    // child: Text('TopCenter!'),
                    // child: Stack(children: _getSpendsWidgets()),
                    child: ListView(
                      children: _getSpendsWidgets(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text('BottomCenter!'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonTheme(
                minWidth: 200.0,
                height: 65.0,
                child: RaisedButton(
                  color: Colors.blueAccent,
                  onPressed: () => _displayDialog(context),
                  child: Text("Add Spend"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getSpendsWidgets() {
    List<Widget> spends = new List<Widget>();
    for (var s in this.spends) {
      spends.add(ListTile(
        leading: Icon(Icons.adjust),
        title: Text(s.kind.name + " - " + s.amount.toString() + " " + s.currency),
      ));
    }
    return spends;
  }
}
