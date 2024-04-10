part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}
class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}
class UserSuccess extends UserState {
  const UserSuccess({required this.user});
  final UserModel user;
  @override
  List<Object> get props => [user];
}
class UserFailed extends UserState {
  @override
  List<Object> get props => [];
}
