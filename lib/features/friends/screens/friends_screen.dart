import 'package:avrod/Widgets/text_widget.dart';
import 'package:avrod/cubits/getUserData/user_cubit.dart';
import 'package:avrod/features/friends/screens/friends_search_screen.dart';
import 'package:avrod/features/friends/screens/friends_suggest_screen.dart';
import 'package:avrod/features/personal-page/screens/personal_page_screen.dart';
import 'package:avrod/models/user_model.dart';
import 'package:avrod/services/firebase_post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/user.dart';

class FriendsScreen extends StatefulWidget {
  static const String routeName = '/friends-screen';
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class FriendRequest {
  final UserData user;
  final String time;
  final int? mutualFriends;
  final UserData? f1;
  final UserData? f2;
  FriendRequest({
    required this.user,
    required this.time,
    this.mutualFriends,
    this.f1,
    this.f2,
  });
}

class _FriendsScreenState extends State<FriendsScreen> {
  final today = DateTime.now();
  final friends = [
    FriendRequest(
      user: UserData(
        name: 'Minh Hương',
        avatar: 'assets/images/user/minhhuong.jpg',
      ),
      time: '1 tuần',
      mutualFriends: 25,
      f1: UserData(
        name: 'Khánh Vy',
        avatar: 'assets/images/user/khanhvy.jpg',
      ),
      f2: UserData(
        name: 'Leo Messi',
        avatar: 'assets/images/user/messi.jpg',
      ),
    ),
    FriendRequest(
      user: UserData(
        name: 'Khánh Vy',
        avatar: 'assets/images/user/khanhvy.jpg',
      ),
      time: '3 tuần',
      mutualFriends: 1,
      f1: UserData(
        name: 'Bảo Ngân',
        avatar: 'assets/images/user/baongan.jpg',
      ),
    ),
    FriendRequest(
      user: UserData(
        name: 'Vương Hồng Thúy',
        avatar: 'assets/images/user/vuonghongthuy.jpg',
      ),
      time: '2 tuần',
    ),
    FriendRequest(
      user: UserData(
        name: 'Leo Messi',
        avatar: 'assets/images/user/messi.jpg',
      ),
      mutualFriends: 455,
      f1: UserData(
        name: 'Minh Hương',
        avatar: 'assets/images/user/minhhuong.jpg',
      ),
      f2: UserData(
        name: 'Hà Linhh',
        avatar: 'assets/images/user/halinh.jpg',
      ),
      time: '2 năm',
    ),
    FriendRequest(
      user: UserData(
        name: 'Nguyễn Thị Minh Tuyền',
        avatar: 'assets/images/user/minhtuyen.jpg',
      ),
      time: '2 năm',
    ),
    FriendRequest(
      user: UserData(
        name: 'Hà Linhh',
        avatar: 'assets/images/user/halinh.jpg',
      ),
      time: '4 năm',
    ),
    FriendRequest(
      user: UserData(
        name: 'Bảo Ngân',
        avatar: 'assets/images/user/baongan.jpg',
      ),
      time: '5 năm',
    ),
    FriendRequest(
      user: UserData(
        name: 'Doraemon',
        avatar: 'assets/images/user/doraemon.jpg',
      ),
      time: '1 tuần',
    ),
    FriendRequest(
      user: UserData(
        name: 'Minh Trí',
        avatar: 'assets/images/user/minhtri.jpg',
      ),
      time: '4 tuần',
    ),
    FriendRequest(
      user: UserData(
        name: 'Sách Cũ Ngọc',
        avatar: 'assets/images/user/sachcungoc.jpg',
      ),
      time: '1 tuần',
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.5),
              child: Container(
                color: Colors.black12,
                height: 0.5,
              )),
          centerTitle: true,
          title: Text_Widget(
            'Friends',
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w900,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           const SizedBox(height: 24,),

            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if(state is UserSuccess) {
                  UserModel user=state.props.first as UserModel;

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text_Widget(
                                    'Friend Requests',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text_Widget(
                                    user.receivedRequests?.length.toString(),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,

                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        for (int i = 0; i < (user.receivedRequests?.length ??0); i++)
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                  top: 0,
                                  bottom: 0,
                                  right: 0,
                                ),
                                child: FutureBuilder(
                                  future: FirebaseFirestore.instance.collection('users').doc(user.receivedRequests?[i]).get(),
                                  builder: (context,userData) {
                                    Map<String,dynamic>? data= userData.data?.data();
                                    if(userData.connectionState == ConnectionState.done && data != null) {

                                      return InkWell(
                                        onTap: (){
                                          Navigator.pushNamed(
                                            context,
                                            PersonalPageScreen.routeName,
                                            arguments: userData.data!.id,
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
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
                                                  backgroundColor: Colors.grey.shade200,
                                                  radius: 26,
                                                  child: CachedNetworkImage(
                                                    imageUrl: data['photo']??'',
                                                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                        CircularProgressIndicator(value: downloadProgress.progress),
                                                    errorWidget: (context, url, error) => const Icon(CupertinoIcons.person_alt_circle,size: 50,),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(
                                                        data['name']??'',
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 2,),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              UserManagement.acceptFriendRequest(receiverUserId:userData.data?.id ??'' );
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              shadowColor: Colors.transparent,
                                                              backgroundColor: Colors.blue[700],
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(8),
                                                              ),
                                                            ),
                                                            child: const Text(
                                                              'Confirm',
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              print(userData.data?.id ??'');
                                                              UserManagement.withdrawFriendRequest(receiverUserId:userData.data?.id ??'' );
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              shadowColor: Colors.transparent,
                                                              backgroundColor: Colors.grey[300],
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(8),
                                                              ),
                                                            ),
                                                            child: const Text(
                                                              'Delete',
                                                              style: TextStyle(
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      );
                                    }else{
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Row(
                                          children: [
                                            DecoratedBox(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey.shade200,
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 0.5,

                                                ),
                                              ),
                                              child: const CircleAvatar(
                                                // backgroundImage: AssetImage(
                                                //     friends[i].user.avatar),
                                                radius: 20,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    children: [


                                                      Padding(
                                                          padding: const EdgeInsets.only(
                                                            bottom: 4,
                                                          ),
                                                          child: Container(
                                                            height: 15,width: 200,
                                                            color: Colors.grey.shade300,
                                                          )
                                                      ),
                                                      Container(
                                                        height: 10,width: 150,
                                                        color: Colors.grey.shade300,
                                                      ),
                                                    ],
                                                  ),
                                                  IconButton(
                                                    onPressed: (){},
                                                    padding: const EdgeInsets.all(0),
                                                    splashRadius: 23,
                                                    icon: const Icon(
                                                      Icons.more_horiz_rounded,
                                                      color: Colors.black87,
                                                      size: 25,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }

                                  },
                                ),
                              ),
                              const Divider(thickness: 1.5,)
                            ],
                          )
                      ],
                    ),
                  );
                }else{
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),

          ],
        ),
      ),
    );
  }
}
