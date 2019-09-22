import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ispend_app/network/networkManager.dart';
import 'package:ispend_app/screens/Profile.dart';
import 'package:ispend_app/widgets/signInWidget.dart';
import 'package:ispend_app/widgets/signupWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'darkTheme.dart';

bool _signUpActive = false;
bool _signInActive = true;
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _newEmailController = TextEditingController();
TextEditingController _newPasswordController = TextEditingController();

const String _logoTitle = "iSpend";
const String _logoSubTitle = "Where the f is ma' monah'??";
const String _signInMenuButton = "SIGN IN";
const String _signUpMenuButton = "SIGN UP";
const String _hintTextEmail = "Email";
const String _hintTextUsername = "Username";
const String _hintTextPassword = "Password";
const String _hintTextNewUsername = "Enter your Username";
const String _hintTextNewEmail = "Enter your Email";
const String _hintTextNewPassword = "Enter a Password";
const String _signUpButtonText = "SIGN UP";
const String _signInWithEmailButtonText = "Sign in with Email";
const String _emailLogInFailed =
    "Email or Password was incorrect. Please try again";

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
        theme: buildDarkTheme(),
        home: Scaffold(
          resizeToAvoidBottomPadding: true,
          body: new Builder(
              builder: (context) =>
              new Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme
                              .of(context)
                              .primaryColor,
                          Theme
                              .of(context)
                              .primaryColorLight
                        ])),
                child: Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  //Sets the main padding all widgets has to adhere to.
                  child: LogInPage(),
                ),
              )
          ),
        )
    );
  }
}

class _LogInPageState extends StateMVC<LogInPage> {
  _LogInPageState() : super(Controller());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    ScreenUtil.instance = ScreenUtil.getInstance()
      ..init(context);
    ScreenUtil.instance =
    ScreenUtil(width: 750, height: 1304, allowFontScaling: true)
      ..init(context);
    return Column(
      children: <Widget>[
        Container(
          child: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                      Controller.displayLogoTitle,
                      style: CustomTextStyle.title(context)
                  ),
                  Text(
                    Controller.displayLogoSubTitle,
                    style: CustomTextStyle.subTitle(context),
                  ),
                ],
              )),
          width: ScreenUtil.getInstance().setWidth(750),
          height: ScreenUtil.getInstance().setHeight(190),
        ),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(60),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0),
            child: IntrinsicWidth(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  OutlineButton(
                    onPressed: () =>
                        setState(() => Controller.changeToSignIn()),
                    borderSide: new BorderSide(
                      style: BorderStyle.none,
                    ),
                    child: new Text(Controller.displaySignInMenuButton,
                        style: _signInActive
                            ? TextStyle(
                            fontSize: 22,
                            color: Theme
                                .of(context)
                                .accentColor,
                            fontWeight: FontWeight.bold)
                            : TextStyle(
                            fontSize: 16,
                            color: Theme
                                .of(context)
                                .accentColor,
                            fontWeight: FontWeight.normal)),
                  ),
                  OutlineButton(
                    onPressed: () =>
                        setState(() => Controller.changeToSignUp()),
                    borderSide: BorderSide(
                      style: BorderStyle.none,
                    ),
                    child: Text(Controller.displaySignUpMenuButton,
                        style: _signUpActive
                            ? TextStyle(
                            fontSize: 22,
                            color: Theme
                                .of(context)
                                .accentColor,
                            fontWeight: FontWeight.bold)
                            : TextStyle(
                            fontSize: 16,
                            color: Theme
                                .of(context)
                                .accentColor,
                            fontWeight: FontWeight.normal)),
                  )
                ],
              ),
            ),
          ),
          width: ScreenUtil.getInstance().setWidth(750),
          height: ScreenUtil.getInstance().setHeight(170),
        ),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(10),
        ),
        Container(
          child: Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: _signInActive ? _showSignIn(context, _emailController, _passwordController) : _showSignUp(_newEmailController, _newPasswordController)),
          width: ScreenUtil.getInstance().setWidth(750),
          height: ScreenUtil.getInstance().setHeight(778),
        ),
      ],
    );
  }

  Widget _showSignIn(BuildContext context, TextEditingController emailController, TextEditingController passwordController) {
    return new SignInWidget(context: context, emailController: emailController, passwordController: passwordController);
  }

  Widget _showSignUp(TextEditingController newEmailController, TextEditingController newPasswordController) {
    return new SignupWidget();
  }

  Widget horizontalLine() =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.white.withOpacity(0.6),
        ),
      );

  Widget emailErrorText() => Text(Controller.displayErrorEmailLogIn);
}

class LogInPage extends StatefulWidget {
  LogInPage({Key key}) : super(key: key);

  @protected
  @override
  State<StatefulWidget> createState() => _LogInPageState();
}

class Controller extends ControllerMVC {
  /// Singleton Factory
  factory Controller() {
    if (_this == null) _this = Controller._();
    return _this;
  }

  static Controller _this;

  Controller._();

  /// Allow for easy access to 'the Controller' throughout the application.
  static Controller get con => _this;

  /// The Controller doesn't know any values or methods. It simply handles the communication between the view and the model.

  static String get displayLogoTitle => _logoTitle;

  static String get displayLogoSubTitle => _logoSubTitle;

  static String get displaySignUpMenuButton => _signUpMenuButton;

  static String get displaySignInMenuButton => _signInMenuButton;

  static String get displayHintTextEmail => _hintTextEmail;

  static String get displayHintTextPassword => _hintTextPassword;

  static String get displayHintTextUsername => _hintTextUsername;

  static String get displayHintTextNewEmail => _hintTextNewEmail;

  static String get displayHintTextNewPassword => _hintTextNewPassword;

  static String get displayHintTextNewUsername => _hintTextNewUsername;

  static String get displaySignUpButtonTest => _signUpButtonText;

  static String get displaySignInEmailButton =>
      _signInWithEmailButtonText;

  static String get displayErrorEmailLogIn => _emailLogInFailed;

  static void changeToSignUp() => Model._changeToSignUp();

  static void changeToSignIn() => Model._changeToSignIn();

  static Future<bool> signInWithEmail(context, email, password) =>
      Model._signInWithEmail(context, email, password);

  static void signUpWithEmailAndPassword(email, password) =>
      Model._signUpWithEmailAndPassword(email, password);

  static Future navigateToProfile(context) => Model._navigateToProfile(context);

  static Future tryToLogInUserViaEmail(context, email, password) async {
    if (await signInWithEmail(context, email, password) == true) {
      navigateToProfile(context);
    }
  }

  static Future tryToSignUpWithEmail(email, password) async {
    if (await tryToSignUpWithEmail(email, password) == true) {
      //TODO Display success message or go to Login screen
    } else {
      //TODO Display error message and stay put.
    }
  }
}

class Model {
  static void _changeToSignUp() {
    _signUpActive = true;
    _signInActive = false;
  }

  static void _changeToSignIn() {
    _signUpActive = false;
    _signInActive = true;
  }

  static Future<bool> _signInWithEmail(context, TextEditingController email,
      TextEditingController password) async {
    try {
      // AuthResult result = await FirebaseAuth.instance
      //     .signInWithEmailAndPassword(
      //     email: email.text.trim().toLowerCase(), password: password.text);
      // print('Signed in: ${result.user.uid}');
      NetworkManager.sendLogin('serj', 'serj1');
      return false;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  static Future<bool> _signUpWithEmailAndPassword(TextEditingController email,
      TextEditingController password) async {
    try {
      // AuthResult result = await FirebaseAuth.instance
      //     .createUserWithEmailAndPassword(
      //     email: email.text.trim().toLowerCase(), password: password.text);
      // print('Signed up: ${result.user.uid}');
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  static Future _navigateToProfile(context) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Profile()));
  }
}
