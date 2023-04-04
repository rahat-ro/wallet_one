class MerchantInvoiceModel{
  String? _dateTime;
  String? _invoiceId;
  String? _queueId;
  String? _consumerWalletId;
  String? _merchantWalletId;
  String? _payableAmount;
  String? _paymentStatus;

  MerchantInvoiceModel(
      this._dateTime,
      this._invoiceId,
      this._queueId,
      this._consumerWalletId,
      this._merchantWalletId,
      this._payableAmount,
      this._paymentStatus);

  MerchantInvoiceModel.fromJson(Map<String,dynamic>json){
    _dateTime = json["dateTime"];
    _invoiceId = json["mId"];
    _queueId = json["queueId"];
    _consumerWalletId = json["consumerWalletId"];
    _merchantWalletId = json["merchantWalletId"];
    _payableAmount = json["payableAmount"];
    _paymentStatus = json["paymentStatus"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["dateTime"] = _dateTime;
    data["mId"] = _invoiceId;
    data["queueId"] = _queueId;
    data["consumerWalletId"] = _consumerWalletId;
    data["merchantWalletId"] = _merchantWalletId;
    data["payableAmount"] = _payableAmount;
    data["paymentStatus"] = _paymentStatus;
    return data;
  }

  String? get paymentStatusG => _paymentStatus;

  set paymentStatus(String value) {
    _paymentStatus = value;
  }

  String? get payableAmountG => _payableAmount;

  set payableAmount(String value) {
    _payableAmount = value;
  }

  String? get merchantWalletIdG => _merchantWalletId;

  set merchantWalletId(String value) {
    _merchantWalletId = value;
  }

  String? get consumerWalletIdG => _consumerWalletId;

  set consumerWalletId(String value) {
    _consumerWalletId = value;
  }

  String? get queueIdG => _queueId;

  set queueId(String value) {
    _queueId = value;
  }

  String? get invoiceIdG => _invoiceId;

  set invoiceId(String value) {
    _invoiceId = value;
  }

  String? get dateTimeG => _dateTime;

  set dateTime(String value) {
    _dateTime = value;
  }
}