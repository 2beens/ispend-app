class User {
  String username;
  String email;
  String password;
  String cookie;

  User({this.email, this.username, this.password, this.cookie});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['username'] = username;
    map['email'] = email;
    map['password'] = password;
    map['cookie'] = cookie;
    return map;
  }

  User.fromMapObject(Map<String, dynamic> map) {
    this.username = map['username'];
    this.email = map['email'];
    this.password = map['password'];
    this.cookie = map['cookie'];
  }
}
