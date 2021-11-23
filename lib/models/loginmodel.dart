class LoginModel {
  String? lastLogin;
  String? usertype;
  int? isSuccess;
  String? username;
  String? message;

  LoginModel(
      {this.lastLogin,
      this.usertype,
      this.isSuccess,
      this.username,
      this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    lastLogin = json['last_login'];
    if (json['usertype'] == null) {
      usertype = "a";
    } else {
      usertype = json['usertype'];
    }
    isSuccess = json['isSuccess'];
    username = json['username'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['username'] = this.username;
    data['message'] = this.message;
    data['last_login'] = this.lastLogin;
    data['usertype'] = this.usertype;
    return data;
  }
}
