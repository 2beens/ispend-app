import 'package:flutter/material.dart';
import 'package:ispend_app/models/user.dart';

class Profile extends StatelessWidget {
  User user;

  Profile({this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Data from logged in user:"),
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
                  Text("Email: " + this.user.email),
                  Text("Username: " + this.user.username),
                  Text("Cookie: " + this.user.cookie),
                ],
              )
              //child: _displayUserData(user.profileData),
            ),
        ),
      ),
    );
  }

  /** _displayUserData(profileData) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 200.0,
          width: 200.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
               image: NetworkImage(
                profileData['picture']['data']['url'],
              ),
              
            ),
          ),
        ),
        SizedBox(height: 28.0),
        Text(
          "Logged in as: ${profileData['name']}",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ],
    );
}*/

}
