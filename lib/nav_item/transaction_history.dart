import 'package:flutter/material.dart';
import '../all_style_sheet/style_item.dart';
import '../auth/auth_api.dart';
import '../invoice/fetch_invoice.dart';
import '../invoice/merchant_invoice_model.dart';
import '../invoice/vat_invoice_model.dart';



class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Transaction History"),
            centerTitle: true,
            backgroundColor: Colors.deepOrange.shade700,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.add_chart_outlined,color: Colors.white),
                  text: "Merchant Payment",
                ),
                Tab(
                  icon: Icon(Icons.add_chart_outlined,color: Colors.white),
                  text: "VAT Payment",
                ),
              ],

            ),
          ),
          body: TabBarView(
            children: [
              fetchMerchantInvoice(),
              fetchVatInvoice(),

            ],
          ),
        )
    );
  }

  Widget fetchMerchantInvoice(){
    return Material(
      elevation: 2,
      child: FutureBuilder<List<MerchantInvoiceModel>>(
          future: FetchInvoice.merchantInvoice(AuthApi.walletId),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index){
                    return Card(
                      elevation: 2,
                      margin: StyleItem.allMargin,
                      shadowColor: Colors.deepOrange.shade800,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding: StyleItem.allPadding2,
                              child: Text("From,", style: StyleItem.serviceName,textAlign: TextAlign.start,),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding: StyleItem.allPadding2,
                              child: Text(snapshot.data![index].consumerWalletIdG.toString(), style: StyleItem.serviceName,textAlign: TextAlign.end),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding: StyleItem.allPadding,
                              child: Text("To,", style: StyleItem.serviceName,textAlign: TextAlign.start),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding: StyleItem.allPadding,
                              child: Text(snapshot.data![index].merchantWalletIdG.toString(), style: StyleItem.serviceName,textAlign: TextAlign.end),
                            ),
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
                                  child: Text("Amount", style: StyleItem.serviceName),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: StyleItem.allPadding,
                                  child: Text(snapshot.data![index].payableAmountG.toString(), style: StyleItem.serviceName),
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
                                  child: Text("Date-time", style: StyleItem.serviceName,),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: StyleItem.allPadding,
                                  child: Text(snapshot.data![index].dateTimeG.toString(), style: StyleItem.serviceName),
                                ),
                              ),
                            ],
                          ),

                        ],
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
    );
  }

  Widget fetchVatInvoice(){
    return Material(
      elevation: 2,
      child: FutureBuilder<List<VatInvoiceModel>>(
          future: FetchInvoice.vatInvoice(AuthApi.walletId),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index){
                    return Card(
                      elevation: 2,
                      margin: StyleItem.allMargin,
                      shadowColor: Colors.deepOrange.shade800,
                      child:  Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding: StyleItem.allPadding2,
                              child: Text("From,", style: StyleItem.serviceName,textAlign: TextAlign.start,),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding: StyleItem.allPadding2,
                              child: Text(snapshot.data![index].consumerWalletIdG.toString(), style: StyleItem.serviceName,textAlign: TextAlign.end),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding: StyleItem.allPadding,
                              child: Text("To,", style: StyleItem.serviceName,textAlign: TextAlign.start),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding: StyleItem.allPadding,
                              child: Text(snapshot.data![index].vatWalletIdG.toString(), style: StyleItem.serviceName,textAlign: TextAlign.end),
                            ),
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
                                  child: Text("Amount", style: StyleItem.serviceName),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: StyleItem.allPadding,
                                  child: Text(snapshot.data![index].payableVatAmountG.toString(), style: StyleItem.serviceName),
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
                                  child: Text("Date-time", style: StyleItem.serviceName,),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: StyleItem.allPadding,
                                  child: Text(snapshot.data![index].dateTimeG.toString(), style: StyleItem.serviceName),
                                ),
                              ),
                            ],
                          ),

                        ],
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
    );
  }

}
