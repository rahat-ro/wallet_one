import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wallet_one/auth/make_profile.dart';
import 'package:wallet_one/auth/sign_in.dart';

import '../all_style_sheet/style_item.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final  _focusNode = FocusNode();
  late Color color;
  final textController = TextEditingController();
  TextEditingController mobNoTextController = TextEditingController();
  TextEditingController nidNoTextController = TextEditingController();
  TextEditingController userNameTextController = TextEditingController();



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

    //validate NID Number
    validateNIDNumber(value){
      if(value.length !=13 && value.length !=17){
        return 'NID number must be 13 or 17 digit';
      }else{
        return null;
      }
    }


    return Scaffold(
      resizeToAvoidBottomInset: true, // to avoid bottom padding overflow when keyboard appear
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.grey.shade200,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // display wallet logo
                  Image.asset(
                    'assets/images/chain_logo.png',
                    height: 180,
                    width: 180,
                  ),
                  // activity title sign up
                  const Padding(padding: EdgeInsets.all(16.0),
                    child: Text('Sign Up',
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

                        Container(
                            margin: const EdgeInsets.all(8.0),
                            alignment: Alignment.topLeft,
                            child: RichText(
                                text: TextSpan(
                                    style: StyleItem.titleTextStyleTwo,
                                    children: [
                                      const TextSpan(text: "Welcome,\n"),
                                      TextSpan(text: "Sign up ", style: StyleItem.titleTextStyle),
                                      const TextSpan(text: "to continue."),
                                    ]
                                )
                            )
                        ),

                        Padding(padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: userNameTextController,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.deepOrange.shade700,
                            //validator: validateNIDNumber,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: "Full name",
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
                        ),
                        Padding(padding: const EdgeInsets.all(8.0),
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
                        // input NID number
                        Padding(padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: nidNoTextController,
                            keyboardType: TextInputType.phone,
                            cursorColor: Colors.deepOrange.shade700,
                            validator: validateNIDNumber,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: "NID Number",
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
                        ),

                        // submitting button next
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: StyleItem.allPadding,
                              child: Text("Make a new account", style: StyleItem.textStyle,),
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              padding: StyleItem.allPadding,
                              child: ButtonTheme(

                                child: ElevatedButton(
                                  style:  ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff37474F)),
                                  ),
                                  onPressed: (){
                                    if( formKey.currentState!.validate()){
                                      //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing Data'))
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MakeProfile(mobNo: mobNoTextController.text,
                                            nidNo: nidNoTextController.text,userName: userNameTextController.text,))
                                      );
                                    }
                                    //checkNumberSeries();
                                  },
                                  child: const Text("Next",
                                    style: TextStyle(
                                      fontSize: 16,
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
                  // input mobile numbe
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
