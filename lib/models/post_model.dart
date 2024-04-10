

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? userId;
  String? postId;
  String? shareWith;
  Timestamp? createdAt;
  String? text;
  List<String>? likes;
  String? media;
  String? mediaPath;
  int? type;
  PostModel(
      {this.userId,
        this.postId,
        this.shareWith,
        this.createdAt,
        this.text,
        this.mediaPath,

        this.likes,
        this.media,
        this.type});

  PostModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    postId = json['postId'];
    shareWith = json['shareWith'];

    createdAt = json['createdAt'];
    text = json['text'];
    likes = json['likes'].cast<String>();
    media = json['media'];
    mediaPath = json['path'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['postId'] = this.postId;
    data['shareWith'] = this.shareWith;
    data['createdAt'] = this.createdAt;
    data['text'] = this.text;
    data['likes'] = this.likes;
    data['media'] = this.media;
    data['type'] = this.type;
    return data;
  }
}
class Commands {

  String? userId;
  String? command;

  Timestamp? createdAt;

  Commands({ this.userId, this.command,this.createdAt});

  Commands.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    command = json['command'];;
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['command'] = this.command;
    data['createdAt'] = this.createdAt;
    return data;
  }
}