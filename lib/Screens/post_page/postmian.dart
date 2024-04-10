import 'package:avrod/Widgets/image_widget.dart';
import 'package:avrod/cubits/getUserData/user_cubit.dart';
import 'package:avrod/models/user_model.dart';
import 'package:avrod/services/firebase_post.dart';
import 'package:chewie/chewie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io' as io;

import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

// import 'package:image_picker/image_picker.dart';
class PostMainPage extends StatefulWidget {
  const PostMainPage({Key? key}) : super(key: key);

  @override
  State<PostMainPage> createState() => _PostMainPageState();
}

class _PostMainPageState extends State<PostMainPage> {
  final TextEditingController contentController=TextEditingController();
  late VideoPlayerController _videoPlayerController;
  late  ChewieController _chewieController;

  void _initializeVideoPlayer(String videoPath) {
    _videoPlayerController = VideoPlayerController.file(io.File(videoPath));
    _chewieController = ChewieController(
      zoomAndPan: true,
      videoPlayerController: _videoPlayerController,
      aspectRatio: 9/16, // Adjust the aspect ratio as needed
      autoPlay: false,
      looping: false,
      autoInitialize: true,
    );

    setState(() {

    });
    Future.delayed(Duration(seconds: 1),(){
      setState(() {

      });
    });
  }

  Future<void> _pickPostImage(bool videova) async {

    if(videova){
      final XFile? pickedFile = await ImagePicker().pickVideo(maxDuration: Duration(seconds: 30),
        source: ImageSource.gallery,
      );
      setState(() {
        isVideo=true;
        mediaPath=pickedFile?.path;
      });
      if(pickedFile!=null){
        _initializeVideoPlayer(pickedFile.path);
      }
    }else{
      final XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      setState(() {
        isVideo=false;
        mediaPath=pickedFile?.path;
      });
    }


  }

  String? mediaPath;
  bool isVideo =false;
  bool loading =false;
  @override
  Widget build(BuildContext context) {
    print('.');
    double screenHeight=MediaQuery.of(context).size.height;
    double screenWidth=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post",style: Theme.of(context).textTheme.bodyLarge?.apply(fontSizeDelta: 4,color: Colors.black),),
      ),
      bottomSheet: BottomSheet(
        onClosing: () {  },
        builder: (BuildContext context) {
          return Container(
            color: Colors.grey.shade100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: ()async{
                            setState(() {
                              loading=true;
                            });
                            if(mediaPath != null) {
                              String path="${FirebaseAuth.instance.currentUser!.uid}"
                                  "/${DateTime.now()
                                  .toString()}${mediaPath
                                  ?.split('/')
                                  .last}";
                              Reference storageReference = FirebaseStorage
                                  .instance.ref().child(
                                  path);

                              UploadTask uploadTask = storageReference.putFile(
                                  io.File(mediaPath!));

                              await uploadTask.whenComplete(() =>
                                  print("Image uploaded"));

                              String url = await storageReference
                                  .getDownloadURL();

                              if(await(PostManagement.postAPost(
                                  mediaUrl: url,
                                  mediaType: isVideo?2 :1,
                                  mediaPath: path,
                                  text: contentController.text
                              ))){
                                Navigator.pop(context);
                              }
                            } else if (contentController.text.isNotEmpty){
                              if(await(PostManagement.postAPost(
                                  mediaUrl: '',
                                  mediaType: 0,
                                  text: contentController.text
                              ))){Navigator.pop(context);}
                            }else{
                              Fluttertoast.showToast(msg: "Please Add Content");
                            }
                            setState(() {
                              loading=false;
                            });
                          },
                          child: Container(
                            height: 34,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.blue.shade800,
                            ),

                            child: Center(
                              child: Text(loading?"Please Wait..." :"Post",style: Theme.of(context).textTheme.bodyMedium?.apply(color: Colors.white,fontSizeDelta: 2,fontWeightDelta: 2),),
                            ),

                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },

      ),

      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<UserCubit, UserState>(
              builder: (context, userState) {
                UserModel? currentUser;
                if(userState is UserSuccess){
                  currentUser=(userState.props.first as UserModel);
                }
                return Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                          right: 15,
                        ),
                        child: Container(
                          height: 40,width: 40,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
                          child: ImageWidget(url: currentUser?.userProfileImg),
                        )
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(currentUser?.name ??'User_name',style: Theme.of(context).textTheme.bodyLarge?.apply(fontSizeDelta: 2,color: Colors.black),)
                        // ,SizedBox(height: 4,),
                        //  Text("")
                      ],
                    )
                  ],
                );
              },
            ),

            const SizedBox(height: 16,),
            TextFormField(
              controller: contentController,
              maxLines: 2,
              decoration: InputDecoration(
                hintStyle: Theme.of(context).textTheme.labelLarge?.apply(fontSizeDelta: 2,color: Colors.grey.shade400),
                hintText: "What's on Your Mind ?",
                contentPadding: const EdgeInsets.only(left: 4,right: 12)
              ),
            ),
            const SizedBox(height: 8,),
            Expanded(
              child: Container(
                width: screenWidth,
                // margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.only(top: 15),
                decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.circular(6),
                // border: Border.symmetric( horizontal: BorderSide(color: Colors.grey.shade300,))
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisSize: MainAxisSize.max,
                  children: [
                    mediaPath == null ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 8,left: 8),
                          height: 100,
                          width: 140,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.blueGrey.withOpacity(0.4))
                          ),
                          child:  Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Divider(color: Colors.grey,),
                              Expanded(
                                child: InkWell(
                                  onTap: (){
                                    _pickPostImage(false);
                                  },
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.image_outlined),
                                        SizedBox(width: 4,),
                                        Text('Image'),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8,left: 8,right: 8),
                          height: 100,
                          width: 140,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.blueGrey.withOpacity(0.4))
                          ),
                          child:  Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Divider(color: Colors.grey,),
                              Expanded(
                                child: InkWell(
                                  onTap: (){
                                    _pickPostImage(true);
                                  },
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.video_collection_outlined),
                                        SizedBox(width: 4,),
                                        Text('Video'),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                    : Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                            height: 300,width: 300,
                              color: Colors.grey.shade100,
                              child: isVideo?
                              _chewieController != null && _chewieController.videoPlayerController.value.isInitialized
                                  ? Chewie(
                                controller: _chewieController,
                              )
                                  : Text('Pick a video to play')
                              : InteractiveViewer(child: Image.file(io.File(mediaPath!)))),
                          const SizedBox(height: 12,),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: (){
                                setState(() {
                                  mediaPath=null;
                                });
                              },
                              child: const Text("Remove"),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red,padding: EdgeInsets.symmetric(horizontal: 8 )),
                            ),
                          )
                        ],
                      ),
                    )


                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

}
