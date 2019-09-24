import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ispend_app/models/spending.dart';
import 'package:ispend_app/models/user.dart';
import 'package:ispend_app/network/networkManager.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title, this.user}) : super(key: key);

  final String title;
  final User user;

  @override
  _HomeScreenState createState() =>
      _HomeScreenState(user.username, user.cookie);
}

List spendKindsIDs = ["sk_travel", "sk_food", "sk_nightlife", "sk_rent"];

class _HomeScreenState extends State<HomeScreen> {
  String username;
  String cookie;
  TextEditingController _currencyCtrl = TextEditingController();
  TextEditingController _amountCtrl = TextEditingController();
  String choosenSpendKindID = 'sk_travel';
  int _counter = 0;

  _HomeScreenState(String username, String cookie) {
    this.username = username;
    this.cookie = cookie;
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
                vertical: 130, horizontal: 0), // all(28.0),
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
                  DropdownButton<String>(
                    value: choosenSpendKindID,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        choosenSpendKindID = newValue;
                        _incrementCounter();
                      });
                    },
                    items: <String>[
                      'sk_travel',
                      'sk_food',
                      'sk_nightlife',
                      'sk_rent'
                    ].map<DropdownMenuItem<String>>((String value) {
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
                    Spending newSpending = new Spending(
                        _currencyCtrl.text.trim(), amount, choosenSpendKindID);
                    NetworkManager.sendNewSpending(username, newSpending)
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
                    child: Text('TopCenter!'),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text('TopCenter!'),
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
}
