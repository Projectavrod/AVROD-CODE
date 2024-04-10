import 'package:avrod/cubits/getUserData/user_cubit.dart';
import 'package:avrod/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/post_model.dart';

part 'getallpost_state.dart';

class GetallpostCubit extends Cubit<GetallpostState> {
  GetallpostCubit() : super(GetallpostInitial());


  Future<void> getOverAllPost()async{

    try {
      String? userId =FirebaseAuth.instance.currentUser?.uid;
     FirebaseFirestore.instance.collection('users')
          .doc(userId)
          .snapshots().listen((value) {
        print(value.data());
        UserModel user=UserModel.fromJson(value.data() ?? {});
        List friends = user?.friends ??[];
        friends.add(userId);
        FirebaseFirestore.instance.collection('posts')
            .where("userId",whereIn: friends )
        .orderBy('createdAt',descending: true)
            .snapshots()
            .listen((event) {
          List<PostModel> posts = [];
          for (var element in event.docs) {
            var post = PostModel.fromJson(element.data());
            posts.add(post);
          }
          emit(GetallpostLoaded(postsList: posts));
        });
      });

    }catch(e){
      emit(GetallpostFailed());
    }
  }


}
