class UserDataModel{
  late String? _userName;
  late String? _mobNo;
  late String? _nidNo;
  late String? _walletId;
  late double? _amount;
  late String? _pin;

  UserDataModel(this._userName,
      this._mobNo,
      this._nidNo,
      this._walletId,
      this._amount,
      this._pin);

  UserDataModel.fromJson(Map<String,dynamic>json){
    _userName = json["userName"];
    _mobNo = json["mobNo"];
    _nidNo = json["nidNo"];
    _walletId = json["walletId"];
    _amount = json["amount"];
    _pin = json["pin"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["userName"] = _userName;
    data["mobNo"] = _mobNo;
    data["nidNo"] = _nidNo;
    data["walletId"] = _walletId;
    data["amount"] = _amount;
    data["pin"] = _pin;
    return data;
  }

  String? get pinG => _pin;

  set pin(String value) {
    _pin = value;
  }

  double? get amountG => _amount;

  set amount(double value) {
    _amount = value;
  }

  String? get walletIdG => _walletId;

  set walletId(String value) {
    _walletId = value;
  }

  String? get nidNoG => _nidNo;

  set nidNo(String value) {
    _nidNo = value;
  }

  String? get mobNoG => _mobNo;

  set mobNo(String value) {
    _mobNo = value;
  }

  String? get userNameG => _userName;

  set userName(String value) {
    _userName = value;
  }
}