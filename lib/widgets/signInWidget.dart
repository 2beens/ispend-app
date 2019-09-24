import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ispend_app/customIcons.dart';
import 'package:ispend_app/screens/loginScreen.dart';
import 'package:ispend_app/widgets/socialIcons.dart';

import 'darkTheme.dart';

class SignInWidget extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final BuildContext mainContext;

  SignInWidget(
      {this.mainContext, this.usernameController, this.passwordController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(30),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(),
            child: TextField(
              style: TextStyle(color: Theme.of(this.mainContext).accentColor),
              controller: usernameController..text = 'serj',
              decoration: InputDecoration(
                hintText: LoginScreenController.displayHintTextUsername,
                hintStyle: CustomTextStyle.formField(this.mainContext),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(this.mainContext).accentColor,
                        width: 1.0)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(this.mainContext).accentColor,
                        width: 1.0)),
                prefixIcon: const Icon(
                  Icons.account_box,
                  color: Colors.white,
                ),
              ),
              obscureText: false,
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(50),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(),
            child: TextField(
              obscureText: true,
              style: TextStyle(color: Theme.of(this.mainContext).accentColor),
              controller: passwordController..text = 's',
              decoration: InputDecoration(
                //Add th Hint text here.
                hintText: LoginScreenController.displayHintTextPassword,
                hintStyle: CustomTextStyle.formField(this.mainContext),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(this.mainContext).accentColor,
                        width: 1.0)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(this.mainContext).accentColor,
                        width: 1.0)),
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(80),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(),
            child: RaisedButton(
              child: Row(
                children: <Widget>[
                  SocialIcon(iconData: CustomIcons.email),
                  Expanded(
                    child: Text(
                      LoginScreenController.displaySignInEmailButton,
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.button(this.mainContext),
                    ),
                  )
                ],
              ),
              color: Colors.blueGrey,
              onPressed: () => LoginScreenController.trySignIn(
                  this.mainContext, usernameController, passwordController),
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(30),
        ),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(30),
        ),
      ],
    );
  }
}
