import 'package:bloc/bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';
import 'dart:io' as io;
part 'video_player_update_state.dart';

class VideoPlayerUpdateCubit extends Cubit<VideoPlayerUpdateState> {
  VideoPlayerUpdateCubit() : super(VideoPlayerUpdateInitial());
   VideoPlayerController? videoPlayerController;
    ChewieController? chewieController;

  void updatePlayerFromFile({required String imagePath})async{

      emit(VideoPlayerUpdating());
      videoPlayerController = await VideoPlayerController.file(io.File(imagePath));
      chewieController = await ChewieController(
        zoomAndPan: true,
        videoPlayerController: videoPlayerController!,
        aspectRatio: 9/16, // Adjust the aspect ratio as needed
        autoPlay: false,
        looping: false,
        autoInitialize: true,
      );
      Future.delayed(Duration(seconds: 1),(){
        emit(VideoPlayerUpdateUpdated(videoPlayerController!,chewieController!));
      });


  }
  void disposeController(){
    if(videoPlayerController!=null&&chewieController!=null){
      if(chewieController?.isPlaying??false){
        chewieController?.pause();
      }
        videoPlayerController?.dispose();
        chewieController?.dispose();
    }

  emit(VideoPlayerUpdateInitial());
  }
}
