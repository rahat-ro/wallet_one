import 'package:flutter/material.dart';
import 'package:dart_std/dart_std.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:wallet_one/auth/auth_api.dart';
import 'package:wallet_one/pyment_process/payment/vat_pay.dart';
import 'package:wallet_one/pyment_process/vat_collection_queue/vat_collection_model.dart';
import 'package:wallet_one/pyment_process/vat_collection_queue/vat_collection_queue.dart';

import '../all_style_sheet/style_item.dart';
import '../profile/get_user_profile.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ScanQrCode extends StatefulWidget {
  final String mobNo;
  const ScanQrCode({Key? key, required this.mobNo}) : super(key: key);

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  String _scanBarcode = 'Unknown';
  late String netBalance;
  late String checkBalance,paid;

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      qrPayButton();
    });
  }

  @override
  void initState() {

    setState(() {
      VatCollectionQueue.getDocVatCollectionData(_scanBarcode);
      //GetUserProfile.getProfile(widget.mobNo);


    });

    super.initState();
  }


  bool _processButton = true;

  bool _qrPayButton = true;

  void qrPayButton(){
    setState(() {
      _qrPayButton = !_qrPayButton;
    });
  }

  void processButton(){
    setState(() {
      _processButton = !_processButton;
    });
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: Visibility(
        visible: _qrPayButton,
        child: SizedBox(
          height: 48,
          width: 48,
          child: FloatingActionButton.small(
            onPressed: () {
              //print("Button is pressed.");
              scanQR();

            },
            shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.zero
            ),
            backgroundColor: Colors.deepOrange.shade700,
            child: const Icon(Icons.qr_code),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Payment process"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange.shade700,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height:  double.infinity,
              margin: StyleItem.allMargin,
              alignment: Alignment.center,
              color: Colors.blueGrey.shade50,
              child: FutureBuilder<VatCollectionModel>(
                  future: VatCollectionQueue.getDocVatCollectionData(_scanBarcode),
                  builder: (context, AsyncSnapshot<VatCollectionModel>snapshot){
                    if(snapshot.hasData){
                      double? amountG = snapshot.data?.amountG;
                      double? vatG = snapshot.data?.vatG;
                      double? total = amountG?.plusOrNull(vatG);
                      double? balanceG = AuthApi.amount;
                      double? afterPayVat = balanceG?.minus(vatG);
                      print(afterPayVat);
                      double? afterPayAmount = balanceG?.minus(amountG);
                      print(afterPayAmount);

                      paid = snapshot.data?.paymentStatusG as String;

                      if(paid == "paid"){
                        _processButton = false;
                      }


                      if(total! <= balanceG!){
                        print("Sufficient Balance");
                        checkBalance = "Sufficient Balance is";
                        netBalance = AuthApi.amount!.toStringAsFixed(2).toString()!;
                      }else{
                        print("insufficient Balance is");
                        checkBalance ="Insufficient Balance";
                        netBalance = AuthApi.amount!.toStringAsFixed(2).toString()!;
                        _processButton = false;
                      }
                      return Column(
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
                                  child: Text(snapshot.data?.dateG as String, style: StyleItem.mTextStyle),
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
                                  child: Text(snapshot.data?.idG as String, style: StyleItem.mTextStyle),
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
                                  child: Text(snapshot.data?.additionalDataG as String, style: StyleItem.mTextStyle),
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
                                  child: Text(snapshot.data?.paymentStatusG as String, style: StyleItem.mTextStyle),
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
                                  child: Text("VAT Wallet ID :", style: StyleItem.mTextStyle,),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Padding(padding: StyleItem.allPadding,
                                  child: Text(snapshot.data?.vatWalletIdG as String, style: StyleItem.mTextStyle),
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
                                  child: Text("Merchant Wallet Id :", style: StyleItem.mTextStyle,),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Padding(padding: StyleItem.allPadding,
                                  child: Text(snapshot.data?.merchantWalletIdG as String, style: StyleItem.mTextStyle),
                                ),
                              ),
                            ],
                          ),

                          Card(
                            elevation: 2,
                            shadowColor: Colors.deepOrange.shade800,
                            margin: StyleItem.allMargin,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Padding(padding: StyleItem.allPadding,
                                        child: Text("$checkBalance", style: StyleItem.mTextStyle,),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Padding(padding: StyleItem.allPadding,
                                        child: Text(netBalance, style: StyleItem.mTextStyle),
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
                                        child: Text("Payable amount :", style: StyleItem.mTextStyle,),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Padding(padding: StyleItem.allPadding,
                                        child: Text("$amountG", style: StyleItem.mTextStyle),
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
                                Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Padding(padding: StyleItem.allPadding,
                                        child: Text("Total BDT :", style: StyleItem.mTextStyle,),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Padding(padding: StyleItem.allPadding,
                                        child: Text("$total", style: StyleItem.mTextStyle),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),

                          Visibility(
                            visible: _processButton,
                            child: Container(
                            width: double.infinity,
                            alignment: Alignment.centerRight,
                            margin: StyleItem.allMargin,
                            child: ElevatedButton(
                              onPressed: (){
                                Get.to(() => const VatPay());
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.deepOrange.shade700,
                                elevation: 2,
                                shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),

                              ),
                              child: const Text("Prepare to payment"),
                            ),
                          ),
                          ),

                        ],
                      );
                    }
                    return Container(
                      width: double.infinity,
                      height: 10,
                      margin: StyleItem.allMargin,
                      child: LinearProgressIndicator(
                        minHeight: 5,
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation(Colors.blueGrey.shade50.withOpacity(0.5)),
                      ),
                    );
                  }
              ),
            ),
            Visibility(
                visible: _qrPayButton,
                child: Container(
                  width: double.infinity,
                  height:  double.infinity,
                  margin: StyleItem.allMargin,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Image.asset("assets/images/scan.png",height: 120,width: 120,),
                      Text("Scan QR to pay",style: StyleItem.titleTextStyleTwo,),
                    ],
                  ),
                ),
            ),

          ],
        ),
      ),
    );
  }
}
