part of 'getallpost_cubit.dart';

abstract class GetallpostState extends Equatable {
  const GetallpostState();
}

class GetallpostInitial extends GetallpostState {
  @override
  List<Object> get props => [];
}
class GetallpostLoading extends GetallpostState {
  @override
  List<Object> get props => [];
}
class GetallpostLoaded extends GetallpostState {
  GetallpostLoaded({required this.postsList});
  final List<PostModel> postsList;
  @override
  List<Object> get props => [postsList];
}
class GetallpostFailed extends GetallpostState {
  @override
  List<Object> get props => [];
}
