import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:wallet_one/profile/get_user_profile.dart';
import 'package:wallet_one/transaction/transactions.dart';

import '../all_style_sheet/style_item.dart';
import '../profile/user_data_model.dart';




class SendMoneyPage extends StatelessWidget {
  const SendMoneyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepOrange.shade700
      ),
      home: const SendMoney(),
    );
  }
}


class SendMoney extends StatefulWidget {
  const SendMoney({Key? key}) : super(key: key);

  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {

  final  _focusNode = FocusNode();
  late Color color;

  TextEditingController walletIdField = TextEditingController();
  TextEditingController amountField = TextEditingController();

  String _scanBarcode = 'Unknown';
  late String netBalance;

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
      walletIdField.text = _scanBarcode;
      qrPayButton();
    });
  }


  bool _qrPayButton = true;

  void qrPayButton(){
    setState(() {
      _qrPayButton = !_qrPayButton;
    });
  }



  @override
  Widget build(BuildContext context) {

    // text field color change when it pressed
    _focusNode.addListener(() {
      setState(() {
        color = _focusNode.hasFocus ? Colors.deepOrange.shade700: Colors.blueGrey.shade800;
      });
    });

    final formKey =  GlobalKey<FormState>();
    //validate Wallet ID
    validateWalletId(value){
      if(value.length !=13){
        return 'wallet id must be 13 digit';
      }else{
        return null;
      }
    }

    //validate Pin Number
    validateAmount(value){
      if(value.length ==""){
        return 'please input amount';
      }else{
        return null;
      }
    }

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
        backgroundColor: Colors.deepOrange.shade700,
        title: const Text("Send Money"),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Card(
                elevation: 2,
                shadowColor: Colors.deepOrange.shade700,
                margin: StyleItem.allMargin,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:TextFormField(
                        controller: walletIdField,
                        cursorColor: Colors.deepOrange.shade700,
                        keyboardType: TextInputType.number,
                        validator: validateWalletId,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Wallet ID",
                          labelStyle: TextStyle(
                            color: _focusNode.hasFocus ? Colors.deepOrange.shade700: Colors.blueGrey.shade800,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Colors.deepOrange.shade700
                            ),
                          ),
                        ),
                        autofocus: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: amountField,
                        cursorColor: Colors.deepOrange.shade700,
                        keyboardType: TextInputType.number,
                        validator: validateAmount,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Amount",
                          labelStyle: TextStyle(
                            color: _focusNode.hasFocus ? Colors.deepOrange.shade700: Colors.blueGrey.shade800,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Colors.deepOrange.shade700
                            ),
                          ),
                        ),
                        autofocus: false,
                      ),
                    ),
                    Row(
                      mainAxisSize:  MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FutureBuilder<UserDataModel>(
                            future: GetUserProfile.getProfile(GetUserProfile.mobNoGet),
                            builder: (context,AsyncSnapshot<UserDataModel> snapshot){
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return Container(
                                  width: double.infinity,
                                  margin: StyleItem.allMargin,
                                  child: LinearProgressIndicator(
                                    minHeight: 5,
                                    backgroundColor: Colors.transparent,
                                    valueColor: AlwaysStoppedAnimation(Colors.blueGrey.shade50.withOpacity(0.5)),
                                  ),
                                );
                              }else if(snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.active){
                                if(snapshot.hasError){
                                  return Text(snapshot.error.toString());
                                }else if(snapshot.hasData){
                                  var amount = snapshot.data?.amountG;

                                  //print(amount);
                                  return Row(
                                    children: [
                                      const Padding(
                                        padding: StyleItem.allPadding,
                                        child: Text("Amount",),
                                      ),
                                      Padding(
                                        padding: StyleItem.allPadding,
                                        child: Text("$amount",style: StyleItem.textStyle,),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        margin: StyleItem.allMargin,
                                        child: ElevatedButton(
                                          onPressed: () {

                                            if( formKey.currentState!.validate()){

                                              double sendAmount = double.parse(amountField.text);
                                              //print(sendAmount);
                                              double balance = double.parse(GetUserProfile.amount.toString());
                                              //print(balance);
                                              if(sendAmount > balance) {
                                                print("insufficient");
                                              }else{
                                                Transactions.sendToConsumer(walletIdField.text, double.parse(amountField.text) );
                                                walletIdField.clear();
                                                amountField.clear();

                                              }

                                            }
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.deepOrange.shade700,
                                            elevation: 2,
                                            shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),

                                          ),
                                          child: Row(
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("Send", style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                                              ),
                                              Icon(Icons.arrow_forward,size: 18,),
                                            ],
                                          ),

                                        ),
                                      ),

                                    ],
                                  );
                                }else{
                                  return const Text("errror");
                                }
                              }else{
                                return Text(snapshot.connectionState.toString());
                              }
                            }
                        ),

                      ],
                    ),
                  ],
                ),
              ),

              Visibility(
                  visible: _qrPayButton,
                  child: Container(
                    width: double.infinity,
                    margin: StyleItem.allMargin,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Image.asset("assets/images/scan.png",height: 120,width: 120,),
                        Text("Scan QR to send money",style: StyleItem.titleTextStyleTwo,),
                      ],
                    ),
                  ),
              ),

            ],
          ),
        ),
      ),
    );
  }


}







