import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io' as io;
import 'dart:math';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
part 'profilecoverupdate_state.dart';

class ProfilecoverupdateCubit extends Cubit<ProfilecoverupdateState> {
  ProfilecoverupdateCubit() : super(ProfilecoverupdateInitial());


  Future<String?> uploadImage(io.File image,String userId,bool isProfile) async {

    Reference storageReference = FirebaseStorage.instance.ref().child("${userId}${DateTime.now().toString()}${isProfile?"profileImage":"coverImg"}");
    UploadTask uploadTask = storageReference.putFile(image);

    await uploadTask.whenComplete(() => print("Image uploaded"));

    return await storageReference.getDownloadURL();
  }
  Future<String> pickProfileImage(String userId, String userImagepath) async {

    PermissionStatus status = await Permission.photos.status;
    String dateTimeNow=DateTime.now().toString();
    if (status.isDenied) {
      await Permission.photos.request();
    }

    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {

      print("Image picked: ${pickedFile.path}");
    }
    io.File pickFile= io.File(pickedFile?.path??'');

    if (pickFile != null){
      //Upload to Firebase
     //  if(userImagepath.isNotEmpty||userImagepath !=''){
     //    Reference storageReference = FirebaseStorage.instance.ref().child(userImagepath);
     // await storageReference.delete();
     //  }
      String? imageUrl = await uploadImage(pickFile,userId,true);
      var currentUser = FirebaseFirestore.instance.collection('users').doc(userId);
      currentUser.set({
      'userProfileImg':'$imageUrl'
    },SetOptions(merge: true));
      FirebaseAuth.instance.currentUser?.updatePhotoURL(imageUrl);
    } else {
      print('No Image Path Received');
    }
    emit(ProfilecoverupdateUploaded(Profileimage: '', coverImage: ''));
    return pickFile.path??"";

  }
  Future<String> pickCoverImage(String userId, String userImagepath) async {

    PermissionStatus status = await Permission.photos.status;
    String dateTimeNow=DateTime.now().toString();
    if (status.isDenied) {
      await Permission.photos.request();
    }

    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {

      print("Image picked: ${pickedFile.path}");
    }
    io.File pickFile= io.File(pickedFile?.path??'');

    if (pickFile != null){
      //Upload to Firebase
      //  if(userImagepath.isNotEmpty||userImagepath !=''){
      //    Reference storageReference = FirebaseStorage.instance.ref().child(userImagepath);
      // await storageReference.delete();
      //  }
      String? imageUrl = await uploadImage(pickFile,userId,false);
      var currentUser = FirebaseFirestore.instance.collection('users').doc(userId);
      currentUser.set({
        'userProfileCoverImg':'$imageUrl'
      },SetOptions(merge: true));
    } else {
      print('No Image Path Received');
    }
    emit(ProfilecoverupdateUploaded(Profileimage: '', coverImage: ''));
    return pickFile.path??"";

  }
}
