import 'package:avrod/models/post_model.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';
class PreVideoPlayerWidget extends StatefulWidget {
  const PreVideoPlayerWidget({Key? key, required this.url}) : super(key: key);
  final String? url;

  @override
  State<PreVideoPlayerWidget> createState() => _PreVideoPlayerWidgetState();
}

class _PreVideoPlayerWidgetState extends State<PreVideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  late  ChewieController _chewieController;


  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.url ??''));
    _chewieController = ChewieController(
      zoomAndPan: true,
      videoPlayerController: _videoPlayerController,
      aspectRatio: 9/16, // Adjust the aspect ratio as needed
      autoPlay: false,
      looping: false,
      // showControls: false,
      showControlsOnInitialize: false,
      autoInitialize: true,
    );
    _videoPlayerController.addListener(() {
      if(_videoPlayerController.value.isInitialized==true){
        setState(() {});
      }
    });
    // _initializeVideoPlayer(widget.post.media??'');
  }
  @override
  Widget build(BuildContext context) {
    return  _chewieController.videoPlayerController.value.isInitialized
        ? GestureDetector(
      onTap: (){
        if(_chewieController.videoPlayerController.value.isPlaying){
          _chewieController.videoPlayerController.pause();
        }else{
          _chewieController.videoPlayerController.play();
        }

      },
          child: Chewie(
                controller: _chewieController,
              ),
        ):Container(
      // color: Colors.red,
      alignment: Alignment.center,
      // height: 24,
      // width: 24,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          color: Colors.grey,
          height: 320,width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
