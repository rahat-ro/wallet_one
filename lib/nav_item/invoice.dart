import 'package:flutter/material.dart';
import 'package:wallet_one/auth/auth_api.dart';
import '../all_style_sheet/style_item.dart';
import '../invoice/fetch_invoice.dart';
import '../invoice/merchant_invoice_model.dart';
import '../invoice/vat_invoice_model.dart';

class Invoice extends StatefulWidget {
  const Invoice({Key? key}) : super(key: key);

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Invoices"),
            centerTitle: true,
            backgroundColor: Colors.deepOrange.shade700,
            bottom:  const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.add_chart_outlined,color: Colors.white),
                  text: "Merchant Invoice",
                ),
                Tab(
                  icon: Icon(Icons.add_chart_outlined,color: Colors.white),
                  text: "VAT Invoice",
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
                        children: [
                          Row(
                            children: [
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Padding(
                                    padding: StyleItem.allPadding,
                                    child: Text("Date Time:", style: StyleItem.serviceName),
                                  )
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
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: StyleItem.allPadding,
                                  child: Text("Invoice ID:", style: StyleItem.serviceName),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: StyleItem.allPadding,
                                  child: Text(snapshot.data![index].invoiceIdG.toString(), style: StyleItem.serviceName),
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
                                  child: Text("VAT query Id:", style: StyleItem.serviceName),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: StyleItem.allPadding,
                                  child: Text(snapshot.data![index].queueIdG.toString(), style: StyleItem.serviceName),
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
                                  child: Text("Merchant Wallet ID :", style: StyleItem.serviceName,),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: StyleItem.allPadding,
                                  child: Text(snapshot.data![index].merchantWalletIdG.toString(), style: StyleItem.serviceName),
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
                                  child: Text("Consumer Wallet Id:", style: StyleItem.serviceName),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: StyleItem.allPadding,
                                  child: Text(snapshot.data![index].consumerWalletIdG.toString(), style: StyleItem.serviceName),
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
                                  child: Text("Payable Amount:", style: StyleItem.serviceName),
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
                                  child: Text("Payment Status:", style: StyleItem.serviceName),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: StyleItem.allPadding,
                                  child: Text(snapshot.data![index].paymentStatusG.toString(), style: StyleItem.serviceName),
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Padding(
                                    padding: StyleItem.allPadding,
                                    child: Text("Date Time:", style: StyleItem.serviceName),
                                  )
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
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: StyleItem.allPadding,
                                  child: Text("VAT Invoice ID:", style: StyleItem.serviceName),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: StyleItem.allPadding,
                                  child: Text(snapshot.data![index].vatIdG.toString(), style: StyleItem.serviceName),
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
                                  child: Text("VAT query Id:", style: StyleItem.serviceName),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: StyleItem.allPadding,
                                  child: Text(snapshot.data![index].queueIdG.toString(), style: StyleItem.serviceName),
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
                                  child: Text("Merchant Wallet ID :", style: StyleItem.serviceName,),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: StyleItem.allPadding,
                                  child: Text(snapshot.data![index].vatWalletIdG.toString(), style: StyleItem.serviceName),
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
                                  child: Text("Consumer Wallet Id:", style: StyleItem.serviceName),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: StyleItem.allPadding,
                                  child: Text(snapshot.data![index].consumerWalletIdG.toString(), style: StyleItem.serviceName),
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
                                  child: Text("Payable Amount:", style: StyleItem.serviceName),
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
                                  child: Text("Payment Status:", style: StyleItem.serviceName),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: StyleItem.allPadding,
                                  child: Text(snapshot.data![index].paymentStatusG.toString(), style: StyleItem.serviceName),
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
