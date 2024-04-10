import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/firebase_post.dart';
import 'dart:io' as io;
part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit() : super(SendMessageInitial());


  Future<bool> sendMessage(String senderId ,String? receiverId ,String message,int messageType)async{

    try {
      emit(SendMessageLoading());
      if(messageType==0){
        bool success = await MessageManagement.sendMessage(userId: senderId, msgReceiverId: receiverId??'', message: message,messageType:messageType);
        if(success){
          emit(SendMessageSended());
          return success;
        }else{
          emit(SendMessageFailed());
          Fluttertoast.showToast(msg: "Unable to send Message");
          return success;
        }
      }else{
        if(message!=""){
          String path="${FirebaseAuth.instance.currentUser!
              .uid}/${DateTime.now()
              .toString()}${message
              .split('/')
              .last}";
          Reference storageReference = FirebaseStorage
              .instance.ref().child(
              path);

          UploadTask uploadTask = storageReference.putFile(
              io.File(message));

          await uploadTask.whenComplete(() =>
              print("Image uploaded"));

          String url = await storageReference
              .getDownloadURL();

          bool success = await MessageManagement.sendMessage(userId: senderId, msgReceiverId: receiverId??'', message: url,messageType:messageType);
          if(success){
            emit(SendMessageSended());
            return success;
          }else{
            emit(SendMessageFailed());
            Fluttertoast.showToast(msg: "Unable to send Message");
            return success;
          }
        }else{
          return false;
        }

      }

      // var collection = FirebaseFirestore.instance.collection('users').doc(senderId);
      // collection.collection("sendMessage").doc(receiverId).set({
      //   "sendMessages":FieldValue.arrayUnion([{
      //     "date":"${DateTime.now()}",
      //     "senderId": senderId,
      //     "Message": message
      //   }])
      // },SetOptions(merge : true)).then((value) =>{
      // });
      // var recollection = FirebaseFirestore.instance.collection('users').doc(receiverId);
      // recollection.collection("sendMessage").doc(senderId).set({
      //   "sendMessages":FieldValue.arrayUnion([{
      //     "date":"${DateTime.now()}",
      //     "senderId": senderId,
      //     "Message": message
      //   }])
      // },SetOptions(merge : true)).then((value) {

      // });

    }catch(e){
      print("Eroorro $e");
      emit(SendMessageFailed());
      Fluttertoast.showToast(msg: "Unable to send Message");
      return false;
    }

  }
  void reset(){
    emit(SendMessageInitial());
  }
}
