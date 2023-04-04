import 'package:http/http.dart' as http;
import 'dart:convert';

import '../all_style_sheet/style_item.dart';


class MakeInvoice{

  static String? dateTime;
  static String? mId;
  static String? queueId;
  static String? consumerWalletId;
  static String? merchantWalletId;
  static String? payableAmount;
  static String? paymentStatus;
  static String? vatId;
  static String? vatWalletId;
  static String? payableVatAmount;

  // insert data to create merchant invoice
  static void merchantInvoice(dateTime,mId,queueId,consumerWalletId,merchantWalletId,payableAmount,paymentStatus) async{

    final response = await http.post(Uri.parse(StyleItem.makeMerchantInvoiceURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "dateTime": dateTime,
        "mId": mId,
        "queueId": queueId,
        "consumerWalletId": consumerWalletId,
        "merchantWalletId": merchantWalletId,
        "payableAmount": payableAmount,
        "paymentStatus": paymentStatus,

      }),
    );

    if(response.statusCode == 200){

      print(response.body);
      if(response.body == "1"){


      }

      //return ProfileModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed');
    }

  }
  // insert data to create vat invoice
  static void vatInvoice(dateTime,vatId,queueId,consumerWalletId,vatWalletId,payableVatAmount,paymentStatus) async{

    final response = await http.post(Uri.parse(StyleItem.makeVatInvoiceURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "dateTime": dateTime,
        "vatId": vatId,
        "queueId": queueId,
        "consumerWalletId": consumerWalletId,
        "vatWalletId": vatWalletId,
        "payableVatAmount": payableVatAmount,
        "paymentStatus": paymentStatus,

      }),
    );

    if(response.statusCode == 200){

      print(response.body);
      if(response.body == "1"){


      }

      //return ProfileModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed');
    }

  }


}