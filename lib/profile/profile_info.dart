import 'package:flutter/material.dart';
import 'package:wallet_one/all_style_sheet/style_item.dart';
import 'package:wallet_one/auth/auth_api.dart';



class ProfileInfo extends StatefulWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange.shade700,
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: Colors.blueGrey.shade100,
          child: Card(
            elevation: 2,
            shadowColor: Colors.deepOrange.shade700,
            margin: StyleItem.allMargin,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: StyleItem.allMargin,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/avatar.jpg',
                    height: 180,
                    width: 180,
                  ),
                ),
                Padding(padding: StyleItem.allPadding,
                  child: Text(AuthApi.userName.toString(), style: StyleItem.titleTextStyleTwo,),
                ),
                Padding(padding: StyleItem.allPadding,
                  child: Text(AuthApi.amount?.toStringAsFixed(2) as String, style: StyleItem.titleAmount,),
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
                      child: Padding(
                        padding: StyleItem.allPadding,
                        child: Text("Mobile number", style: StyleItem.titleTextStyleTwo,textAlign: TextAlign.right,),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: StyleItem.allPadding,
                        child: Text(AuthApi.mobNoG.toString(), style: StyleItem.titleTextStyleTwo,),
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
                        child: Text("Wallet ID", style: StyleItem.titleTextStyleTwo,textAlign: TextAlign.right),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: StyleItem.allPadding,
                        child: Text(AuthApi.walletId.toString(), style: StyleItem.titleTextStyleTwo,),
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
                        child: Text("NID", style: StyleItem.titleTextStyleTwo,textAlign: TextAlign.right),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: StyleItem.allPadding,
                        child: Text(AuthApi.nidNo.toString(), style: StyleItem.titleTextStyleTwo,),
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
                        child: Text("Pin", style: StyleItem.titleTextStyleTwo,textAlign: TextAlign.right),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: StyleItem.allPadding,
                        child: Text(AuthApi.pinG.toString(), style: StyleItem.titleTextStyleTwo,),
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

              ],
            ),
          ),
        )
      ),
    );
  }
}
