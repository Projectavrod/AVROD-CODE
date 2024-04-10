part of 'video_player_update_cubit.dart';

abstract class VideoPlayerUpdateState extends Equatable {
  const VideoPlayerUpdateState();
}

class VideoPlayerUpdateInitial extends VideoPlayerUpdateState {
  @override
  List<Object> get props => [];
}
class VideoPlayerUpdating extends VideoPlayerUpdateState {
  @override
  List<Object> get props => [];
}
class VideoPlayerUpdateUpdated extends VideoPlayerUpdateState {
  const VideoPlayerUpdateUpdated(this.videoPlayerController, this.chewieController,);
  final VideoPlayerController videoPlayerController;
  final  ChewieController chewieController;
  @override
  List<Object> get props => [videoPlayerController,chewieController];
}
