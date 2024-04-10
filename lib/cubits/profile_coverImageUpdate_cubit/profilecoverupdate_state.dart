part of 'profilecoverupdate_cubit.dart';

abstract class ProfilecoverupdateState extends Equatable {
  const ProfilecoverupdateState();
}

class ProfilecoverupdateInitial extends ProfilecoverupdateState {
  @override
  List<Object> get props => [];
}
class ProfilecoverupdateUpLoading extends ProfilecoverupdateState {
  @override
  List<Object> get props => [];
}
class ProfilecoverupdateUploaded extends ProfilecoverupdateState {
  const ProfilecoverupdateUploaded({required this.Profileimage, required this.coverImage});
  final String Profileimage;
  final String coverImage;
  @override
  List<Object> get props => [];
}
class ProfilecoverupdateFailed extends ProfilecoverupdateState {
  @override
  List<Object> get props => [];
}
