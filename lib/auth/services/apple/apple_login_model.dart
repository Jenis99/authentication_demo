class AppleLoginModel {
  int? status;
  String? message;
  User? user;
  String? accessToken;
  String? refreshToken;

  AppleLoginModel(
      {this.status,
        this.message,
        this.user,
        this.accessToken,
        this.refreshToken});

  AppleLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    return data;
  }
}

class User {
  String? sId;
  String? email;
  bool? isVerify;
  bool? isPart1;
  bool? isPart2;
  bool? isPart3;

  User(
      {this.sId,
        this.email,
        this.isVerify,
        this.isPart1,
        this.isPart2,
        this.isPart3});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    isVerify = json['isVerify'];
    isPart1 = json['isPart1'];
    isPart2 = json['isPart2'];
    isPart3 = json['isPart3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['email'] = email;
    data['isVerify'] = isVerify;
    data['isPart1'] = isPart1;
    data['isPart2'] = isPart2;
    data['isPart3'] = isPart3;
    return data;
  }
}
