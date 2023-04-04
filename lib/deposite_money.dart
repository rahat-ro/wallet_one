import 'package:flutter/material.dart';
import 'package:wallet_one/all_style_sheet/style_item.dart';
import 'package:wallet_one/profile/get_user_profile.dart';
import 'package:qr_flutter/qr_flutter.dart';


class DepositMoney extends StatefulWidget {
  final String walletId;
  const DepositMoney({Key? key, required this.walletId}) : super(key: key);

  @override
  State<DepositMoney> createState() => _DepositMoneyState();
}

class _DepositMoneyState extends State<DepositMoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange.shade700,
        title: const Text("Deposit Money"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              margin: StyleItem.allMargin,
              alignment: Alignment.center,
              child: QrImage(
                data: widget.walletId,
                version: QrVersions.auto,
                size: 200,
              ),
            ),
            Container(
              width: double.infinity,
              margin: StyleItem.allMargin,
              alignment: Alignment.center,
              child: Text("Show your QR to scan",style: StyleItem.titleTextStyleTwo,),
            ),
          ],
        ),
      ),
    );
  }
}
