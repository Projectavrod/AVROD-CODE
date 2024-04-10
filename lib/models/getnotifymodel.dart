import 'package:cloud_firestore/cloud_firestore.dart';

class GetNotificationModel {
  String? senderId;
  String? userId;
  String? message;
  String? postId;
  String? notiId;
  int? notificationType;
  Timestamp? createdAt;

  GetNotificationModel(
      {this.senderId,
        this.userId,
        this.notiId,
        this.postId,
        this.message,
        this.notificationType,
        this.createdAt});

  GetNotificationModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    userId = json['userId'];
    postId = json['postId']??'';
    message = json['message'];
    notificationType = json['notificationType'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['senderId'] = this.senderId;
    data['userId'] = this.userId;
    data['postId'] = this.postId;
    data['message'] = this.message;
    data['notificationType'] = this.notificationType;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
