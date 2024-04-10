import 'dart:io' as io;
import 'dart:math';
import 'package:avrod/Screens/post_page/postmian.dart';
import 'package:avrod/Widgets/image_widget.dart';
import 'package:avrod/cubits/getUserData/user_cubit.dart';
import 'package:avrod/cubits/getallpost_cubit/getallpost_cubit.dart';
import 'package:avrod/features/friends/screens/friends_search_screen.dart';
import 'package:avrod/models/user_model.dart';
import 'package:avrod/services/firebase_post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/profile_coverImageUpdate_cubit/profilecoverupdate_cubit.dart';
import '../../../models/post.dart';
import '../../../models/post_model.dart';
import '../../../models/user.dart';
import '../../news-feed/widgets/post_card.dart';
import 'edit_profile.dart';

class PersonalPageScreen extends StatefulWidget {
  static const String routeName = '/personal-page';
  final String userId;
  const PersonalPageScreen({super.key, required this.userId});

  @override
  State<PersonalPageScreen> createState() => _PersonalPageScreenState();
}

class _PersonalPageScreenState extends State<PersonalPageScreen> {
  final TextEditingController searchController = TextEditingController();
  final Random random = Random();
  String pickedCoverImagePath='';
  String pickedProfileImagePath='';

  int mutualFriends = 0;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    bool isMine = (widget.userId == FirebaseAuth.instance.currentUser?.uid);
    return BlocProvider(
  create: (context) => ProfilecoverupdateCubit(),
  child: Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0.5),
            child: Container(
              color: Colors.black12,
              width: double.infinity,
              height: 0.5,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            splashRadius: 20,
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ProfilecoverupdateCubit, ProfilecoverupdateState>(
  builder: (context, profileState) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(widget.userId).snapshots(),
        builder: (context, snap) {
    if(snap.hasData){

      UserModel? useru=UserModel.fromJson(snap.data?.data() ??{});
      var frs=useru.friends;
      print(frs);
      frs?.add(useru.userId!);
      bool isFriend = (useru.friends?.contains(FirebaseAuth.instance.currentUser?.uid)  )==true;
      bool reqested = (useru.receivedRequests?.contains(FirebaseAuth.instance.currentUser?.uid)  )==true;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              const SizedBox(
                width: double.infinity,
                height: 270,
              ),
              // user.cover != null ?
              pickedCoverImagePath==''?(useru.userProfileCoverImg !=''&&useru.userProfileCoverImg !=null)?CachedNetworkImage(
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                height: 200,
                imageUrl: useru.userProfileCoverImg??'',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                      child: Container(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(value: downloadProgress.progress)),
                    ),
                errorWidget: (context, url, error) => const Icon(CupertinoIcons.person_alt_circle,size: 40,),
              ):Container(
                height: 220,
                color: Colors.grey.shade100,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text('AVROD',style: Theme.of(context).textTheme.bodyLarge?.apply(fontWeightDelta: 2,fontSizeDelta: 2,color: Colors.blue),),
                ),
              ):Image.file(
                io.File(pickedCoverImagePath),
                fit: BoxFit.cover,
                height: 220,
                width: double.infinity,
              ),
              //     : Container(
              //   width: double.infinity,
              //   height: 220,
              //   color: Colors.grey,
              // ),
              Positioned(
                left: 15,
                bottom: 0,
                child: Stack(
                  children: [
                    InkWell(
                      onTap: ()async{
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: pickedProfileImagePath==''?useru.userProfileImg !=''?CircleAvatar(
                          backgroundImage:NetworkImage(
                            useru.userProfileImg??'',
                            // progressIndicatorBuilder: (context, url, downloadProgress) =>
                            //     CircularProgressIndicator(value: downloadProgress.progress),
                            // errorWidget: (context, url, error) => const Icon(CupertinoIcons.person_alt_circle,size: 40,),
                          ) ,

                          radius: 75,
                        ):const CircleAvatar(
                          child: Icon(Icons.person,color: Colors.grey,size: 70,),
                          radius: 75,
                        ):CircleAvatar(backgroundImage: FileImage(io.File(pickedProfileImagePath)),
                          radius: 75,
                        ),
                      ),
                    ),
                    // if (user.guard == true)
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Image.asset(
                          'assets/images/guard.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    if (isMine)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: ()async{
                            pickedProfileImagePath= await context.read<ProfilecoverupdateCubit>().pickProfileImage(useru.userId??'',useru.userProfileImg??'');
                            setState(() {

                            });
                          },
                          child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.black,
                                size: 22,
                              )),
                        ),
                      ),
                  ],
                ),
              ),
              if (isMine)
                Positioned(
                  bottom: 65,
                  right: 15,
                  child: InkWell(
                    onTap: ()async{
                      pickedCoverImagePath=await context.read<ProfilecoverupdateCubit>().pickCoverImage(useru.userId??'',useru.userProfileImg??'');
                      setState(() {

                      });
                    },
                    child: Column(
                      children: [
                        // Container(
                        //   padding: const EdgeInsets.all(9),
                        //   decoration: BoxDecoration(
                        //     color: Colors.blue[700],
                        //     shape: BoxShape.circle,
                        //   ),
                        //   child: const ImageIcon(
                        //     AssetImage('assets/images/avatar.png'),
                        //     color: Colors.white,
                        //     size: 20,
                        //   ),
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.black,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      useru.name??'User_Name',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                const SizedBox(
                  height: 5,
                ),
                if (useru.bio != null)
                  Text(
                    useru.bio!,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                // (isMine)
                //     ?
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child:
                          ((isMine || isFriend || reqested))?
                          ElevatedButton(
                              onPressed: () {
                                if(isMine) {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          EditProfilePage(userData: useru)));
                                }else if(reqested){
                                  UserManagement.withdrawFriendRequest(receiverUserId: widget.userId);
                                }else if(isFriend){
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context){
                                    return Container(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 12,),
                                        Text("Are you want UnFriend ?",style: Theme.of(context).textTheme.bodyMedium?.apply(fontSizeDelta: 2,color: Colors.black),),
                                        const SizedBox(height: 8,),
                                        InkWell(
                                          onTap: ()async{
                                            await UserManagement.unFriedFriend(receiverUserId: useru.userId??"");
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
                                              color: Colors.grey.shade200
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 12.0,right: 12,top: 8,bottom: 8),
                                              child: Text('UnFriend',style: Theme.of(context).textTheme.bodyMedium?.apply(color: Colors.black),),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),);
                                  });
                                }
                                },
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(5),
                                ),
                                backgroundColor: Colors.grey[200],
                              ),
                              child:  Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    isMine?Icons.edit_rounded:isFriend? CupertinoIcons.person_crop_circle_fill_badge_checkmark :CupertinoIcons.person_badge_minus_fill,
                                    color: Colors.black,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    isMine?'Edit Profile':isFriend?'Friend':'Cancel request',
                                    style:  TextStyle(
                                      color: Colors.black,
                                      fontSize: isMine?16:isFriend?16:15,
                                    ),
                                  ),
                                ],
                              ))

                          :ElevatedButton(
                              onPressed: () {
                                UserManagement.sendFriendRequest(receiverUserId: widget.userId);
                              },
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(5),
                                ),
                                backgroundColor: Colors.blue[600],
                              ),
                              child: const Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Add Friend',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context, FriendsSearchScreen.routeName,
                                  arguments: useru.userId??''
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(5),
                                ),
                                backgroundColor: Colors.blue[600],
                              ),
                              child:  Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.group,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Friends (${(frs?.length??0)-1})',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    )
                  ],
                ),

              ],
            ),
          ),
          // if (isMine || user.type == 'page')
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            ),
          const SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!(useru.location == null && useru.education==null && useru.bio==null) )
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                if (useru.bio != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4,
                      bottom: 10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.note_alt_rounded,
                          size: 25,
                          color: Colors.black54,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: useru.bio,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                // const TextSpan(
                                //   text: ' · ',
                                //   style: TextStyle(
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                // TextSpan(
                                //   text: 'Page Type',
                                //   style: const TextStyle(
                                //     fontWeight: FontWeight.w400,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (useru.education != null)
                //   for (int i = 0; i < user.educations!.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.school_rounded,
                            size: 25,
                            color: Colors.black54,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                    '${useru.education}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  // TextSpan(
                                  //   text: user.educations![i].school,
                                  //   style: const TextStyle(
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                if (useru.location != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          size: 25,
                          color: Colors.black54,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              children: [
                                 TextSpan(
                                  text: '${useru.location}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                // TextSpan(
                                //   text: user.hometown,
                                //   style: const TextStyle(
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

              ],
            ),
          ),


          if (true)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Posts',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  if (isMine)
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const PostMainPage()));
                      },
                      child: Text(
                        'Add Post',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue[700],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          const SizedBox(
            height: 10,
          ),
          if (isMine)
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const PostMainPage()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                          right: 10,
                        ),
                        child: Container(
                          height: 40,width: 40,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
                          child: ImageWidget(url: FirebaseAuth.instance.currentUser?.photoURL??''),
                        )
                    ),
                    Expanded(
                      child: Text(
                        "What's on your Mind? ${useru.name}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const PostMainPage()));
                      },
                      icon: const Icon(
                        Icons.image,
                        color: Colors.green,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(
            height: 10,
          ),
          if (isMine)
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      shadowColor: Colors.transparent,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.chat_rounded,
                            color: Colors.black, size: 18),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Post Your Thoughts',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isMine)
          const SizedBox(
            height: 10,
          ),

          Container(
            width: double.infinity,
            height: (isMine)? 10:0.2,
            color: Colors.grey,
          ),

          StreamBuilder(
                  stream:  FirebaseFirestore.instance.collection('posts')
                      .where("userId",whereIn: frs )
                      .orderBy('createdAt',descending: true)
                      .snapshots(),
                  builder: (context, snap) {
                    if(snap.hasData){

                      List<PostModel> postsMain =[];
                      snap.data?.docs.forEach((element) {
                        var post = PostModel.fromJson(element.data());
                        postsMain.add(post);
                      });
                      List<PostModel> posts =postsMain.where((element) => element.userId==useru.userId).toList();
                      return posts.isEmpty?Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 42,width: double.infinity,),
                          Icon(Icons.signpost_rounded,size: 38,color: Colors.grey,),
                          const SizedBox(height: 12,),
                          Text("No Post Found"),
                        ],
                      )
                          :Column(
                        children: [
                          for (int i = 0; i < posts.length; i++)
                            Column(
                              children: [
                                const SizedBox(height: 10),
                                PostCard(
                                  post: posts[i],
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 5,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                        ],
                      );

                    }else if(snap.connectionState == ConnectionState.waiting){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }else {
                      return Container();
                    }
                  },
                ),

        ],
      );
    }else{
      return const Column(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 66,),
          Center(child: SizedBox(height: 28,width: 28,child: CircularProgressIndicator(strokeWidth: 1.8,color: Colors.blue,),)),
        ],
      );
    }

  },
);
  },
))),
);
  }
}
