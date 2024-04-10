import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? userId;
  String? docId;
  String? receiverId;
  String? message;
  int? messageType;
  Timestamp? createdAt;

  ChatModel(
      {this.userId,
        this.receiverId,
        this.message,
        this.messageType,
        this.createdAt});

  ChatModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    receiverId = json['receiverId'];
    message = json['message'];
    messageType = json['messageType'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['receiverId'] = this.receiverId;
    data['message'] = this.message;
    data['messageType'] = this.messageType;
    data['createdAt'] = this.createdAt;
    return data;
  }
}