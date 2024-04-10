part of 'getAllUsersdetails_cubit.dart';

abstract class GetAllUsersDetailsState extends Equatable {
  const GetAllUsersDetailsState();
}

class GetAllUsersDetailsInitial extends GetAllUsersDetailsState {
  @override
  List<Object> get props => [];
}
class GetAllUsersDetailsLoading extends GetAllUsersDetailsState {
  @override
  List<Object> get props => [];
}
class GetAllUsersDetailsLoaded extends GetAllUsersDetailsState {
  const GetAllUsersDetailsLoaded({required this.allUsersList});
   final List<UserModel> allUsersList;
  @override
  List<Object> get props => [allUsersList];
}
class GetAllUsersDetailsFailed extends GetAllUsersDetailsState {
  @override
  List<Object> get props => [];
}
