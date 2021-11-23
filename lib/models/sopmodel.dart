
class Sopmodel {
    int? agrCount;
    List<DataAgr>? dataAgr;
    int? othchgCount;
    List<DataOthchg>? dataOthchg;
    int? isSuccess;
    String? status;
    String? message;

    Sopmodel({this.agrCount, this.dataAgr, this.othchgCount, this.dataOthchg, this.isSuccess, this.status, this.message});

    Sopmodel.fromJson(Map<String, dynamic> json) {
        this.agrCount = json["agrCount"];
        this.dataAgr = json["dataAgr"]==null ? null : (json["dataAgr"] as List).map((e)=>DataAgr.fromJson(e)).toList();
        this.othchgCount = json["OthchgCount"];
        this.dataOthchg = json["dataOthchg"]==null ? null : (json["dataOthchg"] as List).map((e)=>DataOthchg.fromJson(e)).toList();
        this.isSuccess = json["isSuccess"];
        this.status = json["status"];
        this.message = json["message"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["agrCount"] = this.agrCount;
        if(this.dataAgr != null)
            data["dataAgr"] = this.dataAgr?.map((e)=>e.toJson()).toList();
        data["OthchgCount"] = this.othchgCount;
        if(this.dataOthchg != null)
            data["dataOthchg"] = this.dataOthchg?.map((e)=>e.toJson()).toList();
        data["isSuccess"] = this.isSuccess;
        data["status"] = this.status;
        data["message"] = this.message;
        return data;
    }
}

class DataOthchg {
    String? docno;
    String? vdate;
    String? pdate;
    String? mth;
    String? part1;
    String? part2;
    String? amt;

    DataOthchg({this.docno, this.vdate, this.pdate, this.mth, this.part1, this.part2, this.amt});

    DataOthchg.fromJson(Map<String, dynamic> json) {
        this.docno = json["docno"];
        this.vdate = json["vdate"];
        this.pdate = json["pdate"];
        this.mth = json["mth"];
        this.part1 = json["part1"];
        this.part2 = json["part2"];
        this.amt = json["Amt"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["docno"] = this.docno;
        data["vdate"] = this.vdate;
        data["pdate"] = this.pdate;
        data["mth"] = this.mth;
        data["part1"] = this.part1;
        data["part2"] = this.part2;
        data["Amt"] = this.amt;
        return data;
    }
}

class DataAgr {
    String? docno;
    String? vdate;
    String? pdate;
    String? mth;
    String? part1;
    String? part2;
    String? amt;

    DataAgr({this.docno, this.vdate, this.pdate, this.mth, this.part1, this.part2, this.amt});

    DataAgr.fromJson(Map<String, dynamic> json) {
        this.docno = json["docno"];
        this.vdate = json["vdate"];
        this.pdate = json["pdate"];
        this.mth = json["mth"];
        this.part1 = json["part1"];
        this.part2 = json["part2"];
        this.amt = json["Amt"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["docno"] = this.docno;
        data["vdate"] = this.vdate;
        data["pdate"] = this.pdate;
        data["mth"] = this.mth;
        data["part1"] = this.part1;
        data["part2"] = this.part2;
        data["Amt"] = this.amt;
        return data;
    }
}