class LoginModel {
    int? isSuccess;
    String? username;
    String? message;
    String? lastLogin;
    String? usertype;
    String? logoimage;

    LoginModel({this.isSuccess, this.username, this.message, this.lastLogin, this.usertype, this.logoimage});

    LoginModel.fromJson(Map<String, dynamic> json) {
        this.isSuccess = json["isSuccess"];
        this.username = json["username"];
        this.message = json["message"];
        this.lastLogin = json["last_login"];
        this.usertype = json["usertype"];
        this.logoimage = json["logoimage"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["isSuccess"] = this.isSuccess;
        data["username"] = this.username;
        data["message"] = this.message;
        data["last_login"] = this.lastLogin;
        data["usertype"] = this.usertype;
        data["logoimage"] = this.logoimage;
        return data;
    }
}