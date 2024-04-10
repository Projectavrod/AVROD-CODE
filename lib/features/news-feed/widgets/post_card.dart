import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:avrod/Widgets/image_widget.dart';
import 'package:avrod/constants/global_variables.dart';
import 'package:avrod/features/comment/screens/comment_screen.dart';
import 'package:avrod/features/news-feed/screen/image_fullscreen.dart';
import 'package:avrod/features/news-feed/screen/liked_users_screen.dart';
import 'package:avrod/features/news-feed/screen/multiple_images_post_screen.dart';
import 'package:avrod/features/news-feed/widgets/post_content.dart';
import 'package:avrod/models/post.dart';
import 'package:avrod/models/post_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

import '../../../cubits/getAllUsersDetails/getAllUsersdetails_cubit.dart';
import '../../../models/user_model.dart';
import '../../../services/firebase_post.dart';
import '../../notifications/widgets/prevideoplayer_widget.dart';
import '../../personal-page/screens/personal_page_screen.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
   PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {

  List<String> icons = [];
  String reactions = '0';
  String userId=FirebaseAuth.instance.currentUser?.uid??'';
  double leftImageHeight = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<GetAllUsersDetailsCubit, GetAllUsersDetailsState>(
  builder: (context, allUserState) {
    if(allUserState is GetAllUsersDetailsLoaded){
      List<UserModel> allUsersList=allUserState.props.first as  List<UserModel>;
      UserModel postedUser=allUsersList.firstWhere((element) => element.userId==widget.post.userId);
      print(widget.post.media);
      return IgnorePointer(
          ignoring: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: (){
                            print('object');
                            Navigator.pushNamed(
                              context,
                              PersonalPageScreen.routeName,
                              arguments: widget.post.userId,
                            );
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black12,
                                width: 0.5,
                              ),
                            ),
                            child: Container(
                              height: 40,width: 40,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
                              child: ImageWidget(url: postedUser.userProfileCoverImg),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print('object');
                                        Navigator.pushNamed(
                                          context,
                                          PersonalPageScreen.routeName,
                                          arguments: widget.post.userId,
                                        );
                                      },
                                      child:  Text(
                                        postedUser.name ??"",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${DateFormat('dd/MM/yyyy  hh:ss').format(widget.post.createdAt!.toDate())}",
                                    style: const TextStyle(
                                        color: Colors.black54, fontSize: 14),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 2),
                                    child: Icon(
                                      Icons.circle,
                                      size: 2,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    widget.post.shareWith == 'public'
                                        ? Icons.public
                                        : widget.post.shareWith == 'friends'
                                        ? Icons.people
                                        : widget.post.shareWith ==
                                        'friends-of-frends'
                                        ? Icons.groups
                                        : Icons.lock,
                                    color: Colors.black54,
                                    size: 14,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    (widget.post.userId == FirebaseAuth.instance.currentUser?.uid)?
                    PopupMenuButton<int>(
                      padding: EdgeInsets.all(0),
                      constraints: BoxConstraints(maxHeight: 40,maxWidth: 80),
                      onSelected: (item) {
                        if(item ==1){
                          FirebaseFirestore.instance.collection('posts').doc(widget.post.postId).delete();
                          // Create a reference to the file to delete
                          if(widget.post.mediaPath != null){
                            final desertRef = FirebaseStorage
                                .instance.ref().child(widget.post.mediaPath!);
                            // Delete the file
                            desertRef.delete()
                            //     .onError((error, stackTrace) {
                            //   print('-----------------------error');
                            //   print(error);
                            // })
                            ;
                          }

                        }
                      },
                      color: Colors.red.shade200,
                      itemBuilder: (context) => [
                        const PopupMenuItem<int>(value: 1, child: Center(child: SizedBox(height:40,child: Text('Delete')))),
                      ],
                    )
                    :const SizedBox.shrink(),
                  ],
                ),
              ),
              SizedBox(height: 4,),
              if(widget.post.text != null && widget.post.text?.isNotEmpty==true)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
                  child: Text(widget.post.text??''),
                ),
              ),
              // SizedBox(height: 4,),
              (widget.post.type == 1)?
              GestureDetector(
                onTap: () {

                },
                child:Container(
                  color: Colors.grey.shade200,
                  child: CachedNetworkImage(fit: BoxFit.fitHeight,height: 320,width: MediaQuery.of(context).size.width,
                    imageUrl: widget.post.media??'',
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        Center(
                          child: Container(
                            height: 50,width: 50,
                              child: CircularProgressIndicator(value: downloadProgress.progress)),
                        ),
                    errorWidget: (context, url, error) => const Icon(CupertinoIcons.photo_on_rectangle,size: 150,),
                  ),
                ),
              )
              :(widget.post.type==2)?
              SizedBox(
                  height:320,
                  child: PreVideoPlayerWidget(url:widget.post.media))
                  :const SizedBox.shrink(),

              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, LikedUsersScreen.routeName,
                        arguments: widget.post.postId);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 8,
                      left: 15,
                      right: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 142,
                              child: Row(
                                children: [
                                  Icon(Icons.thumb_up_alt_rounded,size: 14,color:(widget.post.likes?.length??0)>=1?Colors.blue:Colors.grey,),
                                  const SizedBox(width: 6,),
                                  Text("${widget.post.likes?.length??''}",style: Theme.of(context).textTheme.bodySmall,),
                                  const SizedBox(width: 8,),
                                  // Icon(Icons.mode_comment_rounded,size: 14,color: Colors.grey,),
                                  // const SizedBox(width: 6,),
                                  // Text(
                                  //   reactions,
                                  //   style: const TextStyle(
                                  //     color: Colors.black54,
                                  //     fontSize: 14,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),

                          ],
                        ),
                        // Row(
                        //   children: [
                        //     widget.post. != null
                        //         ? Text(
                        //       '${widget.post.commands?.first.command??''} comments',
                        //       style: const TextStyle(
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.w400,
                        //         color: Colors.black54,
                        //       ),
                        //     )
                        //         : const SizedBox(),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              if (widget.post.type != 'memory')
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: Colors.black38,
                    height: 0,
                  ),
                ),
              if (widget.post.type != 'memory')
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async{
                        String userId=FirebaseAuth.instance.currentUser?.uid??'';
                        // isAlredyLiked = widget.post.likes?.contains(userId)??false;

                        await PostManagement.postLike(userId:userId, receiverUserId: widget.post.userId??'', postId: widget.post.postId??'', isAdd: (widget.post.likes?.contains(userId)??false)?false:true);

                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 11.5,
                        ),
                        alignment: Alignment.center,
                        width: (MediaQuery.of(context).size.width) / 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (widget.post.likes?.contains(userId)??false)?Icon(Icons.thumb_up_alt_rounded,color: Colors.blue,size: 20,):ImageIcon(
                              AssetImage('assets/images/like.png'),
                              size: 24,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Like',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, CommentScreen.routeName,
                            arguments: widget.post);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        alignment: Alignment.center,
                        width: (MediaQuery.of(context).size.width) / 3,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              AssetImage('assets/images/comment.png'),
                              size: 22,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Comment',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {},
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(
                    //       vertical: 10,
                    //     ),
                    //     alignment: Alignment.center,
                    //     width: (MediaQuery.of(context).size.width) / 3,
                    //     child: const Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         ImageIcon(
                    //           AssetImage('assets/images/share.png'),
                    //           size: 27,
                    //         ),
                    //         Padding(
                    //           padding: EdgeInsets.only(left: 10),
                    //           child: Text(
                    //             'Share',
                    //             style: TextStyle(
                    //               fontSize: 15,
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // )
                  ],
                ),
            ],
          )

      );
    }else{
      return Container();
    }

  },
);
  }
}
