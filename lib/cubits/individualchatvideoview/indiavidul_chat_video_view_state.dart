part of 'indiavidul_chat_video_view_cubit.dart';

abstract class IndiavidulChatVideoViewState extends Equatable {
  const IndiavidulChatVideoViewState();
}

class IndiavidulChatVideoViewInitial extends IndiavidulChatVideoViewState {
  @override
  List<Object> get props => [];
}
class VideoPlayerUpdatingI extends IndiavidulChatVideoViewState {
  @override
  List<Object> get props => [];
}
class VideoPlayerUpdateUpdatedI extends IndiavidulChatVideoViewState {
  const VideoPlayerUpdateUpdatedI(this.videoPlayerController, this.chewieController,);
  final VideoPlayerController videoPlayerController;
  final  ChewieController chewieController;
  @override
  List<Object> get props => [videoPlayerController,chewieController];
}
