class profile_main {
  int? isSuccess;
  String? message;
  String? projnam;
  String? bbuildNam;
  String? oflatNo;
  String? oownerNam;
  String? obookngDt;
  String? oownerN2;
  String? oownerN3;
  String? oadd;
  String? oownerCell;
  String? email;
  String? carpetSqft;
  String? carpetSqmt;
  String? tamtpay;
  String? tamtdue;
  String? tamtrec;
  String? overdue;
  String? tamtbalance;
  String? cpname;
  String? gstpc;
  String? intrate;
  String? sdamt;
  String ? sddet;
  String? regamt;
  String? advmaint;
  String? LOANBANKN;
  String? NOCDATE;
  String? LACCOUNTNO;
  String? LOANAMT;
  String? CONTACTP;
  String? ALLOT_DT;
  String? AGREE_DT;
  String? REGDT;
  String? POSSESS_DT;
  String? OCDATE;
  String? UnreadNotifications;



  profile_main(
      {this.isSuccess,
      this.message,
      this.projnam,
      this.bbuildNam,
      this.oflatNo,
      this.oownerNam,
      this.obookngDt,
      this.oownerN2,
      this.oownerN3,
      this.oadd,
      this.oownerCell,
      this.email,
      this.carpetSqft,
      this.carpetSqmt,
      this.tamtpay,
      this.tamtdue,
      this.tamtrec,
      this.overdue,
      this.tamtbalance,
      this.cpname,
      this.gstpc,
      this.intrate,
      this.sdamt,
      this.sddet,
      this.regamt,
      this.advmaint,
      this.LOANBANKN,
      this.NOCDATE,
      this.LACCOUNTNO,
      this.LOANAMT,
      this.CONTACTP,
      this.ALLOT_DT,
      this.AGREE_DT,
      this.REGDT,
      this.POSSESS_DT,
      this.OCDATE,
      this.UnreadNotifications});

  profile_main.fromJson(Map<String, dynamic> json) {
    this.isSuccess = json["isSuccess"];
    this.message = json["message"];
    this.projnam = json["PROJNAM"];
    this.bbuildNam = json["BBUILD_NAM"];
    this.oflatNo = json["OFLAT_NO"];
    this.oownerNam = json["OOWNER_NAM"];
    this.obookngDt = json["OBOOKNG_DT"];
    this.oownerN2 = json["OOWNER_N2"];
    this.oownerN3 = json["OOWNER_N3"];
    this.oadd = json["OADD"];
    this.oownerCell = json["OOWNER_CELL"];
    this.email = json["EMAIL"];
    this.carpetSqft = json["CarpetSQFT"];
    this.carpetSqmt = json["CarpetSQMT"];
    this.tamtpay = json["TAMTPAY"];
    this.tamtdue = json["TAMTDUE"];
    this.tamtrec = json["TAMTREC"];
    this.overdue = json["OVERDUE"];
    this.tamtbalance = json["TAMTBALANCE"];
    this.cpname = json["CPNAME"];
    this.gstpc = json["GSTPC"];
    this.intrate = json["INTRATE"];
    this.sdamt = json["SDAMT"];
    this.sddet=json["SDDET"];
    this.regamt = json["REGAMT"];
    this.advmaint = json["ADVMAINT"];
    this.LOANBANKN = json["LOANBANKN"];
    this.NOCDATE=json["NOCDATE"];
    this.LACCOUNTNO = json["LACCOUNTNO"];
    this.LOANAMT = json["LOANAMT"];
    this.CONTACTP = json["CONTACTP"];
    this.ALLOT_DT = json["ALLOT_DT"];
    this.AGREE_DT = json["AGREE_DT"];
    this.REGDT = json["REGDT"];
    this.POSSESS_DT = json["POSSESS_DT"];
    this.OCDATE = json["OCDATE"];
    this.UnreadNotifications=json["UnreadNotifications"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["isSuccess"] = this.isSuccess;
    data["message"] = this.message;
    data["PROJNAM"] = this.projnam;
    data["BBUILD_NAM"] = this.bbuildNam;
    data["OFLAT_NO"] = this.oflatNo;
    data["OOWNER_NAM"] = this.oownerNam;
    data["OBOOKNG_DT"] = this.obookngDt;
    data["OOWNER_N2"] = this.oownerN2;
    data["OOWNER_N3"] = this.oownerN3;
    data["OADD"] = this.oadd;
    data["OOWNER_CELL"] = this.oownerCell;
    data["EMAIL"] = this.email;
    data["CarpetSQFT"] = this.carpetSqft;
    data["CarpetSQMT"] = this.carpetSqmt;
    data["TAMTPAY"] = this.tamtpay;
    data["TAMTDUE"] = this.tamtdue;
    data["TAMTREC"] = this.tamtrec;
    data["OVERDUE"] = this.overdue;
    data["TAMTBALANCE"] = this.tamtbalance;
    data["CPNAME"] = this.cpname;
    data["GSTPC"] = this.gstpc;
    data["INTRATE"] = this.intrate;
    data["SDAMT"] = this.sdamt;
    data["SDDET"]=this.sddet;
    data["REGAMT"] = this.regamt;
    data["ADVMAINT"] = this.advmaint;
    data["LOANBANKN"] = this.LOANBANKN;
    data["NOCDATE"]= this.NOCDATE;
    data["LACCOUNTNO"] = this.LACCOUNTNO;
    data["LOANAMT"] = this.LOANAMT;
    data["CONTACTP"] = this.CONTACTP;
    data["ALLOT_DT"] = this.ALLOT_DT;
    data["AGREE_DT"] = this.AGREE_DT;
    data["REGDT"] = this.REGDT;
    data["POSSESS_DT"] = this.POSSESS_DT;
    data["OCDATE"] = this.OCDATE;
    data["UnreadNotifications"]=this.UnreadNotifications;
    return data;
  }
}
