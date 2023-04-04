import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet_one/all_style_sheet/style_item.dart';
import 'package:wallet_one/auth/auth_api.dart';
import 'package:wallet_one/deposite_money.dart';
import 'package:wallet_one/nav_item/invoice.dart';
import 'package:wallet_one/nav_item/transaction_history.dart';
import 'package:wallet_one/profile/get_user_profile.dart';
import 'package:wallet_one/profile/profile_info.dart';
import 'package:wallet_one/profile/user_data_model.dart';
import 'package:wallet_one/pyment_process/scan_qr_code.dart';
import 'package:wallet_one/send_money/send_money.dart';
import 'package:get/get.dart';
import 'package:wallet_one/auth/sign_in.dart';
import 'package:wallet_one/transaction/user_transaction_history.dart';

import '../transaction/transaction_history_model.dart';



class Home extends StatefulWidget {
  final String mobNo;
  const Home({Key? key, required this.mobNo}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  static String? userName;
  static String? mobNoGet;
  static String? nidNo;
  static String? walletId;
  static String? pin;
  static double? amount;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      GetUserProfile.getProfile(widget.mobNo);
      UserTransactionHistory.fetchUserTransactionHistory(GetUserProfile.walletId);
      print(GetUserProfile.walletId);

    });

    super.initState();
  }


  late int _selectedIndex = 0;
  final double _groupAlignment = 1;

  late UserDataModel userDataModel;


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.deepOrange,
    ));
    return Scaffold(

      body: SafeArea(
        child: Row(
          children: [

            Padding(padding: const EdgeInsets.only(top: 4.0,right: 4.0,left: 4.0,bottom: 4.0),
              child: NavigationRail(
                backgroundColor: Colors.deepOrange.shade700,
                elevation: 2,
                minWidth: 56,
                destinations: const [
                  NavigationRailDestination(
                    label: RotatedBox(
                      quarterTurns: 3,
                      child: Text('Invoice',style: TextStyle(color: Colors.white)),
                    ),
                    icon: RotatedBox(
                      quarterTurns: 3,
                      child: Icon(Icons.add_chart_outlined,color: Colors.white),
                    ),

                  ),

                  NavigationRailDestination(
                    label: RotatedBox(
                      quarterTurns: 3,
                      child: Text('Transaction History', style: TextStyle(color: Colors.white),),
                    ),
                    icon: RotatedBox(
                        quarterTurns: 3,
                        child: Icon(Icons.history,color: Colors.white)
                    ),
                  ),

                  NavigationRailDestination(
                    label: RotatedBox(
                      quarterTurns: 3,
                      child: Text('Settings',style: TextStyle(color: Colors.white)),
                    ),
                    icon: RotatedBox(
                      quarterTurns: 3,
                      child: Icon(Icons.settings_applications_outlined,color: Colors.white),
                    ),

                  ),

                  NavigationRailDestination(
                    label: RotatedBox(
                      quarterTurns: 3,
                      child: Text('Sing out', style: TextStyle(color: Colors.white),),
                    ),
                    icon: RotatedBox(
                        quarterTurns: 3,
                        child: Icon(
                          Icons.login_outlined,
                          color: Colors.white,
                        )
                    ),
                  ),
                ],
                selectedIndex: _selectedIndex,
                groupAlignment: _groupAlignment,
                onDestinationSelected: (int index){
                  setState(() {
                    _selectedIndex = index;
                    switch(index){
                      case 0: Get.to(() =>  const Invoice());
                      break;
                      case 1: Get.to(() =>  const TransactionHistory());
                      break;
                      case 2: Get.to(() =>  const ProfileInfo());
                      break;
                      case 3: Get.to(() =>  const SignIn());
                    }

                  });
                },
                labelType: NavigationRailLabelType.all,
                leading: InkWell(
                  onTap: (){
                    Get.to(() =>  const ProfileInfo());
                  },
                  child: const Icon(Icons.person_pin, color: Colors.white),
                ),

              ),
            ),
            // navigation rail
            Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                        elevation: 2,
                        shadowColor: Colors.blueGrey.shade800,
                        color: Colors.deepOrange.shade700,
                        child: FutureBuilder<UserDataModel>(
                          future: GetUserProfile.getProfile(widget.mobNo),
                            builder: (context,AsyncSnapshot<UserDataModel> snapshot){
                              if(snapshot.hasData){
                                walletId = snapshot.data?.walletIdG as String;
                                return SizedBox(
                                  height: 156,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(padding: const EdgeInsets.all(8.0),
                                            child: Text(snapshot.data?.userNameG as String,
                                              style: const TextStyle(fontSize: 16,color: Colors.white),
                                            ),
                                          ),
                                          Spacer(),
                                          const Padding(padding: EdgeInsets.all(8.0),
                                              child: Icon(Icons.notifications,color: Colors.white,)
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      const Padding(padding: EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: 1,
                                          width: double.infinity,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Padding(padding: EdgeInsets.all(8.0),
                                            child: Text("Wallet ID",
                                              style: TextStyle(fontSize: 16,color: Colors.white),
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(padding: EdgeInsets.all(8.0),
                                            child: Text(GetUserProfile.walletId.toString(),
                                              style: TextStyle(fontSize: 16,color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                            height: 40,
                                            width: double.infinity,
                                            child: DecoratedBox(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Padding(padding: const EdgeInsets.all(8.0),
                                                      child: InkWell(
                                                        onTap: (){
                                                          setState(() {
                                                            GetUserProfile.getProfile(widget.mobNo);
                                                          });
                                                        },
                                                        child: Icon(Icons.touch_app,color: Colors.blueGrey.shade800,),
                                                      ),
                                                  ),
                                                  Padding(padding: const EdgeInsets.all(8.0),
                                                    child: Text(GetUserProfile.amount!.toStringAsFixed(2).toString(),
                                                      style: TextStyle(fontSize: 16,color: Colors.blueGrey.shade800),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                        ),
                                      )
                                    ],
                                  ),
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: InkWell(
                              onTap: (){
                                Get.to( ()=> ScanQrCode(mobNo: widget.mobNo,));
                              },
                              splashColor: Colors.deepOrange.shade100,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Ink.image(
                                      image: const AssetImage('assets/images/payment.png'),
                                      height: 48,
                                      width: 48,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: SizedBox(

                                      child: Text(
                                        'Payment',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16,color: Colors.blueGrey.shade800,),
                                      ),

                                    ),
                                  ),

                                ],
                              ),
                            )),
                        Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: InkWell(
                              onTap: (){
                                print(widget.mobNo);
                              },
                              splashColor: Colors.deepOrange.shade100,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Ink.image(
                                      image: const AssetImage('assets/images/bill.png'),
                                      height: 48,
                                      width: 48,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: SizedBox(

                                      child: Text(
                                        'Pay bill',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16,color: Colors.blueGrey.shade800),
                                      ),

                                    ),
                                  ),

                                ],
                              ),
                            )),
                        Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const SendMoney()));
                              },
                              splashColor: Colors.deepOrange.shade100,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Ink.image(
                                      image: const AssetImage('assets/images/send_money.png'),
                                      height: 48,
                                      width: 48,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: SizedBox(

                                      child: Text(
                                        'Send money',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16,color: Colors.blueGrey.shade800),
                                      ),

                                    ),
                                  ),

                                ],
                              ),
                            )),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Card(
                            elevation: 1,
                            shadowColor: Colors.deepOrange.shade700,
                            color: Colors.blueGrey.shade100,
                            child: InkWell(
                              onTap: (){
                                Get.to(() => DepositMoney(walletId: GetUserProfile.walletId.toString(),));
                              },
                              splashColor: Colors.deepOrange.shade50,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Ink.image(
                                      image: const AssetImage('assets/images/deposit.png'),
                                      height: 48,
                                      width: 48,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(

                                      child: Text(
                                        'Deposit money',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16,color: Colors.blueGrey.shade800),
                                      ),

                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Card(
                            elevation: 2,
                            shadowColor: Colors.deepOrange.shade700,
                            color: Colors.blueGrey.shade800,
                            child: InkWell(
                              onTap: (){
                                Get.to( ()=> ScanQrCode(mobNo: widget.mobNo,));
                              },
                              splashColor: Colors.deepOrange.shade100,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Ink.image(
                                      image: const AssetImage('assets/images/subscription_fee.png'),
                                      height: 48,
                                      width: 48,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      child: Text(
                                        'Subscription fee',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16,color: Colors.white),
                                      ),

                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),),
                      ],
                    ),
                    Padding(padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: Text("Last Transaction",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18,color: Colors.blueGrey.shade800,fontWeight: FontWeight.bold,),
                        ),
                      ),
                    ),
                    Expanded(child: FutureBuilder<List<TransactionHistoryModel>>(
                        future: UserTransactionHistory.fetchUserTransactionHistory(AuthApi.walletId),
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context,index){
                                  return Card(
                                    elevation: 1,
                                    shadowColor: Colors.deepOrange.shade700,
                                    child: ListTile(
                                      title:  Text(snapshot.data![index].receiver.toString()),
                                      subtitle: Text(snapshot.data![index].amount.toString()),
                                      trailing: const Icon(Icons.money),
                                    ),
                                  );
                                }
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
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
