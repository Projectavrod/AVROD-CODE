class UserProfileData {
  String? name;
  String? bio;
  String? education;
  String? userProfileCoverImg;
  String? userProfileImg;
  String? location;
  String? uId;

  UserProfileData(
      {this.name, this.bio, this.education,this.userProfileCoverImg,this.userProfileImg, this.location, this.uId});

  UserProfileData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bio = json['bio'];
    education = json['education'];
    userProfileCoverImg = json['userProfileCoverImg'];
    userProfileImg = json['userProfileImg'];
    location = json['location'];
    uId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['bio'] = this.bio;
    data['education'] = this.education;
    data['userProfileCoverImg'] = this.userProfileCoverImg;
    data['userProfileImg    '] = this.userProfileImg;
    data['location'] = this.location;
    data['userId'] = this.uId;
    return data;
  }
}
