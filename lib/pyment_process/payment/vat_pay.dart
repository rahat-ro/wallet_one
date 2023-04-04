import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:objectid/objectid.dart';
import 'package:wallet_one/pyment_process/vat_collection_queue/vat_collection_model.dart';
import 'package:wallet_one/pyment_process/vat_collection_queue/vat_collection_queue.dart';
import 'package:wallet_one/transaction/transactions.dart';

import 'package:intl/intl.dart';

import '../../all_style_sheet/style_item.dart';

class VatPay extends StatefulWidget {
  const VatPay({Key? key}) : super(key: key);

  @override
  State<VatPay> createState() => _VatPayState();
}

class _VatPayState extends State<VatPay> {

  double? vatG = VatCollectionQueue.vat;
  String? date;
  String? vatInvoiceId;



  @override
  Widget build(BuildContext context) {
    //........Date implement here
    DateTime now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd, HH:mm');
    date = formatter.format(now);


    //........id implement here
    final ID = ObjectId();
    vatInvoiceId = ID.toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange.shade700,
        title: const Text("Pay your VAT"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Padding(padding: StyleItem.allPadding,
                      child: Text("Date-Time :", style: StyleItem.mTextStyle,)
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Padding(padding: StyleItem.allPadding,
                    child: Text(date.toString(), style: StyleItem.mTextStyle),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Padding(
                      padding: StyleItem.allPadding,
                      child: Text("Query ID :", style: StyleItem.mTextStyle,)
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Padding(padding: StyleItem.allPadding,
                    child: Text(VatCollectionQueue.id.toString(), style: StyleItem.mTextStyle),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Padding(padding: StyleItem.allPadding,
                      child: Text("Additional Data :", style: StyleItem.mTextStyle,)
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Padding(padding: StyleItem.allPadding,
                    child: Text(VatCollectionQueue.additionalData.toString(), style: StyleItem.mTextStyle),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Padding(padding: StyleItem.allPadding,
                      child: Text("Payment Status :", style: StyleItem.mTextStyle,)
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Padding(padding: StyleItem.allPadding,
                    child: Text(VatCollectionQueue.paymentStatus.toString(), style: StyleItem.mTextStyle),
                  ),
                ),
              ],
            ),
            Card(
              elevation: 2,
              shadowColor: Colors.deepOrange.shade700,
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Padding(padding: StyleItem.allPadding,
                          child: Text("VAT Wallet ID :", style: StyleItem.mTextStyle,),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Padding(padding: StyleItem.allPadding,
                          child: Text(VatCollectionQueue.vatWalletId.toString(), style: StyleItem.mTextStyle),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Padding(padding: StyleItem.allPadding,
                          child: Text("Payable VAT :", style: StyleItem.mTextStyle,),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Padding(padding: StyleItem.allPadding,
                          child: Text("$vatG", style: StyleItem.mTextStyle),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: StyleItem.allPadding,
                    child: SizedBox(
                      height: 1,
                      width: double.infinity,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.deepOrange.shade800
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 40,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: StyleItem.allMargin,
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: (){
                  Transactions.vatPay(VatCollectionQueue.vatWalletId.toString(),vatG);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.deepOrange.shade700,
                  elevation: 2,
                  shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),

                ),
                child: const Text("Pay VAT"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
