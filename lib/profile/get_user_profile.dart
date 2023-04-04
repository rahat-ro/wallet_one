import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallet_one/profile/user_data_model.dart';

import '../all_style_sheet/style_item.dart';


class GetUserProfile{

  static String? userName;
  static String? mobNoGet;
  static String? nidNo;
  static String? walletId;
  static String? pin;
  static double? amount;


  static Future<UserDataModel> getProfile(mobNo) async{

    try{

      final response = await http.post(Uri.parse(StyleItem.getProfileURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String,dynamic>{
          "mobNo": mobNo,
        }),
      );

      if (response.statusCode == 200){

        var jsonResponse = jsonDecode(response.body);
        userName = jsonResponse["userName"];
        mobNoGet = jsonResponse["mobNo"];
        nidNo = jsonResponse["nidNo"];
        walletId = jsonResponse["walletId"];
        amount = jsonResponse["amount"];
        pin = jsonResponse["pin"];

        print(response.body);

        return UserDataModel.fromJson(jsonDecode(response.body));


      }else{
        throw Exception('Failed');
      }

    }catch(e){
      throw Exception('Failed to load data.');
    }

  }

}