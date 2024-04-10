part of 'getmessages_cubit.dart';

abstract class GetmessagesState extends Equatable {
  const GetmessagesState();
}

class GetmessagesInitial extends GetmessagesState {
  @override
  List<Object> get props => [];
}

class GetmessagesLoading extends GetmessagesState {
  @override
  List<Object> get props => [];
}

class GetmessagesLoaded extends GetmessagesState {
  const GetmessagesLoaded({required this.messageList});
  final List<ChatModel> messageList;
  // bool operator==(Object other) =>
  //  other is GetMessagesLoaded && other.senderMessageList==senderMessageList;
  //
  //
  // int get hashCode => Object.hash(senderMessageList);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is GetmessagesLoaded &&
              runtimeType == other.runtimeType &&
              messageList == other.messageList;

  @override
  int get hashCode => messageList.hashCode;
  @override
  List<Object> get props => [messageList];
}

class GetmessagesFailed extends GetmessagesState {
  @override
  List<Object> get props => [];
}
