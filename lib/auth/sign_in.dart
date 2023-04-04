import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wallet_one/auth/auth_api.dart';
import 'package:wallet_one/home/home.dart';
import 'package:wallet_one/profile/user_data_model.dart';
import 'package:wallet_one/auth/sign_up.dart';
import '../all_style_sheet/style_item.dart';
import 'package:http/http.dart' as http;

// this is sign in activity. two input get from users, there are mobile number and pin number.
// also include forget pin features.
// and send request for otp

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignUpState();
}

class _SignUpState extends State<SignIn> {

  final  _focusNode = FocusNode();
  late Color color;
  TextEditingController mobNoTextController = TextEditingController();
  TextEditingController pinTextController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    // text field color change when it pressed
    _focusNode.addListener(() {
      setState(() {
        color = _focusNode.hasFocus ? Colors.deepOrange.shade700: Colors.blueGrey.shade800;
      });
    });

    final formKey =  GlobalKey<FormState>();
    //String s = '013';

    //validate Mobile Number
    validateMobileNumber(value){
      if(value.length !=11){
        return 'mobile number must be 11 digit';
      }else{
        return null;
      }
    }

    //validate Pin Number
    validatePinNumber(value){
      if(value.length !=6){
        return 'pin number must be 6 digit';
      }else{
        return null;
      }
    }


    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              color: Colors.grey.shade200,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/chain_logo.png',
                      height: 180,
                      width: 180,
                    ),
                    // activity title sign in
                    const Padding(padding: EdgeInsets.all(16.0),
                      child: Text('Wallet',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff37474F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      margin: StyleItem.allMargin,
                      child: Column(
                        children: [
                          // input mobile number
                          Container(
                              margin: const EdgeInsets.all(8.0),
                              alignment: Alignment.topLeft,
                              child: RichText(
                                  text: TextSpan(
                                      style: StyleItem.titleTextStyleTwo,
                                      children: [
                                        const TextSpan(text: "Welcome,\n"),
                                        TextSpan(text: "Sign in ", style: StyleItem.titleTextStyle),
                                        const TextSpan(text: "to continue."),
                                      ]
                                  )
                              )
                          ),
                          Padding(padding: StyleItem.allPadding,
                            child: TextFormField(
                              controller: mobNoTextController,
                              cursorColor: Colors.deepOrange.shade700,
                              validator: validateMobileNumber,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: "Mobile Number",
                                labelStyle: TextStyle(
                                  color: _focusNode.hasFocus ? Colors.deepOrange.shade700: Colors.blueGrey.shade800,
                                ),
                                icon: Icon(Icons.phone, color: _focusNode.hasFocus ? Colors.deepOrange.shade700: Colors.blueGrey.shade800),
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
                          // input wallet pin
                          Padding(padding: StyleItem.allPadding,
                            child: TextFormField(
                              controller: pinTextController,
                              keyboardType: TextInputType.phone,
                              cursorColor: Colors.deepOrange.shade700,
                              validator: validatePinNumber,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: "Wallet pin",
                                labelStyle: TextStyle(
                                    color: _focusNode.hasFocus ? Colors.deepOrange.shade700: Colors.blueGrey.shade800
                                ),
                                icon: Icon(Icons.pin, color: _focusNode.hasFocus ? Colors.deepOrange.shade700: Colors.blueGrey.shade800),
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
                          // submitting button next
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: StyleItem.allPadding,
                                child: Text(
                                  StyleItem.forgot,
                                  style: StyleItem.mTextStyle,
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                padding: const EdgeInsets.all(16),
                                child: ButtonTheme(

                                  child: ElevatedButton(
                                    style:  ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff37474F)),
                                    ),
                                    onPressed: (){
                                      if( formKey.currentState!.validate()){
                                        //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing Data')));
                                        AuthApi.signIn(mobNoTextController.text,pinTextController.text);
                                      }
                                      //checkNumberSeries();
                                    },
                                    child: const Text("Next",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),

                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RichText(
                                  text: TextSpan(
                                      style: StyleItem.textStyle,
                                      children: [
                                        const TextSpan(text: "Does not have account ? "),
                                        TextSpan(text: "Sign up ", style: StyleItem.textStyleTwo,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
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

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


