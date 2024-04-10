part of 'send_message_cubit.dart';

abstract class SendMessageState extends Equatable {
  const SendMessageState();
}

class SendMessageInitial extends SendMessageState {
  @override
  List<Object> get props => [];
}
class SendMessageLoading extends SendMessageState {
  @override
  List<Object> get props => [];
}
class SendMessageSended extends SendMessageState {
  @override
  List<Object> get props => [];
}
class SendMessageFailed extends SendMessageState {
  @override
  List<Object> get props => [];
}