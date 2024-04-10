import 'dart:math';

import 'package:avrod/Widgets/text_widget.dart';
import 'package:avrod/cubits/getUserData/user_cubit.dart';
import 'package:avrod/features/personal-page/screens/personal_page_screen.dart';
import 'package:avrod/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/user.dart';

class FriendsSearchScreen extends StatefulWidget {
  static const String routeName = '/friends-search-screen';
  const FriendsSearchScreen({super.key,required this.userId});
  final String userId;

  @override
  State<FriendsSearchScreen> createState() => _FriendsSearchScreenState();
}

class _FriendsSearchScreenState extends State<FriendsSearchScreen> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          splashRadius: 20,
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 25,
          ),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Friends',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
            // IconButton(
            //   onPressed: () {},
            //   splashRadius: 20,
            //   icon: const Icon(
            //     Icons.search_rounded,
            //     color: Colors.black,
            //     size: 30,
            //   ),
            // )
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(widget.userId).snapshots(),
           builder: (context, snap) {

             if(snap.hasData){

               UserModel? useru=UserModel.fromJson(snap.data?.data() ??{});

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                         Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            top: 15,
                            bottom: 15,
                          ),
                          child: Text_Widget(
                            '${useru.friends?.length.toString() ?? '0'} Friends',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,

                          ),

                        ),
                        for (int i = 0; i < (useru.friends?.length ??0); i++)
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
                                             imageUrl: data['photo']??'',
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
                                                   data['name'],
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
    );
  }
}
