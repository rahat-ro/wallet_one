import 'package:flutter/material.dart';

class StyleItem{

   static final titleTextStyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Colors.deepOrange.shade700);
   static final titleTextStyleTwo = TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Colors.blueGrey.shade800);
   static final titleAmount = TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.blueGrey.shade800);
   static final textStyle = TextStyle(fontWeight: FontWeight.normal,fontSize: 14, color: Colors.blueGrey.shade800);
   static final textStyleTwo = TextStyle(fontWeight: FontWeight.bold,fontSize: 14, color: Colors.deepOrange.shade700);


   static const String description = "Billing processor prepares sales invoice, calculates VAT and generates QR code and sends a sales invoice copy to the VAT collection queue. It receives payment from consumers. Billing processor prepares sales invoice, "
       "calculates VAT and generates QR code and sends a sales invoice copy to the VAT collection queue. It receives payment from consumers.";

   static const String poweredBy = "Powered by Revenue Board Authority";
   static const String forgot = "Forgotten pin";

   static const textStyleF =  TextStyle(fontWeight: FontWeight.normal,fontSize: 16, color: Colors.white);
   static const textStyle2F = TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Colors.white);

   // make profile style item

   static final mTextStyle = TextStyle(fontWeight: FontWeight.normal,fontSize: 16, color: Colors.blueGrey.shade800);
   static final mTextStyleN = TextStyle(fontWeight: FontWeight.normal,fontSize: 16, color: Colors.blueGrey.shade800);

   static final serviceName = TextStyle(fontSize: 16,fontWeight: FontWeight.normal,color: Colors.blueGrey.shade800);

   static const allPadding = EdgeInsets.all(8.0);
   static const allPadding2 = EdgeInsets.all(4.0);
   static const allMargin= EdgeInsets.all(8.0);

   // all text align
   static const textAlignLeft = TextAlign.left;
   static const textAlignCenter = TextAlign.center;

   // URL section http://192.168.0.102:8000

   static const rootURL = "http://192.168.2.101:8000";
   static const signUpText = "/signUP/consumers";
   static const signInText = "/signIn/consumers";
   static const getProfileText = "/getProfile/consumers";
   static const signUpURL = rootURL+signUpText;
   static const signInURL = rootURL+signInText;
   static const getProfileURL = rootURL+getProfileText;
   static const resetPin = "/resetPin/consumers";
   static const resetPinURL = rootURL+resetPin;


   //.......................send money to merchant......................

   static const rootURL2 = "http://192.168.2.101:8888";
   static const sendToMerchant =  "/sendMoney/to/merchant";
   static const sendToMerchantURL = rootURL2+sendToMerchant;

   static const updateBalanceToMerchant =  "/updateBalance/to/merchant";
   static const updateBalanceToMerchantURL =  rootURL+updateBalanceToMerchant;


   //.......................send money to merchant......................


   static const payToVatWallet =  "/payMoney/to/vatWallet";
   static const payToVatWalletURL = rootURL2+payToVatWallet;


   //.......................send money to Consumers......................


   static const sendToConsumers =  "/sendMoney/to/consumers";
   static const sendToConsumersURL = rootURL+sendToConsumers;

   static const updateBalanceToConsumers =  "/updateBalance/to/consumers";
   static const updateBalanceToConsumersURL =  rootURL+updateBalanceToConsumers;


   //.................. vat collection queue..........

   static const rootURLM = "http://192.168.2.101:8888";

   static const getDocVatCollectionData =  "/getDocFrom/vatQueue";
   static const getDocVatCollectionDataURL =  rootURLM+getDocVatCollectionData;

   static const fetchVatCollectionData =  "/fetch/vatCollectionQueue";
   static const fetchVatCollectionDataURl=  rootURLM+fetchVatCollectionData;

   static const updatePaymentStatusVatQueue =  "/updatePaymentStatus/vatQueue";
   static const updatePaymentStatusVatQueueURL =  rootURLM+updatePaymentStatusVatQueue;

   static const makeVatInvoice =  "/insert/vatInvoice";
   static const makeVatInvoiceURL =  rootURLM+makeVatInvoice;

   static const makeMerchantInvoice =  "/insert/merchantInvoice";
   static const makeMerchantInvoiceURL =  rootURLM+makeMerchantInvoice;

   //# vat invoice history for consumers

   static const getConsumerMerchantInvoice =  "/getConsumer/merchantInvoice";
   static const getConsumerMerchantInvoiceURL =  rootURLM+getConsumerMerchantInvoice;

   //# vat invoice history for consumers

   static const getConsumerVatInvoice =  "/getConsumer/vatInvoice";
   static const getConsumerVatInvoiceURL =  rootURLM+getConsumerVatInvoice;


   //# transaction history for consumers

   static const userTransactionHistory =  "/transactionHistory/of/consumers";
   static const userTransactionHistoryURL =  rootURL+userTransactionHistory;

   static const fetchUserTransactionHistory =  "/fetch/transactionHistory/of/consumers";
   static const fetchUserTransactionHistoryURL =  rootURL+fetchUserTransactionHistory;


}