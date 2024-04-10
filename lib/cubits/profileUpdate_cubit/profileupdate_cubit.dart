import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/firebase_post.dart';

part 'profileupdate_state.dart';

class ProfileupdateCubit extends Cubit<ProfileupdateState> {
  ProfileupdateCubit() : super(ProfileupdateInitial());

  Future<void> updateProfile({
    required String name,
    required String bio,
    required String education,
    required String location,
  })async{
    emit(ProfileupdateLoading());
    User? userInfo= FirebaseAuth.instance.currentUser;
    if(userInfo!=null){
      bool isUpdated=await UpdateProfile.postUserInfo(userId: userInfo.uid??'', name: name, bio: bio, education: education, location: location);
      if(isUpdated){
        emit(ProfileupdateUpdated());
      }else{
        emit(ProfileupdateFailed());
        Fluttertoast.showToast(msg: "Something Went Wrong!! Check Your Internet",backgroundColor: Colors.red);
      }
    }else{
      emit(ProfileupdateFailed());
      Fluttertoast.showToast(msg: "Unable to Update Profile!! Please Logout and Login Again",backgroundColor: Colors.red);
    }

  }
  void resetCubit(){
    emit(ProfileupdateInitial());
  }
}
