import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/sendermessagemodel.dart';

part 'getmessages_state.dart';

class GetmessagesCubit extends Cubit<GetmessagesState> {
  GetmessagesCubit() : super(GetmessagesInitial());

  Future<void> getMessage( String chatUserid)async{
    // try {
      emit(GetmessagesLoading());
      String userId=FirebaseAuth.instance.currentUser!.uid;

        FirebaseFirestore.instance.collection('chats')
        // .where('receiverId',isEqualTo: userId,)
        .where('userId',whereIn: [userId,chatUserid],)
        // .orderBy("createdAt",descending: true)
            .snapshots().listen((event) {

          List<ChatModel> messageList=[];
          event.docs.forEach((element) {

            ChatModel message=ChatModel.fromJson(element.data());
            if((message.userId==userId && message.receiverId==chatUserid) || (message.receiverId==userId && message.userId==chatUserid)) {
              message.docId=element.id;
              messageList.add(message);
            }
          });
          print("Listenning ${event.docs.length}   ${messageList.length}");
          messageList.sort((a,b)=>a.createdAt!.toDate().compareTo(b.createdAt!.toDate()));
          emit(GetmessagesLoaded(messageList:messageList));
        });
    // }on FirebaseFirestore catch(e){
    //   emit(GetmessagesFailed());
    //   print("Message Get E : $e");
    //   Fluttertoast.showToast(msg: "Cannot Get Users data!!");
    // }
  }
  void reset(){
    emit(GetmessagesInitial());
  }


}
