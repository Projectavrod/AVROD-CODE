import 'package:avrod/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> getUserData({required String userId}) async {
    FirebaseFirestore.instance.collection('users')
        .doc(userId)
        .snapshots().listen((value) {
          print("ksjncvslkcmsd ${value['friends']}");
      UserModel user=UserModel.fromJson(value.data() ?? {});
      emit(UserSuccess(user: user));

    });

  }

}
