import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ispend_app/customIcons.dart';
import 'package:ispend_app/widgets/mainWidget.dart';
import 'package:ispend_app/widgets/socialIcons.dart';

import 'darkTheme.dart';

class SignInWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final BuildContext context;

  SignInWidget({this.context, this.emailController, this.passwordController});

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
              style: TextStyle(color: Theme
                  .of(this.context)
                  .accentColor),
              controller: emailController,
              decoration: InputDecoration(
                hintText: Controller.displayHintTextEmail,
                hintStyle: CustomTextStyle.formField(this.context),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme
                            .of(this.context)
                            .accentColor, width: 1.0)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme
                            .of(this.context)
                            .accentColor, width: 1.0)),
                prefixIcon: const Icon(
                  Icons.email,
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
              style: TextStyle(color: Theme
                  .of(this.context)
                  .accentColor),
              controller: passwordController,
              decoration: InputDecoration(
                //Add th Hint text here.
                hintText: Controller.displayHintTextPassword,
                hintStyle: CustomTextStyle.formField(this.context),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme
                            .of(this.context)
                            .accentColor, width: 1.0)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme
                            .of(this.context)
                            .accentColor, width: 1.0)),
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
                      Controller.displaySignInEmailButton,
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.button(this.context),
                    ),
                  )
                ],
              ),
              color: Colors.blueGrey,
              onPressed: () =>
                  Controller.tryToLogInUserViaEmail(
                      this.context, emailController, passwordController),
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