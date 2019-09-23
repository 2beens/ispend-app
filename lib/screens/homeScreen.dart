import 'package:flutter/material.dart';
import 'package:ispend_app/models/user.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: HomeScreen(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title, this.user}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final User user;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List spendKindsIDs = ["sk_travel", "sk_food", "sk_nightlife", "sk_rent"];

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _currencyCtrl = TextEditingController();
  TextEditingController _amountCtrl = TextEditingController();
  TextEditingController _kindIdCtrl = TextEditingController();

  String choosenSpendKindID = 'sk_travel';

  int _counter = 0;
  // new spending params
  // username=admin currency=rsd amount=12.01 kind_id=sk_nightlife

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 130, horizontal: 0),// all(28.0),
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
                // TextField(
                //   controller: _kindIdCtrl,
                //   decoration: InputDecoration(hintText: "Specify kind"),
                // ),
                DropdownButton<String>(
                  value: choosenSpendKindID,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(
                    color: Colors.deepPurple
                  ),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      choosenSpendKindID = newValue;
                    });
                  },
                  items: <String>['sk_travel', 'sk_food', 'sk_nightlife', 'sk_rent']
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                    .toList(),
                ),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('ADD'),
                onPressed: () {
                  print(_amountCtrl.text.trim());
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  print(_amountCtrl.text.trim());
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
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
            // Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.display1,
            // ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
