import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:wallet_one/pyment_process/vat_collection_queue/vat_collection_model.dart';

import '../../all_style_sheet/style_item.dart';




class VatCollectionQueue{

  static String? date;
  static String? id;
  static String? merchantWalletId;
  static String? vatWalletId;
  static String? paymentStatus;
  static String? additionalData;
  static double? amount;
  static double? vat;

  static Future<VatCollectionModel> getDocVatCollectionData(qId) async{
    final response = await http.post(Uri.parse(StyleItem.getDocVatCollectionDataURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String,dynamic>{
        "id": qId,
      }),
    );

    if (response.statusCode == 200){

      var jsonResponse = jsonDecode(response.body);
      date = jsonResponse["date"];
      id = jsonResponse["id"];
      merchantWalletId = jsonResponse["merchantWalletId"];
      vatWalletId = jsonResponse["vatWalletId"];
      paymentStatus = jsonResponse["paymentStatus"];
      additionalData = jsonResponse["additionalData"];
      amount = jsonResponse["amount"];
      vat = jsonResponse["vat"];

      print(response.body);

      //.................. implement QR code using object id from dart ObjectID
      //Get.to( () => QrForPayment(id: id));

      return VatCollectionModel.fromJson(jsonDecode(response.body));

    }else{
      throw Exception('Failed to insert Data.');
    }
  }

}