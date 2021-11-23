import 'dart:convert';
import 'package:erp/models/loginmodel.dart';
import 'package:http/http.dart' as http;
import 'package:erp/models/profilemain.dart';

class URLS {
  static const String BASE_URL = 'https://his-erp.com/API_CustApp';
}

// 'https://his-erp.com/API_CustApp/login_check.php/'
class Api {
  static Future login(String clientid, String username, String password) async {
    final response =
        await http.post(Uri.parse('${URLS.BASE_URL}/login_check.php/'), body: {
      'clientid': clientid,
      'username': username,
      'password': password,
    });

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print("Login API");
      print(jsonResponse);

      LoginModel data = LoginModel.fromJson(jsonResponse);
      return data;
    } else {
      throw Exception('Failed to load login from API');
    }
  }
}

class profileapi {
  profile_main? profile;

  apicall() async {
    Map<String, dynamic> bodyData = {
      'clientid': "msd",
      'username': "9892015020",
      'password': "abcd123",
    };

    var resp = await http.post(
        Uri.parse("https://his-erp.com/API_CustApp/profile_main.php"),
        body: bodyData);

    if (resp.statusCode == 200) {
      // final jsonResponse = json.decode(resp.body);
      print("Login API");
      // print(jsonResponse);

      profile = profile_main.fromJson(json.decode(resp.body));
      print(profile!.bbuildNam);
    } else {
      throw Exception('Failed to load login from API');
    }
  }
}
