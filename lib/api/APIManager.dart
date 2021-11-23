import 'dart:convert';
import 'package:erp/common/common.dart';
import 'package:erp/models/docmodel.dart';
import 'package:erp/models/loginmodel.dart';
import 'package:erp/models/notfiModel.dart';
import 'package:erp/models/profilemain.dart';
import 'package:erp/models/sopmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'CICError.dart';

enum API { login, temp, profile,sop,info,notification }

enum HTTPMethod { GET, POST, PUT, DELETE }

typedef successCallback = void Function(dynamic response);
typedef progressCallback = void Function(int progress);
typedef failureCallback = void Function(Error error);

class APIManager {
  // static String token;
  static String baseURL = "his-erp.com";
  // static String apiVersion;
  // static String enviornment;

  // var taskId;

  APIManager._privateConstructor();
  static final APIManager _instance = APIManager._privateConstructor();

  factory APIManager() {
    return _instance;
  }

  // void loadConfiguration() {
  // Map config = jsonDecode(configString);
  // enviornment = config['environment'];
  // baseURL = config[enviornment]['hostUrl'];
  // apiVersion = config['version'];
  // print('load config' + configString);
  //   baseURL = "";
  // }

  // void setToken(String value) {
  //   token = value;
  // }

  String apiBaseURL() {
    return baseURL;
  }

  String apiEndPoint(API api) {
    var apiPathString;
    switch (api) {
      case API.login:
        apiPathString = "/API_CustApp/login_check.php/";
        break;
      case API.profile:
        apiPathString = "/API_CustApp/profile_main.php/";
        break;
      case API.sop:
        apiPathString = "/API_CustApp/LedgerQuery.php/";
        break;
      case API.info:
        apiPathString = "/API_CustApp/DocumentQuery.php/";
        break;
      case API.notification:
        apiPathString = "/API_CustApp/PHPNotificationsQuery.php/";
        break;
      default:
        apiPathString = this.apiBaseURL();
        break;
    }
    return apiPathString;
  }

  // Map<String, String> getHeader() {
  //   return {
  //     HttpHeaders.authorizationHeader: 'Bearer ' + token,
  //   };
  // }

  HTTPMethod apiHTTPMethod(API api) {
    HTTPMethod method;
    switch (api) {
      case API.temp:
        method = HTTPMethod.GET;
        break;
      default:
        method = HTTPMethod.POST;
    }
    return method;
  }

// model of api
  String classNameForAPI(API api) {
    String className;
    switch (api) {
      case API.login:
        className = 'LoginModel';
        break;
      case API.profile:
        className = 'profile_main';
        break;
      case API.sop:
        className = 'SopModel';
        break;
      case API.info:
        className = 'Documents';
        break;
      case API.notification:
        className = 'NotificationModel';
        break;
      default:
        className = 'CommonResponse';
    }
    return className;
  }

// parse the api from json
  dynamic parseResponse(String className, var json) {
    dynamic responseObj;
    if (className == 'LoginModel') {
      responseObj = LoginModel.fromJson(json);
    } else if (className == 'profile_main') {
      responseObj = profile_main.fromJson(json);
    }else if (className == 'SopModel') {
      responseObj =Sopmodel.fromJson(json) ;
    } else if (className == 'Documents') {
      responseObj = Documents.fromJson(json);
    }else if (className == 'NotificationModel') {
      responseObj = NotificationModel.fromJson(json);
    }

    return responseObj;
  }

  Future<void> apiRequest(BuildContext context, API api,
      successCallback onSuccess, failureCallback onFailure,
      {dynamic parameter}) async {
    //TODO : use generics for mapping response for API.
    //TODO : show progress indicatior
    //TODO : acccept object as parameter and serilazed
    DateTime startTime = DateTime.now();
    var jsonResponse;
    var response;
    // String authToken = await SPManager().getAuthToken();
    // if (authToken == null) {
    //   authToken = '';
    // }

    // String contactId = await SPManager().getContactId();
    // if (contactId == null) {
    //   contactId = '';
    // }

    // Map<String, String> headerBody = {
    //   'version': apiVersion,
    //   'endpoint': apiEndPoint(api),
    //   'auth_token': authToken,
    //   'contact_id': contactId,
    //   'app_id': 'TESTAPPID'
    // };
    Map<String, dynamic> requestBody = {};
    // Map<String, dynamic> requestBody = {'header': headerBody};
    if (parameter != null) {
      /******Sending Store ID for PCS user for capture */
      // print(
      //     'PCUser ${Utility().isPCsUser} Current Store ${Utility().currentStore}');

      // if (Utility().isPCsUser &&
      //     Utility().currentStore != null &&
      //     (api == API.getStockData ||
      //         api == API.getCompetitorDataListing ||
      //         api == API.getProductCatalog ||
      //         api == API.getProfile ||
      //         api == API.getCompetitorDataCount ||
      //         api == API.captureMissHit ||
      //         api == API.productInventoryListing ||
      //         api == API.onboardConsumerPurchase ||
      //         api == API.addCompetitorData ||
      //         api == API.addStockData ||
      //         api == API.importPreviousDaySales ||
      //         api == API.getSalesData ||
      //         api == API.captureAttendance ||
      //         api == API.addSalesData)) {
      //   print('STORE is ${Utility().currentStore}');
      //   if (Utility().currentStore != null &&
      //       Utility().currentStore.storeId != null &&
      //       !parameter.containsKey('store_id')) {
      //     parameter["store_id"] = Utility().currentStore.storeId;
      //   }
      // }

      /******************* */
      // requestBody = {'header': headerBody, 'request': parameter};
      requestBody = parameter;
    }

    // if (Utility().isPCsUser &&
    //     Utility().currentStore != null &&
    //     api == API.getProfile) {
    //   print('STORE is ${Utility().currentStore}');
    //   parameter["store_id"] = Utility().currentStore.storeId;
    // }

    var body = (requestBody != null ? json.encode(requestBody) : null);
    var url = this.apiBaseURL() + this.apiEndPoint(api);

    try {
      if (this.apiHTTPMethod(api) == HTTPMethod.POST) {
        if (body != null) {
          // FLog.debug(
          //     text:
          //         'Caller : ${programInfo.callerFunctionName} Parameter : $body');
        }
        print('api link $url');
        print('body is -$requestBody');

        if (api == API.login) {
          //query parameter way
          response = await http.post(
              Uri.https(this.apiBaseURL(), this.apiEndPoint(api), requestBody));
        } else {
          response =
              await http.post(Uri.parse("https://" + url), body: requestBody);
        }
      } else if (this.apiHTTPMethod(api) == HTTPMethod.GET) {
        response = await http.get(Uri.parse(url));
      } else if (this.apiHTTPMethod(api) == HTTPMethod.PUT) {
        response = await http.put(Uri.parse(url), body: body);
      }
      //  else if (this.apiHTTPMethod(api) == HTTPMethod.DELETE) {
      //   response = await http.deleteUri.parse(url);
      // }
      //TODO : Handle 201 status code as well
      print('Resp is ${response.statusCode}');
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);

        print('Resp dict ${jsonResponse.toString()}');

        onSuccess(this.parseResponse(this.classNameForAPI(api), jsonResponse));
      } else if (response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        print('Creted Resp dict ${jsonResponse.toString()}');
        onSuccess(this.parseResponse(this.classNameForAPI(api), jsonResponse));
      } else if (response.statusCode == 401) {
        //token expired redirect to login screen
        var tcError = this.parseError(response);
        onFailure(tcError);

        //  Navigator.of(_keyLoader.currentContext, rootNavigator: true)
        //     .pop();
        //clear all shared preferences

      } else {
        var tcError = this.parseError(response);
        // FLog.error(
        //     text:
        //         'Caller : ${programInfo.callerFunctionName} Error : ${tcError.toString()}');
        onFailure(tcError);
      }
    } on Exception catch (exception) {
      print('Exception ${exception.toString()}');
      // only executed if error is of type Exception

      // FLog.error(
      //     text:
      //         'Time : ${Utility().calculateTime(startTime)} Caller : ${programInfo.callerFunctionName} Error : ${tcError.toString()}',
      //     exception: exception);
      onFailure(Error());
    } catch (error) {
      print('Exception ${error.toString()}');

      // executed for errors of all types other than Exception

      // FLog.error(
      //     text:
      //         'Time : ${Utility().calculateTime(startTime)} Caller : ${programInfo.callerFunctionName} Error : ${tcError.toString()}');
      onFailure(Error());
    }
  }

  dynamic parseError(http.Response response) {
    var jsonResponse;
    var message;

    if (response.body != null && response.body.toString().length > 0) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null && jsonResponse["status_Message"] != null) {
        message = jsonResponse["status_Message"];
      } else {
        message = response.body.toString();
      }
    }

    switch (response.statusCode) {
      case 400:
        return BadRequestError(message);
      case 401:
      case 403:
        return UnauthorisedError(message);
      case 500:
      default:
        return FetchDataError(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  dynamic parseUploadError(String response, int statusCode) {
    var jsonResponse;
    var message;
    if (response != null && response.length > 0) {
      jsonResponse = json.decode(response);
      if (jsonResponse != null && jsonResponse["status_Message"] != null) {
        message = jsonResponse["status_Message"];
      } else {
        message = response;
      }
    }

    switch (statusCode) {
      case 400:
        return BadRequestError(message);
      case 401:
      case 403:
        return UnauthorisedError(message);
      case 500:
      default:
        return FetchDataError(
            'Error occured while Communication with Server with StatusCode : ${statusCode}');
    }
  }
}
