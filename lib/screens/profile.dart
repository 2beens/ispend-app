import 'package:flutter/material.dart';
import 'package:ispend_app/config.dart';
import 'package:ispend_app/models/user.dart';
import 'package:ispend_app/widgets/darkTheme.dart';

class Profile extends StatelessWidget {
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Email: " + this.user.email,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "Username: " + this.user.username,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "Cookie: " + this.user.cookie,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
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
            // Spacer(

            // ),
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
            SizedBox(height: 28.0),
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
