import 'package:flutter/material.dart';
import 'package:ispend_app/config.dart';
import 'package:ispend_app/models/user.dart';
import 'package:ispend_app/widgets/darkTheme.dart';

// FLUTTER EXAMPLES
// https://github.com/mjohnsullivan/flutter-by-example

class Profile extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  User user;

  Profile({this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: buildDarkTheme(),
      home: Scaffold(
        appBar: AppBar(
          // title: Text("iSpend Overview"),
          title: _displayUserData(),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: Container(
          // child: Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: SingleLineTextFieldWidget(
          //           controller: _controller,
          //         ),
          //       ),
          //       SizedBox(height: 10.0),
          //       FlatButton(
          //         onPressed: () => print(
          //           'FlatButton.onPressed: ${_controller.text}',
          //         ),
          //         child: const Text(
          //           'Submit',
          //           style: TextStyle(
          //             fontSize: 20.0,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          child: new AlignExamples(),
        ),
      ),
    );
  }

  _displayUserData() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              height: 35.0,
              width: 35.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    Config.defaultUserPhotoUrl,
                    // user['picture']['data']['url'],
                  ),
                ),
              ),
            ),
            Spacer(flex: 1),
            Text(
              "Logged in as: ${this.user.username}",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        )
      ],
    );
  }
}

/// Single-line text field widget
class SingleLineTextFieldWidget extends StatelessWidget {
  TextEditingController controller;

  SingleLineTextFieldWidget({this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: TextField(
        controller: controller,
        autocorrect: false, // turns off auto-correct
        decoration: InputDecoration(
          hintText: 'Enter text; return submits',
        ),
        onChanged: (str) => print('Single-line text change: $str'),
        onSubmitted: (str) =>
            print('SingleLineTextFieldWidget.onSubmitted: $str'),
      ),
    );
  }
}


// LAYOUT EXMAPLE
class AlignExamples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            color: Colors.black26,
            child: Align(
              alignment: Alignment(0, 0),
              child: Text('Centered!'),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  color: Colors.black12,
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
        // Flexible(
        //   flex: 1,
        //   child: Container(
        //       color: Colors.black26,
        //       child: Align(
        //         alignment: Alignment(-.5, -.5),
        //         child: Text('25% in'),
        //       )),
        // ),
        // Flexible(
        //   flex: 1,
        //   child: Container(
        //       color: Colors.black12,
        //       child: Align(
        //         alignment: Alignment(.5, .5),
        //         child: Text('75% in'),
        //       )),
        // ),
      ],
    );
  }
}
