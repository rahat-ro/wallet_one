class VatCollectionModel{

  String? _date;
  String? _id;
  String? _merchantWalletId;
  String? _vatWalletId;
  String? _paymentStatus;
  String? _additionalData;
  double? _amount;
  double? _vat;

  VatCollectionModel(
      this._date,
      this._id,
      this._merchantWalletId,
      this._vatWalletId,
      this._paymentStatus,
      this._additionalData,
      this._amount,
      this._vat);

  VatCollectionModel.fromJson(Map<String, dynamic> json){
    _date = json["date"];
    _id = json["id"];
    _merchantWalletId = json["merchantWalletId"];
    _vatWalletId = json["vatWalletId"];
    _paymentStatus = json["paymentStatus"];
    _additionalData = json["additionalData"];
    _amount = json["amount"];
    _vat = json["vat"];

  }

  Map<String,dynamic> toJson(){
    final data = <String, dynamic>{};
    data["date"] = _date;
    data["id"] = _id;
    data["merchantWalletId"] = _merchantWalletId;
    data["vatWalletId"] = _vatWalletId;
    data["paymentStatus"] = _paymentStatus;
    data["additionalData"] = _additionalData;
    data["amount"] = _amount;
    data["vat"] = _vat;
    return data;
  }

  double? get vatG => _vat;

  set vat(double value) {
    _vat = value;
  }

  double? get amountG => _amount;

  set amount(double value) {
    _amount = value;
  }

  String? get additionalDataG => _additionalData;

  set additionalData(String value) {
    _additionalData = value;
  }

  String? get paymentStatusG => _paymentStatus;

  set paymentStatus(String value) {
    _paymentStatus = value;
  }

  String? get vatWalletIdG => _vatWalletId;

  set vatWalletId(String value) {
    _vatWalletId = value;
  }

  String? get merchantWalletIdG => _merchantWalletId;

  set merchantWalletId(String value) {
    _merchantWalletId = value;
  }

  String? get idG => _id;

  set id(String value) {
    _id = value;
  }

  String? get dateG => _date;

  set date(String value) {
    _date = value;
  }
}