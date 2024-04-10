part of 'post_cubit.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
}
class PostLoading extends PostState {
  @override
  List<Object> get props => [];
}
class PostSuccess extends PostState {
  const PostSuccess({required this.posts});
  final List<PostModel> posts ;
  @override
  List<Object> get props => [posts];
}
class PostFailed extends PostState {
  @override
  List<Object> get props => [];
}
