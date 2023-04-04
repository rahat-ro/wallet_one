class VatInvoiceModel{
  String? _dateTime;
  String? _vatId;
  String? _queueId;
  String? _consumerWalletId;
  String? _vatWalletId;
  String? _payableVatAmount;
  String? _paymentStatus;

  VatInvoiceModel(
      this._dateTime,
      this._vatId,
      this._queueId,
      this._consumerWalletId,
      this._vatWalletId,
      this._payableVatAmount,
      this._paymentStatus);

  VatInvoiceModel.fromJson(Map<String,dynamic>json){
    _dateTime = json["dateTime"];
    _vatId = json["vatId"];
    _queueId = json["queueId"];
    _consumerWalletId = json["consumerWalletId"];
    _vatWalletId = json["vatWalletId"];
    _payableVatAmount = json["payableVatAmount"];
    _paymentStatus = json["paymentStatus"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["dateTime"] = _dateTime;
    data["vatId"] = _vatId;
    data["queueId"] = _queueId;
    data["consumerWalletId"] = _consumerWalletId;
    data["vatWalletId"] = _vatWalletId;
    data["payableVatAmount"] = _payableVatAmount;
    data["paymentStatus"] = _paymentStatus;
    return data;
  }


  String? get paymentStatusG => _paymentStatus;

  set paymentStatus(String value) {
    _paymentStatus = value;
  }

  String? get payableVatAmountG => _payableVatAmount;

  set payableVatAmount(String value) {
    _payableVatAmount = value;
  }

  String? get vatWalletIdG => _vatWalletId;

  set vatWalletId(String value) {
    _vatWalletId = value;
  }

  String? get consumerWalletIdG => _consumerWalletId;

  set consumerWalletId(String value) {
    _consumerWalletId = value;
  }

  String? get queueIdG => _queueId;

  set queueId(String value) {
    _queueId = value;
  }

  String? get vatIdG => _vatId;

  set vatId(String value) {
    _vatId = value;
  }

  String? get dateTimeG => _dateTime;

  set dateTime(String value) {
    _dateTime = value;
  }
}