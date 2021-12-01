class GSTModel {
  GSTModel({
    required this.sSGSTAmt,
    required this.sCGSTAmt,
    required this.TGSTAmtRec,
    required this.gstdue,
    required this.tdsdue,
    required this.tdsrec,
    required this.isSuccess,
    required this.message,
  });
  late final String sSGSTAmt;
  late final String sCGSTAmt;
  late final int TGSTAmtRec;
  late final String gstdue;
  late final int tdsdue;
  late final int tdsrec;
  late final int isSuccess;
  late final String message;
  
  GSTModel.fromJson(Map<String, dynamic> json){
    sSGSTAmt = json['sSGSTAmt'];
    sCGSTAmt = json['sCGSTAmt'];
    TGSTAmtRec = json['TGSTAmtRec'];
    gstdue = json['gstdue'];
    tdsdue = json['tdsdue'];
    tdsrec = json['tdsrec'];
    isSuccess = json['isSuccess'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sSGSTAmt'] = sSGSTAmt;
    _data['sCGSTAmt'] = sCGSTAmt;
    _data['TGSTAmtRec'] = TGSTAmtRec;
    _data['gstdue'] = gstdue;
    _data['tdsdue'] = tdsdue;
    _data['tdsrec'] = tdsrec;
    _data['isSuccess'] = isSuccess;
    _data['message'] = message;
    return _data;
  }
}