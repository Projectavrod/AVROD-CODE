import 'dart:io';

import 'package:avrod/cubits/videoPlayerUpdateCubit/video_player_update_cubit.dart';
import 'package:avrod/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:io' as io;
import '../../../cubits/getmessages_cubit/getmessages_cubit.dart';
import '../../../cubits/individualchatvideoview/indiavidul_chat_video_view_cubit.dart';
import '../../../cubits/sendmessage_cubit/send_message_cubit.dart';
import '../../../models/sendermessagemodel.dart';
import '../../notifications/widgets/prevideoplayer_widget.dart';
import 'individualchatvideoplayer.dart';

class ChatScreenPage extends StatefulWidget {
  const ChatScreenPage(
      {Key? key, required this.chatUserid, required this.userDetails})
      : super(key: key);
  final UserModel userDetails;
  final String chatUserid;

  @override
  State<ChatScreenPage> createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  TextEditingController messageController = TextEditingController();

  // List<ChatModel> messageList = [];
  final ScrollController _scrollController = ScrollController();

  // final FlutterTts flutterTts=FlutterTts();
  String message = '';
  bool jspeak = false;

  // speak(String msg)async{
  //   await flutterTts.setLanguage("en");
  //   await flutterTts.setPitch(8);
  //   await flutterTts.speak(msg);
  //   await flutterTts.setSpeechRate(15);
  // }

  @override
  void initState() {
    // TODO: implement initState
    // context.read<GetmessagesCubit>().getMessage(widget.chatUserid ?? '');
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    // addChatMessage();
    // context.read<VoicetotextcubitCubit>().initSpeech();
    // addChatMessage();

    // });
    // addChatMessage();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {});
    });

    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      if (_scrollController.positions.isNotEmpty &&
          _scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      }
    });
  }

  void addChatMessage() {
    // setState(() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    // });
  }

  String? mediaPath;
  bool updated = false;
  String? mediaName;
  bool isVideo = false;

  Future<void> _pickPostImage(bool videova) async {
    final XFile? pickedFile = await ImagePicker().pickMedia(

    );
    final extension = pickedFile?.path
        .split('.')
        .last
        .toLowerCase();


    if (extension == 'jpg' || extension == 'jpeg' || extension == 'png') {
      setState(() {
        isVideo = false;
        mediaPath = pickedFile?.path;
        mediaName = pickedFile?.name;
        // for (var element in pickedFile) {
        //   mediaName.add(element.name);
        //   mediaPath.add(element.path);
        //   // if(pickedFile!=null){
        //   //   _initializeVideoPlayer(pickedFile.first.path);
        //   // }
        // }
      });
    } else if (extension=="mp4"){
      setState(() {
        isVideo = true;
        mediaPath = pickedFile?.path;
        mediaName = pickedFile?.name;
        // _initializeVideoPlayer(pickedFile?.path??'');
        context
            .read<VideoPlayerUpdateCubit>()
            .updatePlayerFromFile(imagePath: pickedFile?.path ?? '');
      });
    }else{
      Fluttertoast.showToast(msg: "File format not supported, Please try any other formats");
    }
  }

  Future<void> _pickImageFromCam() async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      imageQuality: 7,
      source: ImageSource.camera,
    );
    setState(() {
      isVideo = false;
      mediaPath = pickedFile?.path;
      mediaName = pickedFile?.name;
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    if (mounted) {
      Future.delayed(Duration.zero, () {
        context.read<VideoPlayerUpdateCubit>().disposeController();
        context.read<IndiavidulChatVideoViewCubit>().disposeController();
      });
    }

    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black12,
                  width: 0.5,
                ),
              ),
              child: CircleAvatar(
                radius: 20,
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: widget.userDetails.userProfileImg ?? '',
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(
                    CupertinoIcons.person_alt_circle,
                    size: 40,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.userDetails.name ?? '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        backgroundColor: Colors.blueAccent.withOpacity(0.2),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Column(
          //   children: [
          //     Row(mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Text("Send a Message to  ",style: TextStyle(fontSize: 14),),
          //         Text("${widget.name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
          //       ],
          //     ),
          //     const SizedBox(height: 4,),
          //     Container(height: 1,color: Colors.grey,),
          //   ],
          // ),

          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  // .where('receiverId',isEqualTo: userId,)
                  .where('participants', arrayContainsAny: [
                    FirebaseAuth.instance.currentUser?.uid,
                    widget.chatUserid
                  ])
                  .orderBy(
                    "createdAt",
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var messageList = snapshot.data!.docs;

                  if (messageList.isEmpty) {
                    return const Expanded(
                      child: Center(
                        child: Text('No Chats Yet'),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.only(
                              left: 8, right: 6, bottom: 12, top: 6),
                          controller: _scrollController,
                          itemCount: messageList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var message =
                                ChatModel.fromJson(messageList[index].data());
                            if ((message.receiverId == widget.chatUserid &&
                                    message.userId ==
                                        FirebaseAuth
                                            .instance.currentUser?.uid) ||
                                (message.userId == widget.chatUserid &&
                                    message.receiverId ==
                                        FirebaseAuth
                                            .instance.currentUser?.uid)) {
                              return UnconstrainedBox(
                                // constrainedAxis: Axis.horizontal,
                                alignment:
                                    ((message.userId == '${widget.chatUserid}')
                                        ? Alignment.centerLeft
                                        : Alignment.centerRight),
                                child: Container(
                                  padding: EdgeInsets.all(
                                      (message.messageType == 1) ? 8 : 10),
                                  margin: EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                      color: ((message.userId ==
                                              '${widget.chatUserid}')
                                          ? Colors.blueAccent
                                          : Colors.green[300]),
                                      borderRadius: BorderRadius.circular(8)),
                                  // ),
                                  child: Column(
                                    crossAxisAlignment: ((message.userId ==
                                            '${widget.chatUserid}')
                                        ? CrossAxisAlignment.start
                                        : CrossAxisAlignment.end),
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      (message.messageType == 1)
                                          ? CachedNetworkImage(
                                              width: 160,
                                              progressIndicatorBuilder:
                                                  (context, url, progress) =>
                                                      Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: progress.progress,
                                                ),
                                              ),
                                              imageUrl: message.message ?? '',
                                            )
                                          : (message.messageType == 2)
                                              ? SizedBox(
                                                  width: 200,
                                                  height: 280,
                                                  child: PreVideoPlayerWidget(
                                                      url: message.message))
                                              : (message.message!.length >= 15)
                                                  ? Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                              minWidth: 200,
                                                              maxWidth: 300),
                                                      child: Text(
                                                        "${message.message}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16,
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.95)),
                                                      ))
                                                  : Text(
                                                      "${message.message}",
                                                      softWrap: false,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16,
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.95)),
                                                    ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        mainAxisAlignment: ((message.userId ==
                                                '${widget.chatUserid}')
                                            ? MainAxisAlignment.start
                                            : MainAxisAlignment.end),
                                        children: [
                                          Text(
                                            "${DateFormat('hh:mm a').format(message.createdAt!.toDate().toLocal())}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12,
                                                color: Colors.white
                                                    .withOpacity(0.75)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          }),
                    );
                  }
                } else {
                  return Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: 24,
                      // width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.8,
                        color: Colors.orange,
                      ),
                    ),
                  );
                }
              }),
          Container(
            // color: Colors.grey.withOpacity(0.4),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8, bottom: 10.0, left: 12, right: 12),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.12))),
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    mediaPath != null
                        ? Stack(
                            children: [
                              (mediaName?.contains('.mp4') ?? false)
                                  ? BlocBuilder<VideoPlayerUpdateCubit,
                                          VideoPlayerUpdateState>(
                                      builder: (context, vidState) {
                                      if (vidState
                                          is VideoPlayerUpdateUpdated) {
                                        print(
                                            " ${vidState.chewieController.videoPlayerController.value.isInitialized}");
                                        return vidState.chewieController !=
                                                    null &&
                                                vidState
                                                    .chewieController
                                                    .videoPlayerController
                                                    .value
                                                    .isInitialized
                                            ? Container(
                                                height: 280,
                                                width: 200,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey
                                                            .withOpacity(
                                                                0.24))),
                                                child: Chewie(
                                                  controller:
                                                      vidState.chewieController,
                                                ),
                                              )
                                            : SizedBox();
                                      } else {
                                        return Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(0.24))),
                                          padding: EdgeInsets.all(100),
                                          child: SizedBox(
                                            height: 26,
                                            width: 26,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 0.8,
                                              color: Colors.orange,
                                            ),
                                          ),
                                        );
                                      }
                                    })
                                  : Image.file(
                                      width: 200,
                                      height: 200,
                                      io.File(mediaPath ?? "")),
                              Positioned(
                                  top: 0,
                                  right: 0,
                                  child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          if ((mediaName?.contains('.mp4') ??
                                              false)) {
                                            context
                                                .read<VideoPlayerUpdateCubit>()
                                                .disposeController();
                                          }
                                          mediaPath = null;
                                          mediaName = '';
                                        });
                                      },
                                      child: Icon(
                                        Icons.cancel,
                                        size: 22,
                                      )))
                            ],
                          )
                        : SizedBox(),
                    Row(
                      children: [
                        Expanded(
                          child: (mediaPath != null)
                              ? SizedBox()
                              : Container(
                                  height: 48,
                                  child: TextFormField(
                                    onTap: () {
                                      _scrollController.animateTo(
                                          _scrollController
                                              .position.maxScrollExtent,
                                          duration:
                                              Duration(milliseconds: 1000),
                                          curve: Curves.ease);
                                    },
                                    textAlignVertical: TextAlignVertical.center,
                                    readOnly: false,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                    expands: false,
                                    // enabled: false,
                                    controller: messageController,
                                    decoration: InputDecoration(
                                        suffixIcon: InkWell(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  backgroundColor: Colors.white,
                                                  constraints: BoxConstraints(
                                                    maxHeight:
                                                        screenHeight * 0.2,
                                                  ),
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                      padding: EdgeInsets.only(
                                                          top: 30,
                                                          bottom: 8,
                                                          right: 42,
                                                          left: 42),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              InkWell(
                                                                // decoration: BoxDecoration(
                                                                //     borderRadius: BorderRadius.circular(6),
                                                                //   color: Colors.white.withOpacity(0.4),
                                                                onTap: () {
                                                                  _pickImageFromCam().then(
                                                                      (value) =>
                                                                          Navigator.pop(
                                                                              context));
                                                                },
                                                                // ),

                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              30),
                                                                          color:
                                                                              Colors.blueAccent),
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .camera_alt,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          12,
                                                                    ),
                                                                    Text(
                                                                      "Camera",
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium
                                                                          ?.apply(
                                                                              fontWeightDelta: 2,
                                                                              color: Colors.black),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              InkWell(
                                                                // decoration: BoxDecoration(
                                                                //   borderRadius: BorderRadius.circular(6),
                                                                //   color: Colors.white.withOpacity(0.4),
                                                                // ),
                                                                // padding: EdgeInsets.all(12),
                                                                onTap: () {
                                                                  _pickPostImage(
                                                                          false)
                                                                      .then((value) =>
                                                                          Navigator.pop(
                                                                              context));
                                                                },
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              30),
                                                                          color:
                                                                              Colors.indigo),
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .image,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          12,
                                                                    ),
                                                                    Text(
                                                                        "Gallery",
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium
                                                                            ?.apply(
                                                                                fontWeightDelta: 2,
                                                                                color: Colors.black))
                                                                  ],
                                                                ),
                                                              ),
                                                              // InkWell(
                                                              //   // decoration: BoxDecoration(
                                                              //   //     borderRadius: BorderRadius.circular(6),
                                                              //   //   color: Colors.white.withOpacity(0.4),
                                                              //   onTap: () {
                                                              //     _pickPostImage(
                                                              //             true)
                                                              //         .then((value) =>
                                                              //             Navigator.pop(
                                                              //                 context));
                                                              //   },
                                                              //   // ),
                                                              //
                                                              //   child: Column(
                                                              //     children: [
                                                              //       Container(
                                                              //         decoration: BoxDecoration(
                                                              //             borderRadius: BorderRadius.circular(
                                                              //                 30),
                                                              //             color:
                                                              //                 Colors.blueAccent),
                                                              //         padding:
                                                              //             EdgeInsets.all(
                                                              //                 8),
                                                              //         child:
                                                              //             Center(
                                                              //           child:
                                                              //               Icon(
                                                              //             Icons
                                                              //                 .video_camera_back_outlined,
                                                              //             color:
                                                              //                 Colors.white,
                                                              //           ),
                                                              //         ),
                                                              //       ),
                                                              //       const SizedBox(
                                                              //         height:
                                                              //             12,
                                                              //       ),
                                                              //       Text(
                                                              //         "Video",
                                                              //         style: Theme.of(
                                                              //                 context)
                                                              //             .textTheme
                                                              //             .bodyMedium
                                                              //             ?.apply(
                                                              //                 fontWeightDelta: 2,
                                                              //                 color: Colors.black),
                                                              //       )
                                                              //     ],
                                                              //   ),
                                                              // ),
                                                              // Container(
                                                              //
                                                              //   // decoration: BoxDecoration(
                                                              //   //   borderRadius: BorderRadius.circular(6),
                                                              //   //   color: Colors.white.withOpacity(0.4),
                                                              //   // ),
                                                              //   // padding: EdgeInsets.all(12),
                                                              //   child: Column(
                                                              //     children: [
                                                              //       Container(
                                                              //         decoration: BoxDecoration(
                                                              //             borderRadius: BorderRadius.circular(30),
                                                              //             color: Colors.green
                                                              //         ),
                                                              //         padding: EdgeInsets.all(8),
                                                              //         child: Center(
                                                              //           child: Icon(Icons.location_pin,color: Colors.white,),
                                                              //         ),
                                                              //       ),
                                                              //       const SizedBox(height: 12,),
                                                              //       Text("Location",style: Theme.of(context).textTheme.bodyMedium?.apply(fontWeightDelta: 2,color: Colors.black))
                                                              //     ],
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ),
                                                          // const SizedBox(height: 18,),
                                                          // Row(
                                                          //   mainAxisAlignment: MainAxisAlignment.start,
                                                          //   children: [
                                                          //     InkWell(
                                                          //
                                                          //       // decoration: BoxDecoration(
                                                          //       //     borderRadius: BorderRadius.circular(6),
                                                          //       //   color: Colors.white.withOpacity(0.4),
                                                          //       onTap: (){
                                                          //         _pickPostImage(true).then((value) =>  Navigator.pop(context));
                                                          //       },
                                                          //       // ),
                                                          //
                                                          //       child: Column(
                                                          //         children: [
                                                          //           Container(
                                                          //             decoration: BoxDecoration(
                                                          //               borderRadius: BorderRadius.circular(30),
                                                          //               color: Colors.blueAccent
                                                          //             ),
                                                          //             padding: EdgeInsets.all(8),
                                                          //             child: Center(
                                                          //               child: Icon(Icons.video_camera_back_outlined,color: Colors.white,),
                                                          //             ),
                                                          //           ),
                                                          //           const SizedBox(height: 12,),
                                                          //           Text("Video",style: Theme.of(context).textTheme.bodyMedium?.apply(fontWeightDelta: 2,color: Colors.black),)
                                                          //         ],
                                                          //       ),
                                                          //     ),
                                                          // // InkWell(
                                                          // //
                                                          // //   // decoration: BoxDecoration(
                                                          // //   //   borderRadius: BorderRadius.circular(6),
                                                          // //   //   color: Colors.white.withOpacity(0.4),
                                                          // //   // ),
                                                          // //   // padding: EdgeInsets.all(12),
                                                          // //   onTap: (){
                                                          // //     _pickPostImage(false).then((value) =>  Navigator.pop(context));
                                                          // //   },
                                                          // //   child: Column(
                                                          // //         children: [
                                                          // //           Container(
                                                          // //             decoration: BoxDecoration(
                                                          // //               borderRadius: BorderRadius.circular(30),
                                                          // //               color: Colors.indigo
                                                          // //             ),
                                                          // //             padding: EdgeInsets.all(6),
                                                          // //             child: Center(
                                                          // //               child: Icon(Icons.image,color: Colors.white,),
                                                          // //             ),
                                                          // //           ),
                                                          // //           const SizedBox(height: 12,),
                                                          // //           Text("Gallery",style: Theme.of(context).textTheme.bodyMedium?.apply(fontWeightDelta: 2,color: Colors.black))
                                                          // //         ],
                                                          // //       ),
                                                          // // ),
                                                          // //     Container(
                                                          // //
                                                          // //       // decoration: BoxDecoration(
                                                          // //       //   borderRadius: BorderRadius.circular(6),
                                                          // //       //   color: Colors.white.withOpacity(0.4),
                                                          // //       // ),
                                                          // //       // padding: EdgeInsets.all(12),
                                                          // //       child: Column(
                                                          // //         children: [
                                                          // //           Container(
                                                          // //             decoration: BoxDecoration(
                                                          // //                 borderRadius: BorderRadius.circular(30),
                                                          // //                 color: Colors.green
                                                          // //             ),
                                                          // //             padding: EdgeInsets.all(6),
                                                          // //             child: Center(
                                                          // //               child: Icon(Icons.location_pin,color: Colors.white,),
                                                          // //             ),
                                                          // //           ),
                                                          // //           const SizedBox(height: 12,),
                                                          // //           Text("Location",style: Theme.of(context).textTheme.bodyMedium?.apply(fontWeightDelta: 2,color: Colors.black))
                                                          // //         ],
                                                          // //       ),
                                                          // //     ),
                                                          //   ],
                                                          // )
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: Icon(
                                              Icons.add_a_photo,
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                            )),
                                        isDense: false,
                                        enabled: true,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                                color: Colors.transparent)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                                color: Colors.transparent)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.01))),
                                        filled: true,
                                        contentPadding: EdgeInsets.only(
                                            left: 22, right: 18),
                                        fillColor:
                                            Color.fromRGBO(1, 21, 1, 0.6),
                                        hintStyle: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.7)),
                                        hintText: "Message"),
                                  ),
                                ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        BlocBuilder<SendMessageCubit, SendMessageState>(
                          builder: (context, state) {
                            if (state is SendMessageSended) {
                              // context.read<GetMessagesCubit>().getSilentMessage(widget.senderuserid,widget.receiverid??'');
                              context.read<SendMessageCubit>().reset();
                            }
                            return InkWell(
                              onTap: () async {
                                String userId =
                                    FirebaseAuth.instance.currentUser?.uid ??
                                        '';
                                if (messageController.text.isNotEmpty) {
                                  // context.read<SendMessageCubit>().sendMessage(userId,widget.chatUserid,messageController.text,0);
                                  if (_scrollController.hasClients) {
                                    _scrollController.animateTo(
                                        _scrollController
                                            .position.maxScrollExtent,
                                        duration: Duration(milliseconds: 800),
                                        curve: Curves.ease);
                                  }
                                  // messageController.text='';
                                  await context
                                      .read<SendMessageCubit>()
                                      .sendMessage(userId, widget.chatUserid,
                                          messageController.text, 0);

                                  messageController.clear();
                                } else {
                                  if (mediaPath != null &&
                                      mediaPath!.isNotEmpty) {
                                    if (mediaName != null &&
                                        (mediaName?.contains('.mp4') ??
                                            false)) {
                                      await context
                                          .read<SendMessageCubit>()
                                          .sendMessage(
                                              userId,
                                              widget.chatUserid,
                                              mediaPath ?? '',
                                              2);
                                    } else {
                                      await context
                                          .read<SendMessageCubit>()
                                          .sendMessage(
                                              userId,
                                              widget.chatUserid,
                                              mediaPath ?? '',
                                              1);
                                    }

                                    setState(() {
                                      mediaPath = null;
                                    });
                                  }
                                }
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                                child: (state is SendMessageLoading)
                                    ? const SizedBox(
                                        height: 16,
                                        width: 16,
                                        child: CircularProgressIndicator(
                                          color: Colors.orange,
                                          strokeWidth: 1,
                                        ),
                                      )
                                    : const Center(
                                        child: Icon(
                                        Icons.send,
                                        size: 22,
                                        color: Colors.grey,
                                      )),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),

      // bottomNavigationBar:
    );
  }
}
