import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/getnotifymodel.dart';

part 'getnotification_state.dart';

class GetnotificationCubit extends Cubit<GetnotificationState> {
  GetnotificationCubit() : super(GetnotificationInitial());
  Future<void> GetNotification()async{

    try {
      FirebaseFirestore.instance.collection('notifications')
      .where('userId',isEqualTo:FirebaseAuth.instance.currentUser?.uid )
          .snapshots().listen((
          event) {
        List<GetNotificationModel> notificationList = [];
          event.docs.forEach((element) {
            GetNotificationModel hh = GetNotificationModel.fromJson(element.data());
            hh.notiId=element.id;
            notificationList.add(hh);
          });
          emit(GetnotificationLoaded(notificationList: notificationList));
      });
    }catch (e){
      emit(GetnotificationFailed());
    }
  }
}
