class GSTModel {

  String? sSGSTAmt;
  String? sCGSTAmt;
  int? TGSTAmtRec;
  String? gstdue;
  int? tdsdue;
  int? tdsrec;
  int? isSuccess;
  String? message;

  GSTModel({
    this.sSGSTAmt,
    this.sCGSTAmt,
    this.TGSTAmtRec,
    this.gstdue,
    this.tdsdue,
    this.tdsrec,
    this.isSuccess,
    this.message,
  });
    
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