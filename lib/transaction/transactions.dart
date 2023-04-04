import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:objectid/objectid.dart';
import 'package:wallet_one/transaction/user_transaction_history.dart';
import 'dart:convert';

import '../all_style_sheet/style_item.dart';
import '../auth/auth_api.dart';
import '../home/home.dart';
import '../invoice/make_invoice.dart';
import '../pyment_process/payment/merchant_pay.dart';
import '../pyment_process/vat_collection_queue/vat_collection_queue.dart';

class Transactions{

  static late String walletId;
  static late double amount;
  static String paymentStatusG = "paid";
  static String userWalletId = AuthApi.walletId.toString();
  static String? dateTime,vatId,queueId,consumerWalletId,vatWalletId,payableVatAmount,
      paymentStatus,mId,merchantWalletId,payableAmount;



  // merchant payment (merchant)
  static void payToMerchant(walletId,amount) async{

    final response = await http.put(Uri.parse(StyleItem.sendToMerchantURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "walletId": walletId,
        "amount": amount,
      }),
    );

    if(response.statusCode == 200){

      print(response.body);
      if(response.body == "1"){
        updateToConsumersWithPaidStatus(userWalletId, amount);
        Get.snackbar("Merchant payment", "Successful");
        Get.to(() => Home(mobNo: AuthApi.mobNoG.toString(),) );
      }
    }else{
      throw Exception('Failed');
    }

  }
  // update consumer balance with paid status (merchant)
  static void updateToConsumersWithPaidStatus(walletId,amount) async{

    final response = await http.put(Uri.parse(StyleItem.updateBalanceToConsumersURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "walletId": walletId,
        "amount": -amount,
      }),
    );

    if(response.statusCode == 200){

      print(response.body);
      if(response.body == "1"){
        updatePayStatusVatQueue(queueId,paymentStatus);
      }

    }else{
      throw Exception('Failed');
    }

  }
  // update payment status vat queue (merchant)
  static void updatePayStatusVatQueue(queueId,paymentStatusG) async{

    final response = await http.put(Uri.parse(StyleItem.updatePaymentStatusVatQueueURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "id": queueId,
        "paymentStatus": paymentStatusG,
      }),
    );

    if(response.statusCode == 200){

      print(response.body);
      if(response.body == "1"){

        //........Date implement here
        DateTime now = DateTime.now();
        var formatter = DateFormat('yyyy-MM-dd, HH:mm');
        dateTime = formatter.format(now);

        //........id implement here
        final ID = ObjectId();
        mId = ID.toString();

        //..............

        queueId = VatCollectionQueue.id;
        consumerWalletId = AuthApi.walletId;
        merchantWalletId = VatCollectionQueue.merchantWalletId;
        payableAmount = VatCollectionQueue.amount.toString();
        paymentStatus = "paid";

        MakeInvoice.merchantInvoice(dateTime, mId, queueId, consumerWalletId, merchantWalletId, payableAmount, paymentStatus);
        // insert transaction history
        UserTransactionHistory.insertUserTransactionHistory(dateTime, merchantWalletId, payableAmount, consumerWalletId);

        Get.to(() => Home(mobNo: AuthApi.mobNoG.toString(),) );
      }

    }else{
      throw Exception('Failed');
    }

  }
  // vat payment from consumer (vat)
  static void vatPay(walletId,amount) async{

    final response = await http.put(Uri.parse(StyleItem.payToVatWalletURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "vatWalletId": walletId,
        "amount": amount,
      }),
    );

    if(response.statusCode == 200){

      print(response.body);
      if(response.body == "1"){
        updateToConsumerWith(userWalletId, amount);
        Get.snackbar("VAT payment", "Successful");
        Get.to(() => const MerchantPay());
      }
    }else{
      throw Exception('Failed');
    }

  }
  // update consumer balance with (vat)
  static void updateToConsumerWith(walletId,amount) async{

    final response = await http.put(Uri.parse(StyleItem.updateBalanceToConsumersURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "walletId": walletId,
        "amount": -amount,
      }),
    );

    if(response.statusCode == 200){

      if(response.body == "1"){

        //........Date implement here
        DateTime now = DateTime.now();
        var formatter = DateFormat('yyyy-MM-dd, HH:mm');
        dateTime = formatter.format(now);

        //........id implement here
        final ID = ObjectId();
        vatId = ID.toString();

        //..............

        queueId = VatCollectionQueue.id;
        consumerWalletId = AuthApi.walletId;
        vatWalletId = VatCollectionQueue.vatWalletId;
        payableVatAmount = VatCollectionQueue.vat.toString();
        paymentStatus = "paid";

        MakeInvoice.vatInvoice(dateTime, vatId, queueId, consumerWalletId, vatWalletId, payableVatAmount, paymentStatus);
        UserTransactionHistory.insertUserTransactionHistory(dateTime, vatWalletId, payableVatAmount, consumerWalletId);
      }

    }else{
      throw Exception('Failed');
    }

  }
  // Send money to consumers (send money)
  static void sendToConsumer(walletId,amount) async{

    final response = await http.put(Uri.parse(StyleItem.sendToConsumersURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "walletId": walletId,
        "amount": amount,
      }),
    );

    if(response.statusCode == 200){

      print(response.body);
      if(response.body == "1"){
        updateToConsumer(userWalletId, amount);
      }

    }else{
      throw Exception('Failed');
    }

  }
  // update consumer balance (send money)
  static void updateToConsumer(walletId,amount) async{

    final response = await http.put(Uri.parse(StyleItem.updateBalanceToConsumersURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "walletId": walletId,
        "amount": -amount,
      }),
    );

    if(response.statusCode == 200){

      print(response.body);

      if(response.body == "1"){

        Get.snackbar("Send money", "Successful");
      }

    }else{
      throw Exception('Failed');
    }

  }



}