

class UserModel {
  String? name;
  String? nameSmall;
  String? bio;
  String? education;
  String? location;
  String? userId;
  String? email;
  String? userProfileCoverImg;
  String? userProfileImg;
  String? photo;
  String? background;
  List<String>? friends;
  List<String>? requests;
  List<String>? receivedRequests;

  UserModel(
      {this.name, this.nameSmall, this.bio, this.userProfileCoverImg,this.userProfileImg, this.education, this.location, this.userId, this.email, this.background, this.photo, this.friends, this.receivedRequests, this.requests});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nameSmall = json['nameSmall'];
    bio = json['bio'];
    education = json['education'];
    location = json['location'];
    userId = json['userId'];
    userProfileCoverImg = json['userProfileCoverImg'];
    userProfileImg = json['userProfileImg'];
    email = json['email'];
    photo = json['photo'];
    background = json['background'];
    friends = json['friends']?.cast<String>();
    receivedRequests = json['receivedRequests']?.cast<String>();
    requests = json['requests']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['nameSmall'] = nameSmall;
    data['bio'] = bio;
    data['userProfileCoverImg'] = userProfileCoverImg;
    data['userProfileImg    '] = userProfileImg;
    data['education'] = education;
    data['location'] = location;
    return data;
  }
}