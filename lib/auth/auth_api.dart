import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:wallet_one/home/home.dart';

import '../all_style_sheet/style_item.dart';
import '../profile/user_data_model.dart';

class AuthApi{

  static String? userName;
  static String? mobNoG;
  static String? nidNo;
  static String? walletId;
  static double? amount;
  static String? pinG;

  // Sign in
  static Future<UserDataModel> signIn(mobNo,pin) async {
    final response = await http.post(Uri.parse(StyleItem.signInURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String,dynamic>{
        "mobNo": mobNo,
        "pin": pin,
      }),
    );

    if (response.statusCode == 200){

      //print(response.body);
      if (response.body != "incorrect"){

        var jsonResponse = jsonDecode(response.body);
        userName = jsonResponse["userName"];
        mobNoG = jsonResponse["mobNo"];
        nidNo = jsonResponse["nidNo"];
        walletId = jsonResponse["walletId"];
        amount = jsonResponse["amount"];
        pinG = jsonResponse["pin"];

        Get.to(()=>Home(mobNo: mobNo));

      }else{
        //print(response.body);
        Get.snackbar("Sign in", response.body);

      }
      return UserDataModel.fromJson(jsonDecode(response.body));


    }else{
      throw Exception('Failed to sign in.');
    }

  }

  // Sing up
  static Future<UserDataModel> insertUserData(userNameG,mobNo,nidNoG,walletIdG,amountG,pinField)async{

    final response = await http.post(Uri.parse(StyleItem.signUpURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String,dynamic>{
        "userName": userNameG,
        "mobNo": mobNo,
        "nidNo": nidNoG,
        "walletId": walletIdG,
        "amount": amountG,
        "pin": pinField
      }),
    );

    if (response.statusCode == 200){

      if (response.body == "user already exist"){
        print("This mobile number and nid number already exist");

        Get.snackbar("Sign up", response.body);

      }else{
        var jsonResponse = jsonDecode(response.body);
        userName = jsonResponse["userName"];
        mobNoG = jsonResponse["mobNo"];
        nidNo = jsonResponse["nidNo"];
        walletId = jsonResponse["walletId"];
        amount = jsonResponse["amount"];
        pinG = jsonResponse["pin"];
        Get.to(() => Home(mobNo: mobNo));
      }


      return UserDataModel.fromJson(jsonDecode(response.body));

    }else{
      throw Exception('Failed to sign up.');
    }


  }

  // reset pin
  static Future<UserDataModel> resetPin(mobNo,nidNoG,pin) async{

    final response = await http.post(Uri.parse(StyleItem.resetPinURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String,dynamic>{
        "mobNo": mobNo,
        "nidNo": nidNoG,
        "pin": pin,
      }),
    );

    if(response.statusCode == 200){

      print(response.body);
      if(response.body == "1"){

        var jsonResponse = jsonDecode(response.body);
        userName = jsonResponse["userName"];
        mobNoG = jsonResponse["mobNo"];
        nidNo = jsonResponse["nidNo"];
        walletId = jsonResponse["walletId"];
        amount = jsonResponse["amount"];
        pinG = jsonResponse["pin"];
        Get.to(() => Home(mobNo: mobNo));
      }
      return UserDataModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed');
    }


  }




}