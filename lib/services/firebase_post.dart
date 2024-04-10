

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MessageManagement{


  static Future<bool> sendMessage({
    required String userId,
    required String msgReceiverId,
    required String message,
    required int messageType,
  })async{
    bool success=false;

    var document = FirebaseFirestore.instance.collection('chats').doc();

    // var receiverDocument = FirebaseFirestore.instance.collection('users').doc(userId).collection('Messages').doc(msgReceiverId);
      await document.set({
          "userId":userId,
          "receiverId":msgReceiverId,
          "participants":[userId,msgReceiverId],
        // 0  Message
        // 1  Image
          "message":message,
          "messageType":messageType,
          "createdAt":Timestamp.now(),
      },SetOptions(merge: true)).then((value) {
        success= true;
        // Fluttertoast.showToast(msg: "Message Added Successfully",backgroundColor: Colors.green);
      }).onError((error, stackTrace) {
        success= false;
      });

    // if(success){
    //   if(receiverUserId!=userId){
    //     sendNotification(message:"${FirebaseAuth.instance.currentUser?.displayName??'User'}_ Commented on Your Post" ,senderUserId:userId ,receiverId: receiverUserId,notificationType: 3);
    //   }

    // }

    return success;

  }
}
class PostManagement{

static Future<bool>  postAPost({
    required String mediaUrl,
    required int mediaType,
    required String text,
     String? mediaPath,
}) async {

    bool success=false;
     String userId=FirebaseAuth.instance.currentUser!.uid;

    var document = FirebaseFirestore.instance.collection('posts').doc();
   await document.set({
      "userId":userId,
      "postId":document.id,
     "shareWith": 'public',
      "createdAt":Timestamp.now(),
     "text": text,
     "path": mediaPath,
     "likes":[],
     "media":  mediaUrl,           //['assets/images/post/2.jpg'],
      "type" : mediaType   // 0/1/2
    }).then((value) {
      success= true;
      Fluttertoast.showToast(msg: "Added Successfully",backgroundColor: Colors.green);
    }).onError((error, stackTrace) {
      success= false;
    });
    return success;
  }


static Future<bool> postLike({
    required String userId,
    required String receiverUserId,
    required String postId,
    required bool isAdd,
    }) async {

    bool success=false;
    var document = FirebaseFirestore.instance.collection('posts').doc(postId);
   await document.set({
      "likes":isAdd? FieldValue.arrayUnion([userId]) : FieldValue.arrayRemove([userId]),
    },SetOptions(merge: true)).then((value) {
      success= true;
      // Fluttertoast.showToast(msg: "Liked",backgroundColor: Colors.green);
    }).onError((error, stackTrace) {

      success= false;
    });
   if(success){
     if(isAdd){
       if(receiverUserId!=userId){
         sendNotification(message:"${FirebaseAuth.instance.currentUser?.displayName??'User'}_ Liked Your Post" ,senderUserId:userId ,receiverId: receiverUserId,notificationType: 2, postId: postId);
       }
     }

   }
    return success;
  }


static Future<bool> postCommand({
    required String userId,
    required String postId,
  required String receiverUserId,
    required String command,
   })async{

    bool success=false;

    var document = FirebaseFirestore.instance.collection('posts').doc(postId).collection('command').doc('allCommands');

    if((await document.get()).exists){
      await document.set({
        "commands":FieldValue.arrayUnion([{
          "userId":userId,
          "command":command,
          "createdAt":Timestamp.now(),
        }])

      },SetOptions(merge: true)).then((value) {
        success= true;
        Fluttertoast.showToast(msg: "Commend Added Successfully",backgroundColor: Colors.green);
      }).onError((error, stackTrace) {
        success= false;
      });
    }else{
      await document.set({
        "commands":[{
          "userId":userId,
          "command":command,
          "createdAt":Timestamp.now(),
        }]

      },SetOptions(merge: true)).then((value) {
        success= true;
        Fluttertoast.showToast(msg: "Added Successfully",backgroundColor: Colors.green);
      }).onError((error, stackTrace) {
        success= false;
      });
    }
    if(success){
        if(receiverUserId!=userId){
          sendNotification(message:"${FirebaseAuth.instance.currentUser?.displayName??'User'}_ Commented on Your Post" ,senderUserId:userId ,receiverId: receiverUserId,notificationType: 3, postId: postId);
        }

    }

    return success;

  }
static Future<bool> sendNotification({
  required String receiverId,
  required String senderUserId,
  required String message,
  required String postId,
  required int notificationType,
})async{

  bool success=false;

  var document = FirebaseFirestore.instance.collection('notifications').doc();
  await document.set({
    "senderId":senderUserId,
    "userId":receiverId,
    "postId":postId,
    "message":message,
    "notificationType":notificationType,
    "createdAt":Timestamp.now(),
  }).then((value) {
    success= true;
    // Fluttertoast.showToast(msg: "Added Successfully",backgroundColor: Colors.green);
  }).onError((error, stackTrace) {
    success= false;
  });
  return success;
}
}

class UpdateProfile{

  static Future<bool> postProfilePic({
    required String userId,
    required String url,
    })async{

    bool success=false;

    var document = FirebaseFirestore.instance.collection('users').doc(userId);
    await document.set({
      "photo":url
    },SetOptions(merge: true)).then((value) async {
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(url.toString());
      success= true;
      Fluttertoast.showToast(msg: "Added Successfully",backgroundColor: Colors.green);
    }).onError((error, stackTrace) {
      success= false;
    });
    return success;
  }


  static Future<bool> postBackgroundPic({
    required String userId,
    required String url,
  })async{

    bool success=false;

    var document = FirebaseFirestore.instance.collection('users').doc(userId);
    await document.set({
      "background":url
    },SetOptions(merge: true)).then((value) {

      success= true;
      Fluttertoast.showToast(msg: "Added Successfully",backgroundColor: Colors.green);
    }).onError((error, stackTrace) {
      success= false;
    });
    return success;
  }

  static Future<bool> postUserInfo({
    required String userId,
    required String name,
    required String bio,
    required String education,
    required String location,
  })async{

    bool success=false;

    var document = FirebaseFirestore.instance.collection('users').doc(userId);
    await document.set({
      "name":name,
      "nameSmall":name.toLowerCase(),
      "bio":bio,
      "education":education,
      "location":location,
    },SetOptions(merge: true)).then((value) {
      success= true;
      FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      Fluttertoast.showToast(msg: "Profile Updated Successfully",backgroundColor: Colors.green);
    }).onError((error, stackTrace) {
      success= false;
    });
    return success;
  }

}

class UserManagement{

  static Future<bool> sendFriendRequest({
    required String receiverUserId,
  })async{
    String userId = FirebaseAuth.instance.currentUser!.uid;
    bool success=false;
    print(receiverUserId);
    var document = FirebaseFirestore.instance.collection('users').doc(userId);
    var receiverDocument = FirebaseFirestore.instance.collection('users').doc(receiverUserId);
    try{
      await document.set({
        "requests":FieldValue.arrayUnion([
          receiverUserId
        ])
      },SetOptions(merge: true));
      await receiverDocument.set({
        "receivedRequests":FieldValue.arrayUnion([
          userId
        ])
      },SetOptions(merge: true));
      success=true;
      if(success)Fluttertoast.showToast(msg: "Friend Request Sent",backgroundColor: Colors.green);
    }catch (e){
      success= false;
    }

    return success;

  }


  static Future<bool> unFriedFriend({
    required String receiverUserId,
  })async{
    String userId = FirebaseAuth.instance.currentUser!.uid;
    bool success=false;
    var document = FirebaseFirestore.instance.collection('users').doc(userId);
    var receiverDocument = FirebaseFirestore.instance.collection('users').doc(receiverUserId);
    try{
      await document.set({
        "friends":FieldValue.arrayRemove([
          receiverUserId
        ])
      },SetOptions(merge: true));
      await receiverDocument.set({
        "friends":FieldValue.arrayRemove([
          userId
        ])
      },SetOptions(merge: true));
     Fluttertoast.showToast(msg: "UnFriend Successfully",backgroundColor: Colors.green);
    }catch (e){
      success= false;
    }

    return success;

  }

  static Future<bool> withdrawFriendRequest({
    required String receiverUserId,
  })async{
    String userId = FirebaseAuth.instance.currentUser!.uid;
    bool success=false;

    var document = FirebaseFirestore.instance.collection('users').doc(userId);
    var receiverDocument = FirebaseFirestore.instance.collection('users').doc(receiverUserId);
    try{
      await document.set({
        "receivedRequests":FieldValue.arrayRemove([
          receiverUserId
        ])
      },SetOptions(merge: true));
      await receiverDocument.set({
        "requests":FieldValue.arrayRemove([
          userId
        ])
      },SetOptions(merge: true));
      success= true;
      if(success)Fluttertoast.showToast(msg: "Friend Request Deleted",backgroundColor: Colors.green);
    }catch (e){
      success= false;
    }

    return success;

  }

  static Future<bool> acceptFriendRequest({
    required String receiverUserId,
  })async{
    String userId = FirebaseAuth.instance.currentUser!.uid;
    bool success=false;

    var document = FirebaseFirestore.instance.collection('users').doc(userId);
    var receiverDocument = FirebaseFirestore.instance.collection('users').doc(receiverUserId);
    try{
      await document.set({
        "receivedRequests":FieldValue.arrayRemove([
          receiverUserId
        ])
      },SetOptions(merge: true));
      await receiverDocument.set({
        "requests":FieldValue.arrayRemove([
          userId
        ])
      },SetOptions(merge: true));
      await document.set({
        "friends":FieldValue.arrayUnion([
          receiverUserId
        ])
      },SetOptions(merge: true));
      await receiverDocument.set({
        "friends":FieldValue.arrayUnion([
          userId
        ])
      },SetOptions(merge: true));

      success=await sendNotification(message:"${FirebaseAuth.instance.currentUser?.displayName??'User'}_ Accepted Your Friend Request" ,senderUserId:userId ,receiverId: receiverUserId,notificationType: 1);
      if(success)Fluttertoast.showToast(msg: "Friend Request Accepted",backgroundColor: Colors.green);
    }catch (e){
      success= false;
    }

    return success;

  }


  static Future<bool> sendNotification({
    required String receiverId,
    required String senderUserId,
    required String message,
    required int notificationType,
  })async{

    bool success=false;

    var document = FirebaseFirestore.instance.collection('notifications').doc();
    await document.set({
      "senderId":senderUserId,
      "userId":receiverId,
      "message":message,
      "notificationType":notificationType,
      "createdAt":Timestamp.now(),
    }).then((value) {
      success= true;
      // Fluttertoast.showToast(msg: "Added Successfully",backgroundColor: Colors.green);
    }).onError((error, stackTrace) {
      success= false;
    });
    return success;
  }

}

