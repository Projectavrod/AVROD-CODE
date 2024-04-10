part of 'getnotification_cubit.dart';

abstract class GetnotificationState extends Equatable {
  const GetnotificationState();
}

class GetnotificationInitial extends GetnotificationState {
  @override
  List<Object> get props => [];
}
class GetnotificationLoading extends GetnotificationState {
  @override
  List<Object> get props => [];
}
class GetnotificationLoaded extends GetnotificationState {
  const GetnotificationLoaded({required this.notificationList});
final List<GetNotificationModel> notificationList;
  @override
  List<Object> get props => [notificationList];
}
class GetnotificationFailed extends GetnotificationState {
  @override
  List<Object> get props => [];
}
