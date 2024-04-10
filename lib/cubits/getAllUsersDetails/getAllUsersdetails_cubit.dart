import 'package:avrod/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'getAllUsersDetails_state.dart';

class GetAllUsersDetailsCubit extends Cubit<GetAllUsersDetailsState> {
  GetAllUsersDetailsCubit() : super(GetAllUsersDetailsInitial());

  Future<void> getAllUsersDetails()async{
   try {
     FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
       // Map<String,dynamic> hh=event.data()??{};
       List<UserModel> allUsersList = [];
       event.docs.forEach((element) {
         UserModel data = UserModel.fromJson(element.data());
         allUsersList.add(data);
       });
       emit(GetAllUsersDetailsLoaded(allUsersList: allUsersList));
     });
   }catch(e){
     emit(GetAllUsersDetailsFailed());
   }
  }

}
