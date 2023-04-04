import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wallet_one/home/home.dart';
import 'package:wallet_one/profile/user_data_model.dart';
import 'package:wallet_one/auth/sign_in.dart';
import 'package:http/http.dart' as http;
import '../all_style_sheet/style_item.dart';
import 'auth_api.dart';

class MakeProfile extends StatefulWidget {
  final String mobNo;
  final String nidNo;
  final String userName;
  const MakeProfile({Key? key, required this.mobNo, required this.nidNo, required this.userName}) : super(key: key);

  @override
  State<MakeProfile> createState() => _MakeProfileState();
}

class _MakeProfileState extends State<MakeProfile> {

  @override
  Widget build(BuildContext context) {

    final  _focusNode = FocusNode();
    late Color color;
    // text field color change when it pressed
    _focusNode.addListener(() {
      setState(() {
        color = _focusNode.hasFocus ? Colors.deepOrange.shade700: Colors.blueGrey.shade800;
      });
    });

    final formKey =  GlobalKey<FormState>();
    //validate Pin Number
    validatePinNumber(value){
      if(value.length !=6){
        return 'pin number must be 6 digit';
      }else{
        return null;
      }
    }

    TextEditingController pinField = TextEditingController();

    late String resultNid,walletId,nID ;
    double amount = 0.0;


    // create wallet id

    nID = widget.nidNo;
    resultNid = nID.characters.takeLast(2).toString();
    walletId = widget.mobNo + resultNid;

    // insert data to db



    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade200,
          child: Card(
            elevation: 2,
            shadowColor: Colors.purple.shade700,
            margin: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.all(8.0),
                    alignment: Alignment.topLeft,
                    child: RichText(
                        text: TextSpan(
                            style: StyleItem.titleTextStyleTwo,
                            children: [
                              const TextSpan(text: "Welcome,\n"),
                              TextSpan(text: "Make profile ", style: StyleItem.titleTextStyle),
                              const TextSpan(text: "to continue."),
                            ]
                        )
                    )
                ),
                Row(
                  children: [
                    Padding(
                      padding: StyleItem.allPadding,
                      child: Text("Full name: ",
                        style: StyleItem.mTextStyle,
                        textAlign: StyleItem.textAlignLeft,
                      ),

                    ),
                    Padding(
                      padding: StyleItem.allPadding,
                      child: Text(widget.userName,
                        style: StyleItem.mTextStyleN,
                        textAlign: StyleItem.textAlignCenter,
                      ),

                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: StyleItem.allPadding,
                      child: Text("Mobile number: ",
                        style: StyleItem.mTextStyle,
                        textAlign: StyleItem.textAlignLeft,
                      ),

                    ),
                    Padding(
                      padding: StyleItem.allPadding,
                      child: Text(widget.mobNo,
                        style: StyleItem.mTextStyleN,
                        textAlign: StyleItem.textAlignCenter,
                      ),

                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: StyleItem.allPadding,
                      child: Text("NID number: ",
                        style: StyleItem.mTextStyle,
                        textAlign: StyleItem.textAlignLeft,
                      ),

                    ),
                    Padding(
                      padding: StyleItem.allPadding,
                      child: Text(widget.nidNo,
                        style: StyleItem.mTextStyleN,
                        textAlign: StyleItem.textAlignCenter,
                      ),

                    ),
                  ],
                ),

                Row(
                  children: [
                    Padding(
                      padding: StyleItem.allPadding,
                      child: Text("Wallet ID: ",
                        style: StyleItem.mTextStyle,
                        textAlign: StyleItem.textAlignLeft,
                      ),

                    ),
                    Padding(
                      padding: StyleItem.allPadding,
                      child: Text(walletId,
                        style: StyleItem.mTextStyleN,
                        textAlign: StyleItem.textAlignCenter,
                      ),

                    ),
                  ],
                ),

                Row(
                  children: [
                    Padding(
                      padding: StyleItem.allPadding,
                      child: Text("Amount: ",
                        style: StyleItem.mTextStyle,
                        textAlign: StyleItem.textAlignLeft,
                      ),

                    ),
                    Padding(
                      padding: StyleItem.allPadding,
                      child: Text("$amount",
                        style: StyleItem.mTextStyleN,
                        textAlign: StyleItem.textAlignCenter,

                      ),

                    ),
                  ],
                ),
                Form(
                  key: formKey,
                  child: Padding(padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: pinField,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.deepOrange.shade700,
                    validator: validatePinNumber,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "set your pin",
                      labelStyle: TextStyle(
                          color: _focusNode.hasFocus ? Colors.deepOrange.shade700: Colors.blueGrey.shade800
                      ),
                      icon: Icon(Icons.person_pin,color: _focusNode.hasFocus ? Colors.deepOrange.shade700: Colors.blueGrey.shade800),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.deepOrange.shade700,
                        ),
                      ),
                    ),
                    autofocus: false,


                  ),
                ),),


                Row(

                  children: [
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: StyleItem.allPadding,
                        child: Text("Ready to make a new account",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            style: StyleItem.textStyle),
                      ),
                    ),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child:  Container(
                          alignment: Alignment.centerRight,
                          margin: StyleItem.allMargin,
                          child: ElevatedButton(
                            onPressed: () {
                              //print(pinField.text);
                              if( formKey.currentState!.validate()){
                                AuthApi.insertUserData(widget.userName,widget.mobNo,widget.nidNo,walletId,amount,pinField.text);
                              }
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.purple.shade700,
                              elevation: 2,
                              shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),

                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Next", style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                                ),

                              ],
                            ),


                          ),
                        )
                    ),

                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                        text: TextSpan(
                            style: StyleItem.textStyle,
                            children: [
                              const TextSpan(text: "Already have account ! "),
                              TextSpan(text: "Sign in ", style: StyleItem.textStyleTwo,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignIn()));
                                    }
                              ),
                              const TextSpan(text: "here."),
                            ]
                        )
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


