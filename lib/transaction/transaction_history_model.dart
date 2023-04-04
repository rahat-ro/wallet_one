class TransactionHistoryModel{
   String? dateTime;
   String? receiver;
   String? amount;
   String? sender;

   TransactionHistoryModel(
      this.dateTime, this.receiver, this.amount, this.sender);

   TransactionHistoryModel.fromJson(Map<String,dynamic>json){
     dateTime = json["dateTime"];
     receiver = json["receiver"];
     amount = json["amount"];
     sender = json["sender"];

   }

   Map<String, dynamic> toJson() {
     final data = <String, dynamic>{};
     data["dateTime"] = dateTime;
     data["receiver"] = receiver;
     data["amount"] = amount;
     data["sender"] = sender;

     return data;
   }

}