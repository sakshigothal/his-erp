
class NotificationModel {
    int? docCount;
    List<Data>? data;
    int? isSuccess;
    String? status;
    String? message;

    NotificationModel({this.docCount, this.data, this.isSuccess, this.status, this.message});

    NotificationModel.fromJson(Map<String, dynamic> json) {
        this.docCount = json["docCount"];
        this.data = json["data"]==null ? null : (json["data"] as List).map((e)=>Data.fromJson(e)).toList();
        this.isSuccess = json["isSuccess"];
        this.status = json["status"];
        this.message = json["message"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["docCount"] = this.docCount;
        if(this.data != null)
            data["data"] = this.data?.map((e)=>e.toJson()).toList();
        data["isSuccess"] = this.isSuccess;
        data["status"] = this.status;
        data["message"] = this.message;
        return data;
    }
}

class Data {
    String? nTitle;
    String? nDate;
    String? nMessage;

    Data({this.nTitle, this.nDate, this.nMessage});

    Data.fromJson(Map<String, dynamic> json) {
        this.nTitle = json["NTitle"];
        this.nDate = json["NDate"];
        this.nMessage = json["NMessage"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["NTitle"] = this.nTitle;
        data["NDate"] = this.nDate;
        data["NMessage"] = this.nMessage;
        return data;
    }
}