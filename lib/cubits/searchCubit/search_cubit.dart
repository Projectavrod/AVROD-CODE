import 'package:avrod/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

Future<void> searchUser(String query) async {
  emit(SearchLoading());
if(query.isNotEmpty) {
  FirebaseFirestore.instance.collection('users')
      .where('nameSmall', isGreaterThanOrEqualTo: query.toLowerCase())
      .where('nameSmall', isLessThan: '${query}z')
      .get().then((value) {

    List<UserModel> users=[];

    for (var document in value.docs) {

      var user=UserModel.fromJson(document.data());
      users.add(user);

    }
    emit(SearchSuccess(users: users));

  });
}else{
  emit(const SearchSuccess(users: []));
}

}

void reset(){
  emit(SearchInitial());
}

}
