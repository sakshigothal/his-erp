class Documents {
  int? docCount;
  List<Data>? data;
  int? isSuccess;
  String? status;
  String? message;

  Documents(
      {this.docCount, this.data, this.isSuccess, this.status, this.message});

  Documents.fromJson(Map<String, dynamic> json) {
    this.docCount = json["docCount"];
    this.data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    this.isSuccess = json["isSuccess"];
    this.status = json["status"];
    this.message = json["message"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["docCount"] = this.docCount;
    if (this.data != null)
      data["data"] = this.data?.map((e) => e.toJson()).toList();
    data["isSuccess"] = this.isSuccess;
    data["status"] = this.status;
    data["message"] = this.message;
    return data;
  }
}

class Data {
  String? id;
  String? ownerid;
  String? docName;
  String? docLink;

  Data({this.id, this.ownerid, this.docName, this.docLink});

  Data.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.ownerid = json["ownerid"];
    this.docName = json["doc_name"];
    this.docLink = json["doc_link"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["ownerid"] = this.ownerid;
    data["doc_name"] = this.docName;
    data["doc_link"] = this.docLink;
    return data;
  }
}
