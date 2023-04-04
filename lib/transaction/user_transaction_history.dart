import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:wallet_one/transaction/transaction_history_model.dart';

import '../all_style_sheet/style_item.dart';
import '../auth/auth_api.dart';
import '../profile/get_user_profile.dart';

class UserTransactionHistory{

  static late String dateTime;
  static late String receiver;
  static late String amount;
  static String sender = AuthApi.walletId.toString();

  static void insertUserTransactionHistory(dateTime,receiver,amount,sender) async{

    final response = await http.post(Uri.parse(StyleItem.userTransactionHistoryURL ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "dateTime": dateTime,
        "receiver": receiver,
        "amount": amount,
        "sender": sender,
      }),
    );

    if(response.statusCode == 200){

      print(response.body);
      if(response.body != ""){

        Get.snackbar("Payment", "Successful");

      }
    }else{
      throw Exception('Failed');
    }

  }

  static Future<List<TransactionHistoryModel>> fetchUserTransactionHistory(sender) async{

    final response = await http.post(Uri.parse(StyleItem.fetchUserTransactionHistoryURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "sender": sender,
      }),
    );

    if(response.statusCode == 200){

      final List result = jsonDecode(response.body);
      return result.map((e) => TransactionHistoryModel.fromJson(e)).toList();
    }else{
      throw Exception('Failed');
    }

  }


}