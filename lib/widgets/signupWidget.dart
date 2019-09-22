import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ispend_app/widgets/mainWidget.dart';

import 'darkTheme.dart';

class SignupWidget extends StatelessWidget {
  final TextEditingController newEmailController;
  final TextEditingController newUsernameController;
  final TextEditingController newPasswordController;

  SignupWidget({this.newEmailController, this.newUsernameController, this.newPasswordController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          child: Padding(
            padding: EdgeInsets.only(),
            child: TextField(
              obscureText: false,
              style: CustomTextStyle.formField(context),
              controller: newEmailController,
              decoration: InputDecoration(
                //Add th Hint text here.
                hintText: Controller.displayHintTextNewEmail,
                hintStyle: CustomTextStyle.formField(context),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme
                            .of(context)
                            .accentColor, width: 1.0)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme
                            .of(context)
                            .accentColor, width: 1.0)),
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(30),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(),
            child: TextField(
              obscureText: false,
              style: CustomTextStyle.formField(context),
              controller: newUsernameController,
              decoration: InputDecoration(
                //Add th Hint text here.
                hintText: Controller.displayHintTextNewUsername,
                hintStyle: CustomTextStyle.formField(context),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme
                            .of(context)
                            .accentColor, width: 1.0)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme
                            .of(context)
                            .accentColor, width: 1.0)),
                prefixIcon: const Icon(
                  Icons.account_box,
                  color: Colors.white,
                ),
              ),
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
              style: CustomTextStyle.formField(context),
              controller: newPasswordController,
              decoration: InputDecoration(
                //Add the Hint text here.
                hintText: Controller.displayHintTextNewPassword,
                hintStyle: CustomTextStyle.formField(context),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme
                            .of(context)
                            .accentColor, width: 1.0)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme
                            .of(context)
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
              child: Text(
                Controller.displaySignUpMenuButton,
                style: CustomTextStyle.button(context),
              ),
              color: Colors.blueGrey,
              onPressed: () =>
                  Controller.signUp(
                      newEmailController, newUsernameController, newPasswordController),
            ),
          ),
        ),
      ],
    );
  }
}