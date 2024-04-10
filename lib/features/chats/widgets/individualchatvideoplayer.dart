import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'dart:io' as io;

import '../../../cubits/individualchatvideoview/indiavidul_chat_video_view_cubit.dart';
class IndividualChatVideoPlayer extends StatefulWidget {
   IndividualChatVideoPlayer({Key? key, required this.mediaPath, required this.mediaName, required this.onCallBack}) : super(key: key);
  final String mediaPath;
  final   Function() onCallBack;
  final String mediaName;

  @override
  State<IndividualChatVideoPlayer> createState() => _IndividualChatVideoPlayerState();
}

class _IndividualChatVideoPlayerState extends State<IndividualChatVideoPlayer> {
  // late VideoPlayerController _videoPlayerController;
  // late  ChewieController _chewieController;
  // void _initializeVideoPlayer(String videoPath) {
  //   _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoPath));
  //   _chewieController     = ChewieController(
  //     zoomAndPan: true,
  //     videoPlayerController: _videoPlayerController,
  //     aspectRatio: 9/16, // Adjust the aspect ratio as needed
  //     autoPlay: false,
  //     looping: false,
  //     autoInitialize: true,
  //   );
  //
  //   setState(() {
  //
  //   });
  //   Future.delayed(Duration(seconds: 1),(){
  //     setState(() {
  //     widget.onCallBack();
  //     });
  //   });
  //   Future.delayed(Duration(seconds: 2),(){
  //     setState(() {
  //     widget.onCallBack();
  //     });
  //   });
  // }
  @override
  void initState() {
    // TODO: implement initState
    context.read<IndiavidulChatVideoViewCubit>().updatePlayerFromFile(imagePath: widget.mediaPath);
    super.initState();
  }
  // @override
  // void dispose() {
  //   context.read<IndiavidulChatVideoViewCubit>().disposeController();
  //   // TODO: implement dispose
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndiavidulChatVideoViewCubit, IndiavidulChatVideoViewState>(
  builder: (context, vidState) {
    print("ldaclkdmclkadsmclasd ${vidState.runtimeType}");
    if(vidState is VideoPlayerUpdateUpdatedI){
      return  Container(height: 280,
        width: 200,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.24))
        ),
        child: Chewie(
          controller: vidState.chewieController,
        ),
      );
    }else{
      return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.24))
        ),
        padding: EdgeInsets.symmetric(vertical: 110,horizontal: 80),
        child: SizedBox(
          height: 26,
          width: 26,
          child: CircularProgressIndicator(strokeWidth: 0.8,color: Colors.white,),
        ),
      );
    }
  },
);
  }
}
