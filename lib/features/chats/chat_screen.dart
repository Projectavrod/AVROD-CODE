import 'package:avrod/features/chats/widgets/chatscreen_detailed.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

import '../../Widgets/text_widget.dart';
import '../../models/user_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String userId= FirebaseAuth.instance.currentUser?.uid??'';
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Center(
    //     child: Text("No Chats Yet"),
    //   ),
    // );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blueAccent),
          elevation: 4,
          backgroundColor: Colors.blueAccent.shade200,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   margin: EdgeInsets.only(right: 12),
              //   clipBehavior: Clip.hardEdge,
              //   decoration: BoxDecoration(color: Colors.black,),
              //   height: 40,width: 40,
              //   child:Image.asset('assets/images/logo.jpeg'),
              // ),
              Text("Chats",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              // SizedBox(width: 6,),
              // SizedBox(width: 6,),
            ],
          ),

        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
          builder: (context, snap) {
            if(snap.hasData){
              UserModel? useru=UserModel.fromJson(snap.data?.data()??{});
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    SizedBox(height: 12,),
                    for (int i = 0; i < (useru.friends?.length ??0); i++)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              top: 10,
                              bottom: 10,
                              right: 0,
                            ),
                            child: FutureBuilder(
                              future: FirebaseFirestore.instance.collection('users').doc(useru.friends?[i]).get(),
                              builder: (context,userData) {
                                UserModel data = UserModel.fromJson(userData.data?.data()??{});
                                if(userData.connectionState == ConnectionState.done && data != null) {
                                  return InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreenPage( chatUserid: useru.friends?[i] ??'',userDetails:data)));
                                    },
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
                                          child:  CircleAvatar(
                                            radius: 20,
                                            child: CachedNetworkImage(
                                              imageUrl: data.userProfileImg??'',
                                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                  CircularProgressIndicator(value: downloadProgress.progress),
                                              errorWidget: (context, url, error) => const Icon(CupertinoIcons.person_alt_circle,size: 40,),
                                            ),
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
                                                  Text(
                                                    data.name??"",
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
                          Container(
                            height: 1.5,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey.shade300,

                          )
                        ],
                      ),

                  ],
                ),
              );
            }else{
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            // return Column(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(left: 8.0,right: 8),
            //       child: TextFormField(
            //         decoration: InputDecoration(
            //           constraints: BoxConstraints(
            //             maxHeight: 40
            //           ),
            // contentPadding: EdgeInsets.all(2.0),
            // filled: true,
            // fillColor: Colors.grey.withOpacity(0.3),
            // prefixIcon: Icon(Icons.search, color: Colors.grey,),
            // hintText: 'Search Messenger',
            // hintStyle: TextStyle(color: Colors.grey),
            // focusedBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //       color: Colors.transparent
            //   ),
            //   borderRadius: BorderRadius.all(Radius.circular(50.0)),
            // ),
            // enabledBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: Colors.transparent
            //   ),
            //   borderRadius: BorderRadius.all(Radius.circular(50.0)),
            // ),
            // border: OutlineInputBorder(
            //   borderSide: BorderSide(
            //       color: Colors.transparent
            //   ),
            //   borderRadius: BorderRadius.all(Radius.circular(50.0)),
            // ),)
            //       ),
            //     ),
            //     // SizedBox(height: 10,),
            //     // SingleChildScrollView(
            //     //   scrollDirection: Axis.horizontal,
            //     //   clipBehavior: Clip.none,
            //     //   padding: const EdgeInsets.only(left: 10),
            //     //   child: Row(
            //     //     children: [
            //     //       SizedBox(
            //     //         width: 80,
            //     //         height: 120,
            //     //         child: Column(
            //     //           crossAxisAlignment: CrossAxisAlignment.start,
            //     //           children: [
            //     //             Stack(
            //     //               children: [
            //     //                 Container(
            //     //                   width: 80,
            //     //                   height: 70,
            //     //                   decoration: BoxDecoration(
            //     //                     borderRadius: BorderRadius.circular(10),
            //     //                     boxShadow: [
            //     //                       BoxShadow(
            //     //                         color: Colors.grey.withOpacity(0.3),
            //     //                         spreadRadius: 0,
            //     //                         blurRadius: 30,
            //     //                       ),
            //     //                     ],
            //     //                   ),
            //     //                   child: Column(
            //     //                     children: [
            //     //                       Row(
            //     //                         children: [
            //     //                           ClipRRect(
            //     //                             borderRadius:
            //     //                             BorderRadius.circular(10),
            //     //                             child: Image.asset(
            //     //                               'assets/images/user/tthtsv.jpg',
            //     //                               fit: BoxFit.cover,
            //     //                               width: 60,
            //     //                               height: 60,
            //     //                             ),
            //     //                           ),
            //     //                           const SizedBox(
            //     //                             width: 20,
            //     //                           ),
            //     //                         ],
            //     //                       ),
            //     //                     ],
            //     //                   ),
            //     //                 ),
            //     //                 Positioned(
            //     //                   bottom: 5,
            //     //                   right: 5,
            //     //                   child: Container(
            //     //                     width: 15,
            //     //                     height: 15,
            //     //                     alignment: Alignment.center,
            //     //                     decoration: BoxDecoration(
            //     //                         shape: BoxShape.circle,
            //     //                         color: Colors.green,
            //     //                         border: Border.all(
            //     //                           color: Colors.black12,
            //     //                           width: 0.5,
            //     //                         )),
            //     //                   ),
            //     //                 )
            //     //               ],
            //     //             ),
            //     //             const SizedBox(
            //     //               width: 60,
            //     //               child: Text(
            //     //                 'Trung Tâm Hỗ Trợ Sinh Viên - Trường ĐH. Khoa học Tự nhiên, ĐHQG-HCM',
            //     //                 style: TextStyle(
            //     //                   color: Colors.black54,
            //     //                   fontSize: 12,
            //     //                 ),
            //     //                 maxLines: 2,
            //     //                 overflow: TextOverflow.ellipsis,
            //     //                 textAlign: TextAlign.center,
            //     //               ),
            //     //             ),
            //     //           ],
            //     //         ),
            //     //       ),
            //     //       const SizedBox(
            //     //         width: 10,
            //     //       ),
            //     //       SizedBox(
            //     //         width: 80,
            //     //         height: 120,
            //     //         child: Column(
            //     //           crossAxisAlignment: CrossAxisAlignment.start,
            //     //           children: [
            //     //             Stack(
            //     //               children: [
            //     //                 Container(
            //     //                   width: 80,
            //     //                   height: 70,
            //     //                   decoration: BoxDecoration(
            //     //                     borderRadius: BorderRadius.circular(10),
            //     //                     boxShadow: [
            //     //                       BoxShadow(
            //     //                         color: Colors.grey.withOpacity(0.3),
            //     //                         spreadRadius: 0,
            //     //                         blurRadius: 30,
            //     //                       ),
            //     //                     ],
            //     //                   ),
            //     //                   child: Column(
            //     //                     children: [
            //     //                       Row(
            //     //                         children: [
            //     //                           ClipRRect(
            //     //                             borderRadius:
            //     //                             BorderRadius.circular(10),
            //     //                             child: Image.asset(
            //     //                               'assets/images/user/goal.png',
            //     //                               fit: BoxFit.cover,
            //     //                               width: 60,
            //     //                               height: 60,
            //     //                             ),
            //     //                           ),
            //     //                           const SizedBox(
            //     //                             width: 20,
            //     //                           ),
            //     //                         ],
            //     //                       ),
            //     //                     ],
            //     //                   ),
            //     //                 ),
            //     //                 Positioned(
            //     //                   bottom: 5,
            //     //                   right: 5,
            //     //                   child: Container(
            //     //                     width: 15,
            //     //                     height: 15,
            //     //                     alignment: Alignment.center,
            //     //                     decoration: BoxDecoration(
            //     //                         shape: BoxShape.circle,
            //     //                         color: Colors.green,
            //     //                         border: Border.all(
            //     //                           color: Colors.black12,
            //     //                           width: 0.5,
            //     //                         )),
            //     //                   ),
            //     //                 )
            //     //               ],
            //     //             ),
            //     //             const SizedBox(
            //     //               width: 60,
            //     //               child: Text(
            //     //                 'GOAL Vietnam',
            //     //                 style: TextStyle(
            //     //                   color: Colors.black54,
            //     //                   fontSize: 12,
            //     //                 ),
            //     //                 maxLines: 2,
            //     //                 overflow: TextOverflow.ellipsis,
            //     //                 textAlign: TextAlign.center,
            //     //               ),
            //     //             ),
            //     //           ],
            //     //         ),
            //     //       ),
            //     //       const SizedBox(
            //     //         width: 10,
            //     //       ),
            //     //       SizedBox(
            //     //         width: 80,
            //     //         height: 120,
            //     //         child: Column(
            //     //           crossAxisAlignment: CrossAxisAlignment.start,
            //     //           children: [
            //     //             Stack(
            //     //               children: [
            //     //                 Container(
            //     //                   width: 80,
            //     //                   height: 70,
            //     //                   decoration: BoxDecoration(
            //     //                     borderRadius: BorderRadius.circular(10),
            //     //                     boxShadow: [
            //     //                       BoxShadow(
            //     //                         color: Colors.grey.withOpacity(0.3),
            //     //                         spreadRadius: 0,
            //     //                         blurRadius: 30,
            //     //                       ),
            //     //                     ],
            //     //                   ),
            //     //                   child: Column(
            //     //                     children: [
            //     //                       Row(
            //     //                         children: [
            //     //                           ClipRRect(
            //     //                             borderRadius:
            //     //                             BorderRadius.circular(100),
            //     //                             child: Image.asset(
            //     //                               'assets/images/user/minhhuong.jpg',
            //     //                               fit: BoxFit.cover,
            //     //                               width: 60,
            //     //                               height: 60,
            //     //                             ),
            //     //                           ),
            //     //                           const SizedBox(
            //     //                             width: 20,
            //     //                           ),
            //     //                         ],
            //     //                       ),
            //     //                     ],
            //     //                   ),
            //     //                 ),
            //     //                 Positioned(
            //     //                   bottom: 5,
            //     //                   right: 5,
            //     //                   child: Container(
            //     //                     width: 15,
            //     //                     height: 15,
            //     //                     alignment: Alignment.center,
            //     //                     decoration: BoxDecoration(
            //     //                         shape: BoxShape.circle,
            //     //                         color: Colors.green,
            //     //                         border: Border.all(
            //     //                           color: Colors.black12,
            //     //                           width: 0.5,
            //     //                         )),
            //     //                   ),
            //     //                 )
            //     //               ],
            //     //             ),
            //     //             const SizedBox(
            //     //               width: 60,
            //     //               child: Text(
            //     //                 'Minh Hương',
            //     //                 style: TextStyle(
            //     //                   color: Colors.black54,
            //     //                   fontSize: 12,
            //     //                 ),
            //     //                 maxLines: 2,
            //     //                 overflow: TextOverflow.ellipsis,
            //     //                 textAlign: TextAlign.center,
            //     //               ),
            //     //             ),
            //     //           ],
            //     //         ),
            //     //       ),
            //     //       const SizedBox(
            //     //         width: 10,
            //     //       ),
            //     //       SizedBox(
            //     //         width: 80,
            //     //         height: 120,
            //     //         child: Column(
            //     //           crossAxisAlignment: CrossAxisAlignment.start,
            //     //           children: [
            //     //             Stack(
            //     //               children: [
            //     //                 Container(
            //     //                   width: 80,
            //     //                   height: 70,
            //     //                   decoration: BoxDecoration(
            //     //                     borderRadius: BorderRadius.circular(10),
            //     //                     boxShadow: [
            //     //                       BoxShadow(
            //     //                         color: Colors.grey.withOpacity(0.3),
            //     //                         spreadRadius: 0,
            //     //                         blurRadius: 30,
            //     //                       ),
            //     //                     ],
            //     //                   ),
            //     //                   child: Column(
            //     //                     children: [
            //     //                       Row(
            //     //                         children: [
            //     //                           ClipRRect(
            //     //                             borderRadius:
            //     //                             BorderRadius.circular(100),
            //     //                             child: Image.asset(
            //     //                               'assets/images/menu/chat.png',
            //     //                               fit: BoxFit.cover,
            //     //                               width: 60,
            //     //                               height: 60,
            //     //                             ),
            //     //                           ),
            //     //                           const SizedBox(
            //     //                             width: 20,
            //     //                           ),
            //     //                         ],
            //     //                       ),
            //     //                     ],
            //     //                   ),
            //     //                 ),
            //     //                 Positioned(
            //     //                   bottom: 5,
            //     //                   right: 5,
            //     //                   child: Container(
            //     //                     width: 15,
            //     //                     height: 15,
            //     //                     alignment: Alignment.center,
            //     //                     decoration: BoxDecoration(
            //     //                         shape: BoxShape.circle,
            //     //                         color: Colors.green,
            //     //                         border: Border.all(
            //     //                           color: Colors.black12,
            //     //                           width: 0.5,
            //     //                         )),
            //     //                   ),
            //     //                 )
            //     //               ],
            //     //             ),
            //     //             const SizedBox(
            //     //               width: 60,
            //     //               child: Text(
            //     //                 'Typescript',
            //     //                 style: TextStyle(
            //     //                   color: Colors.black54,
            //     //                   fontSize: 12,
            //     //                 ),
            //     //                 maxLines: 2,
            //     //                 overflow: TextOverflow.ellipsis,
            //     //                 textAlign: TextAlign.center,
            //     //               ),
            //     //             ),
            //     //           ],
            //     //         ),
            //     //       ),
            //     //       const SizedBox(
            //     //         width: 10,
            //     //       ),
            //     //       SizedBox(
            //     //         width: 80,
            //     //         height: 120,
            //     //         child: Column(
            //     //           crossAxisAlignment: CrossAxisAlignment.start,
            //     //           children: [
            //     //             Stack(
            //     //               children: [
            //     //                 Container(
            //     //                   width: 80,
            //     //                   height: 70,
            //     //                   decoration: BoxDecoration(
            //     //                     borderRadius: BorderRadius.circular(10),
            //     //                     boxShadow: [
            //     //                       BoxShadow(
            //     //                         color: Colors.grey.withOpacity(0.3),
            //     //                         spreadRadius: 0,
            //     //                         blurRadius: 30,
            //     //                       ),
            //     //                     ],
            //     //                   ),
            //     //                   child: Column(
            //     //                     children: [
            //     //                       Row(
            //     //                         children: [
            //     //                           ClipRRect(
            //     //                             borderRadius:
            //     //                             BorderRadius.circular(100),
            //     //                             child: Image.asset(
            //     //                               'assets/images/user/baongan.jpg',
            //     //                               fit: BoxFit.cover,
            //     //                               width: 60,
            //     //                               height: 60,
            //     //                             ),
            //     //                           ),
            //     //                           const SizedBox(
            //     //                             width: 20,
            //     //                           ),
            //     //                         ],
            //     //                       ),
            //     //                     ],
            //     //                   ),
            //     //                 ),
            //     //                 Positioned(
            //     //                   bottom: 5,
            //     //                   right: 5,
            //     //                   child: Container(
            //     //                     width: 15,
            //     //                     height: 15,
            //     //                     alignment: Alignment.center,
            //     //                     decoration: BoxDecoration(
            //     //                         shape: BoxShape.circle,
            //     //                         color: Colors.green,
            //     //                         border: Border.all(
            //     //                           color: Colors.black12,
            //     //                           width: 0.5,
            //     //                         )),
            //     //                   ),
            //     //                 )
            //     //               ],
            //     //             ),
            //     //             const SizedBox(
            //     //               width: 60,
            //     //               child: Text(
            //     //                 'Bảo Ngân',
            //     //                 style: TextStyle(
            //     //                   color: Colors.black54,
            //     //                   fontSize: 12,
            //     //                 ),
            //     //                 maxLines: 2,
            //     //                 overflow: TextOverflow.ellipsis,
            //     //                 textAlign: TextAlign.center,
            //     //               ),
            //     //             ),
            //     //           ],
            //     //         ),
            //     //       ),
            //     //       const SizedBox(
            //     //         width: 10,
            //     //       ),
            //     //       SizedBox(
            //     //         width: 80,
            //     //         height: 120,
            //     //         child: Column(
            //     //           crossAxisAlignment: CrossAxisAlignment.start,
            //     //           children: [
            //     //             Stack(
            //     //               children: [
            //     //                 Container(
            //     //                   width: 80,
            //     //                   height: 70,
            //     //                   decoration: BoxDecoration(
            //     //                     borderRadius: BorderRadius.circular(10),
            //     //                     boxShadow: [
            //     //                       BoxShadow(
            //     //                         color: Colors.grey.withOpacity(0.3),
            //     //                         spreadRadius: 0,
            //     //                         blurRadius: 30,
            //     //                       ),
            //     //                     ],
            //     //                   ),
            //     //                   child: Column(
            //     //                     children: [
            //     //                       Row(
            //     //                         children: [
            //     //                           ClipRRect(
            //     //                             borderRadius:
            //     //                             BorderRadius.circular(100),
            //     //                             child: Image.asset(
            //     //                               'assets/images/user/halinh.jpg',
            //     //                               fit: BoxFit.cover,
            //     //                               width: 60,
            //     //                               height: 60,
            //     //                             ),
            //     //                           ),
            //     //                           const SizedBox(
            //     //                             width: 20,
            //     //                           ),
            //     //                         ],
            //     //                       ),
            //     //                     ],
            //     //                   ),
            //     //                 ),
            //     //                 Positioned(
            //     //                   bottom: 5,
            //     //                   right: 5,
            //     //                   child: Container(
            //     //                     width: 15,
            //     //                     height: 15,
            //     //                     alignment: Alignment.center,
            //     //                     decoration: BoxDecoration(
            //     //                         shape: BoxShape.circle,
            //     //                         color: Colors.green,
            //     //                         border: Border.all(
            //     //                           color: Colors.black12,
            //     //                           width: 0.5,
            //     //                         )),
            //     //                   ),
            //     //                 )
            //     //               ],
            //     //             ),
            //     //             const SizedBox(
            //     //               width: 60,
            //     //               child: Text(
            //     //                 'Hà Linhh',
            //     //                 style: TextStyle(
            //     //                   color: Colors.black54,
            //     //                   fontSize: 12,
            //     //                 ),
            //     //                 maxLines: 2,
            //     //                 overflow: TextOverflow.ellipsis,
            //     //                 textAlign: TextAlign.center,
            //     //               ),
            //     //             ),
            //     //           ],
            //     //         ),
            //     //       ),
            //     //       const SizedBox(
            //     //         width: 10,
            //     //       ),
            //     //       SizedBox(
            //     //         width: 80,
            //     //         height: 120,
            //     //         child: Column(
            //     //           crossAxisAlignment: CrossAxisAlignment.start,
            //     //           children: [
            //     //             Stack(
            //     //               children: [
            //     //                 Container(
            //     //                   width: 80,
            //     //                   height: 70,
            //     //                   decoration: BoxDecoration(
            //     //                     borderRadius: BorderRadius.circular(10),
            //     //                     boxShadow: [
            //     //                       BoxShadow(
            //     //                         color: Colors.grey.withOpacity(0.3),
            //     //                         spreadRadius: 0,
            //     //                         blurRadius: 30,
            //     //                       ),
            //     //                     ],
            //     //                   ),
            //     //                   child: Column(
            //     //                     children: [
            //     //                       Row(
            //     //                         children: [
            //     //                           ClipRRect(
            //     //                             borderRadius:
            //     //                             BorderRadius.circular(100),
            //     //                             child: Image.asset(
            //     //                               'assets/images/user/minhtuyen.jpg',
            //     //                               fit: BoxFit.cover,
            //     //                               width: 60,
            //     //                               height: 60,
            //     //                             ),
            //     //                           ),
            //     //                           const SizedBox(
            //     //                             width: 20,
            //     //                           ),
            //     //                         ],
            //     //                       ),
            //     //                     ],
            //     //                   ),
            //     //                 ),
            //     //                 Positioned(
            //     //                   bottom: 5,
            //     //                   right: 5,
            //     //                   child: Container(
            //     //                     width: 15,
            //     //                     height: 15,
            //     //                     alignment: Alignment.center,
            //     //                     decoration: BoxDecoration(
            //     //                         shape: BoxShape.circle,
            //     //                         color: Colors.white,
            //     //                         border: Border.all(
            //     //                           color: Colors.black12,
            //     //                           width: 0.5,
            //     //                         )),
            //     //
            //     //                   ),
            //     //                 )
            //     //               ],
            //     //             ),
            //     //             const SizedBox(
            //     //               width: 60,
            //     //               child: Text(
            //     //                 'Nguyễn Thị Minh Tuyền',
            //     //                 style: TextStyle(
            //     //                   color: Colors.black54,
            //     //                   fontSize: 12,
            //     //                 ),
            //     //                 maxLines: 2,
            //     //                 overflow: TextOverflow.ellipsis,
            //     //                 textAlign: TextAlign.center,
            //     //               ),
            //     //             ),
            //     //           ],
            //     //         ),
            //     //       ),
            //     //       const SizedBox(
            //     //         width: 10,
            //     //       ),
            //     //       SizedBox(
            //     //         width: 80,
            //     //         height: 120,
            //     //         child: Column(
            //     //           crossAxisAlignment: CrossAxisAlignment.start,
            //     //           children: [
            //     //             Stack(
            //     //               children: [
            //     //                 Container(
            //     //                   width: 80,
            //     //                   height: 70,
            //     //                   decoration: BoxDecoration(
            //     //                     borderRadius: BorderRadius.circular(10),
            //     //                     boxShadow: [
            //     //                       BoxShadow(
            //     //                         color: Colors.grey.withOpacity(0.3),
            //     //                         spreadRadius: 0,
            //     //                         blurRadius: 30,
            //     //                       ),
            //     //                     ],
            //     //                   ),
            //     //                   child: Column(
            //     //                     children: [
            //     //                       Row(
            //     //                         children: [
            //     //                           ClipRRect(
            //     //                             borderRadius:
            //     //                             BorderRadius.circular(10),
            //     //                             child: Image.asset(
            //     //                               'assets/images/user/daiphatthanh.jpg',
            //     //                               fit: BoxFit.cover,
            //     //                               width: 60,
            //     //                               height: 60,
            //     //                             ),
            //     //                           ),
            //     //                           const SizedBox(
            //     //                             width: 20,
            //     //                           ),
            //     //                         ],
            //     //                       ),
            //     //                     ],
            //     //                   ),
            //     //                 ),
            //     //                 Positioned(
            //     //                   bottom: 5,
            //     //                   right: 5,
            //     //                   child: Container(
            //     //                     width: 15,
            //     //                     height: 15,
            //     //                     alignment: Alignment.center,
            //     //                     decoration: BoxDecoration(
            //     //                         shape: BoxShape.circle,
            //     //                         border: Border.all(
            //     //                           color: Colors.black12,
            //     //                           width: 0.5,
            //     //                         )),
            //     //                   ),
            //     //                 )
            //     //               ],
            //     //             ),
            //     //             const SizedBox(
            //     //               width: 60,
            //     //               child: Text(
            //     //                 'Đài phát thanh',
            //     //                 style: TextStyle(
            //     //                   color: Colors.black54,
            //     //                   fontSize: 12,
            //     //                 ),
            //     //                 maxLines: 2,
            //     //                 overflow: TextOverflow.ellipsis,
            //     //                 textAlign: TextAlign.center,
            //     //               ),
            //     //             ),
            //     //           ],
            //     //         ),
            //     //       ),
            //     //     ],
            //     //   ),
            //     // ),
            //     // SizedBox(height: 10,),
            //     Expanded(
            //       child: SingleChildScrollView(
            //         child: ListView.builder(
            //           itemCount: chatUsers.length,
            //           shrinkWrap: true,
            //           padding: EdgeInsets.only(top: 16),
            //           physics: NeverScrollableScrollPhysics(),
            //           itemBuilder: (context, index){
            //             return GestureDetector(
            //               onTap: (){
            //
            //               },
            //               child: Container(
            //                 padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
            //                 child: Row(
            //                   children: <Widget>[
            //                     Expanded(
            //                       child: Row(
            //                         children: <Widget>[
            //                           CircleAvatar(
            //                             backgroundImage: AssetImage(chatUsers[index].image??""),
            //                             maxRadius: 30,
            //                           ),
            //                           SizedBox(width: 16,),
            //                           Expanded(
            //                             child: Container(
            //                               color: Colors.transparent,
            //                               child: Column(
            //                                 crossAxisAlignment: CrossAxisAlignment.start,
            //                                 children: <Widget>[
            //                                   Text(chatUsers[index].text??"", style: TextStyle(fontSize: 16),),
            //                                   SizedBox(height: 6,),
            //                                   Text(chatUsers[index].secondaryText??"",style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: FontWeight.normal),),
            //                                 ],
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                     Text(chatUsers[index].time??"",style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
            //                   ],
            //                 ),
            //               ),
            //             );
            //           },
            //         ),
            //       ),
            //     ),
            //   ],
            // );
          }
        ),
      ),
    );
  }
}
class ChatUsers {
  String? text;
  String? secondaryText;
  String? image;
  String? time;

  ChatUsers({this.text, this.secondaryText, this.image, this.time});

  ChatUsers.fromJson(Map<String, dynamic> json) {
    text = json['text']??"";
    secondaryText = json['secondaryText']??"";
    image = json['image']??"";
    time = json['time']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['secondaryText'] = this.secondaryText;
    data['image'] = this.image;
    data['time'] = this.time;
    return data;
  }
}