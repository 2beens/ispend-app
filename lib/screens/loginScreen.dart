import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ispend_app/models/user.dart';
import 'package:ispend_app/network/apiResponse.dart';
import 'package:ispend_app/network/apiManager.dart';
import 'package:ispend_app/screens/homeScreen.dart';
import 'package:ispend_app/widgets/darkTheme.dart';
import 'package:ispend_app/widgets/signInWidget.dart';
import 'package:ispend_app/widgets/signupWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

bool _signUpActive = false;
bool _signInActive = true;

User _loggedUser;

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
        theme: buildDarkTheme(),
        home: Scaffold(
          resizeToAvoidBottomPadding: true,
          body: new Builder(
              builder: (context) => new Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColorLight
                        ])),
                    child: Padding(
                      padding: EdgeInsets.only(top: 40.0),
                      //Sets the main padding all widgets has to adhere to.
                      child: LogInPage(),
                    ),
                  )),
        ));
  }
}

class _LogInPageState extends StateMVC<LogInPage> {
  // TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _newEmailController = TextEditingController();
  TextEditingController _newUsernameController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();

  _LogInPageState() : super(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
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
                  Text(LoginScreenController.displayLogoTitle,
                      style: CustomTextStyle.title(context)),
                  Text(
                    LoginScreenController.displayLogoSubTitle,
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
                        setState(() => LoginScreenController.changeToSignIn()),
                    borderSide: new BorderSide(
                      style: BorderStyle.none,
                    ),
                    child: new Text(LoginScreenController.displaySignInMenuButton,
                        style: _signInActive
                            ? TextStyle(
                                fontSize: 22,
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold)
                            : TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.normal)),
                  ),
                  OutlineButton(
                    onPressed: () =>
                        setState(() => LoginScreenController.changeToSignUp()),
                    borderSide: BorderSide(
                      style: BorderStyle.none,
                    ),
                    child: Text(LoginScreenController.displaySignUpMenuButton,
                        style: _signUpActive
                            ? TextStyle(
                                fontSize: 22,
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold)
                            : TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).accentColor,
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
              child: _signInActive
                  ? _showSignIn(
                      context, _usernameController, _passwordController)
                  : _showSignUp(_newEmailController, _newUsernameController,
                      _newPasswordController)),
          width: ScreenUtil.getInstance().setWidth(750),
          height: ScreenUtil.getInstance().setHeight(778),
        ),
      ],
    );
  }

  Widget _showSignIn(
      BuildContext mainContext,
      TextEditingController usernameController,
      TextEditingController passwordController) {
    return new SignInWidget(
        mainContext: mainContext,
        usernameController: usernameController,
        passwordController: passwordController);
  }

  Widget _showSignUp(
      TextEditingController newEmailController,
      TextEditingController newUsernameController,
      TextEditingController newPasswordController) {
    return new SignupWidget(
        mainContext: context,
        newEmailController: newEmailController,
        newUsernameController: newUsernameController,
        newPasswordController: newPasswordController);
  }

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.white.withOpacity(0.6),
        ),
      );

  Widget emailErrorText() => Text(LoginScreenController.displayErrorEmailLogIn);
}

class LogInPage extends StatefulWidget {
  LogInPage({Key key}) : super(key: key);

  @protected
  @override
  State<StatefulWidget> createState() => _LogInPageState();
}

class LoginScreenController extends ControllerMVC {
  /// Singleton Factory
  factory LoginScreenController() {
    if (_this == null) {
      _this = LoginScreenController._();
    }
    return _this;
  }

  static LoginScreenController _this;

  LoginScreenController._();

  /// Allow for easy access to 'the Controller' throughout the application.
  static LoginScreenController get con => _this;

  /// The Controller doesn't know any values or methods. It simply handles the communication between the view and the model.
  ///
  static String get displayLogoTitle => "iSpend";

  static String get displayLogoSubTitle => "Where the f is ma' monah'??";

  static String get displaySignUpMenuButton => "SIGN UP";

  static String get displaySignInMenuButton => "SIGN IN";

  static String get displayHintTextEmail => "Email";

  static String get displayHintTextPassword => "Password";

  static String get displayHintTextUsername => "Username";

  static String get displayHintTextNewEmail => "Enter your Email";

  static String get displayHintTextNewPassword => "Enter a Password";

  static String get displayHintTextNewUsername => "Enter your Username";

  static String get displaySignUpButtonTest => "SIGN UP";

  static String get displaySignInEmailButton => "SIGN IN";

  static String get displayErrorEmailLogIn =>
      "Email or Password was incorrect. Please try again";

  static void changeToSignUp() => Model._changeToSignUp();

  static void changeToSignIn() => Model._changeToSignIn();

  static Future<APIResponse> signIn(context, username, password) =>
      Model._signIn(context, username, password);

  static Future<APIResponse> signUp(email, username, password) =>
      Model._signUp(email, username, password);

  static Future trySignIn(context, TextEditingController usernameCtrl,
      TextEditingController passwordCtrl) async {
    APIResponse apiResp = await signIn(context, usernameCtrl, passwordCtrl);
    if (apiResp.isError) {
      Fluttertoast.showToast(
          msg: apiResp.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      _loggedUser = null;
    } else {
      _loggedUser = new User(
          email: "<email>",
          username: usernameCtrl.text.trim(),
          password: passwordCtrl.text,
          cookie: apiResp.data);
      print("logged user: " + _loggedUser.username);
      navigateToProfile(context, _loggedUser);
    }
  }

  static Future trySignUp(context,
      TextEditingController emailCtrl,
      TextEditingController usernameCtrl,
      TextEditingController passwordCtrl) async {
    APIResponse apiResp = await signUp(emailCtrl, usernameCtrl, passwordCtrl);
    if (apiResp.isError) {
      Fluttertoast.showToast(
          msg: apiResp.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      _loggedUser = null;
    } else {
      _loggedUser = new User(
          email: emailCtrl.text.trim().toLowerCase(),
          username: usernameCtrl.text.trim(),
          password: passwordCtrl.text,
          cookie: apiResp.data);
      print("logged user: " + _loggedUser.username);
      navigateToProfile(context, _loggedUser);
    }
  }

  static Future navigateToProfile(context, User loggedUser) =>
      Model._navigateToProfile(context, loggedUser);

  static Future tryToSignUpWithEmail(email, password) async {
    if (await tryToSignUpWithEmail(email, password) == true) {
      //TODO Display success message or go to Login screen
      print("tryToSignUpWithEmail true");
    } else {
      //TODO Display error message and stay put.
      print("tryToSignUpWithEmail false");
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

  static Future<APIResponse> _signIn(
      context,
      TextEditingController usernameCtrl,
      TextEditingController passwordCtrl) async {
    try {
      String username = usernameCtrl.text.trim();
      String password = passwordCtrl.text;
      print("try to log in: [$username][$password]");
      return APIManager.sendLogin(username, password);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<APIResponse> _signUp(
      TextEditingController emailCtrl,
      TextEditingController usernameCtrl,
      TextEditingController passwordCtrl) async {
    try {
      String email = emailCtrl.text.trim().toLowerCase();
      String username = usernameCtrl.text.trim();
      String password = passwordCtrl.text;
      print("received for signUp: [$email][$username][$password]");
      return APIManager.sendRegister(email, username, password);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future _navigateToProfile(context, User loggedUser) async {
    // await Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => Profile(user: loggedUser)));
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomeScreen(title: loggedUser.username + "'s Spends", user: loggedUser)));
  }
}
