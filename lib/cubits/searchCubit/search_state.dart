part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}
class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}
class SearchSuccess extends SearchState {
  const SearchSuccess({required this.users});
  final List<UserModel> users;
  @override
  List<Object> get props => [users];
}
class SearchFailed extends SearchState {
  @override
  List<Object> get props => [];
}
