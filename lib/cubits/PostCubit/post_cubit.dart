import 'package:avrod/cubits/getUserData/user_cubit.dart';
import 'package:avrod/models/post_model.dart';
import 'package:avrod/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());

  getPosts(context) async {
    UserModel user= await loadUser(context);

    FirebaseFirestore.instance.collection('posts').where("userId",arrayContainsAny: user.friends).snapshots()
    .listen((event) {
      List<PostModel> posts = [];
      for (var element in event.docs) {
        print(element.data());
        var post = PostModel.fromJson(element.data());
        posts.add(post);
      }
      emit(PostSuccess(posts: posts));
    });

  }

  Future<UserModel> loadUser(context) async {
    UserCubit user_cubit= context.read<UserCubit>();
    if(user_cubit.state is UserSuccess){
      return user_cubit.state.props.first as UserModel;
    }else{
      await user_cubit.getUserData(userId: FirebaseAuth.instance.currentUser!.uid);
      return user_cubit.state.props.first as UserModel;
    }
  }


}
