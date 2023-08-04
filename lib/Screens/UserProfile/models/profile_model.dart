class ProfileModel {
  String? name;
  String? phone;
  String? dob;
  String? gender;
  bool? discoverme;
  bool? instagramVerify;
  bool? facebookVerify;
  bool? isonliine;
  String? interest;
  String? deviceToken;
  String? coverPhoto;
  String? profilePhoto;
  String? userid;
  String? recentAddress;
  String? recentLat;
  String? recentLong;
  String? joinedDate;

  ProfileModel(
      {this.name = "",
        this.phone= "",
        this.dob = "",
        this.gender = "",
        this.discoverme = false,
        this.instagramVerify = false,
        this.facebookVerify = false,
        this.isonliine = false,
        this.interest = "",
        this.deviceToken = "",
        this.coverPhoto = "",
        this.profilePhoto = "",
        this.userid= "",
        this.recentAddress= "",
        this.recentLat= "",
        this.recentLong= "",
        this.joinedDate});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    phone = json['phone'] ?? "";
    dob = json['dob'] ?? "";
    gender = json['gender'] ?? "";
    discoverme = json['discoverme'] ?? false;
    instagramVerify = json['instagramVerify'] ?? false;
    facebookVerify = json['facebookVerify'] ?? false;
    isonliine = json['isonliine'] ?? false;
    interest = json['interest'] ?? "";
    deviceToken = json['deviceToken'] ?? "";
    coverPhoto = json['coverPhoto'] ?? "";
    profilePhoto = json['profilePhoto'] ?? "";
    userid = json['userid'];
    recentAddress = json['recentAddress'] ?? "";
    recentLat = json['recentLat'] ?? "";
    recentLong = json['recentLong'] ?? "";
    joinedDate = json['joinedDate'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['discoverme'] = this.discoverme;
    data['isonliine'] = this.isonliine;
    data['instagramVerify'] = this.instagramVerify;
    data['facebookVerify'] = this.facebookVerify;
    data['interest'] = this.interest;
    data['deviceToken'] = this.deviceToken;
    data['coverPhoto'] = this.coverPhoto;
    data['profilePhoto'] = this.profilePhoto;
    data['userid'] = this.userid;
    data['recentAddress'] = this.recentAddress;
    data['recentLat'] = this.recentLat;
    data['recentLong'] = this.recentLong;
    data['joinedDate'] = this.joinedDate;
    return data;
  }
}