import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallet_one/invoice/vat_invoice_model.dart';

import '../all_style_sheet/style_item.dart';
import 'merchant_invoice_model.dart';

class FetchInvoice{

  static String? dateTime;
  static String? invoiceId;
  static String? queueId;
  static String? consumerWalletId;
  static String? merchantWalletId;
  static String? payableAmount;
  static String? paymentStatus;

  static Future<List<MerchantInvoiceModel>> merchantInvoice(consumerWalletId) async{

    try{

      final response = await http.post(Uri.parse(StyleItem.getConsumerMerchantInvoiceURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String,dynamic>{
          "consumerWalletId": consumerWalletId,
        }),
      );

      if (response.statusCode == 200){


        print(response.body);
        final List result = jsonDecode(response.body);
        return result.map((e) => MerchantInvoiceModel.fromJson(e)).toList();



        //return MerchantInvoiceModel.fromJson(jsonDecode(response.body));


      }else{
        throw Exception('Failed');
      }

    }catch(e){
      throw Exception('Failed to load data.');
    }

  }

  static Future<List<VatInvoiceModel>> vatInvoice(consumerWalletId) async{

    try{

      final response = await http.post(Uri.parse(StyleItem.getConsumerVatInvoiceURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String,dynamic>{
          "consumerWalletId": consumerWalletId,
        }),
      );

      if (response.statusCode == 200){


        print(response.body);

        final List result = jsonDecode(response.body);
        return result.map((e) => VatInvoiceModel.fromJson(e)).toList();

        //return VatInvoiceModel.fromJson(jsonDecode(response.body));


      }else{
        throw Exception('Failed');
      }

    }catch(e){
      throw Exception('Failed to load data.');
    }

  }


}