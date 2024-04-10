import 'package:bloc/bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

part 'indiavidul_chat_video_view_state.dart';

class IndiavidulChatVideoViewCubit extends Cubit<IndiavidulChatVideoViewState> {
  IndiavidulChatVideoViewCubit() : super(IndiavidulChatVideoViewInitial());
   VideoPlayerController? videoPlayerController;
    ChewieController? chewieController;
  void updatePlayerFromFile({required String imagePath})async{
    emit(VideoPlayerUpdatingI());
    chewieController?.dispose();
    videoPlayerController?.dispose();
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(imagePath));
    chewieController =  ChewieController(
      zoomAndPan: true,
      videoPlayerController: videoPlayerController!,
      aspectRatio: 9/16, // Adjust the aspect ratio as needed
      autoPlay: false,
      looping: false,
      autoInitialize: true,
    );
    // chewieController?.addListener(() {
      Future.delayed(Duration(seconds: 2),(){
        // if(chewieController !=null&&chewieController!.videoPlayerController.value.isInitialized){

          emit(VideoPlayerUpdateUpdatedI(videoPlayerController!,chewieController!));

        // }
      });
    // });


  }
  void disposeController(){
    if(videoPlayerController!=null&&chewieController!=null){
      if(chewieController?.isPlaying??false){
        chewieController?.pause();
      }
      videoPlayerController?.dispose();
      chewieController?.dispose();
    }
    emit(IndiavidulChatVideoViewInitial());
  }
}
