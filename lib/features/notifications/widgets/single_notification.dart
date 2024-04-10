import 'package:avrod/Widgets/image_widget.dart';
import 'package:avrod/cubits/getAllUsersDetails/getAllUsersdetails_cubit.dart';
import 'package:avrod/features/notifications/widgets/singlepostview_widget.dart';
import 'package:avrod/models/user_model.dart';
import 'package:avrod/services/firebase_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/getnotifymodel.dart';
import 'package:intl/intl.dart';

import '../../../models/post_model.dart';
import '../../personal-page/screens/personal_page_screen.dart';
class SingleNotification extends StatefulWidget {
  final GetNotificationModel notification;
  const SingleNotification({super.key, required this.notification});

  @override
  State<SingleNotification> createState() => _SingleNotificationState();
}

class _SingleNotificationState extends State<SingleNotification> {
  List<String> texts = [];
  @override
  void initState() {
    super.initState();
    String? hans = widget.notification.message?.split('_').first;
    String? hand = widget.notification.message?.split('_').last;
      texts.add(hans??'');
      texts.add(hand??'');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          if(widget.notification.notificationType==1){
            Navigator.pushNamed(
              context,
              PersonalPageScreen.routeName,
              arguments: widget.notification.senderId,
            );
          }else{
             Navigator.push(context, MaterialPageRoute(builder: (context)=>SinglePostViewWidget(postId: widget.notification.postId??'',)));
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color:
            // widget.notification.seen == true
            //     ?
            Colors.white.withOpacity(0.1)
                // : Colors.blue.withOpacity(0.1),
          ),
          child:BlocBuilder<GetAllUsersDetailsCubit, GetAllUsersDetailsState>(
               builder: (context, allUserState) {
                 if(allUserState is GetAllUsersDetailsLoaded) {
                   List<UserModel> allUsersList = allUserState.props.first as List<UserModel>;
                   UserModel senderUser= allUsersList.firstWhere((element) => element.userId==widget.notification.senderId);
                   return Padding(
                     padding: const EdgeInsets.only(
                       left: 10,
                       top: 10,
                       bottom: 10,
                       right: 0,
                     ),
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         SizedBox(
                           height: 60,
                           width: 60,
                           child: Stack(
                             children: [
                               DecoratedBox(
                                 decoration: BoxDecoration(
                                   border: Border.all(
                                     color: Colors.black12,
                                     width: 0.5,
                                   ),
                                   shape: BoxShape.circle,
                                 ),
                                 child: Container(
                                   height: 50 ,width: 50,
                                   clipBehavior: Clip.hardEdge ,
                                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
                                   child: ImageWidget(url: senderUser.userProfileImg),
                                 ),
                               ),
                               // Positioned(
                               //   right: 0,
                               //   bottom: 0,
                               //   child: Container(
                               //     padding: const EdgeInsets.all(0),
                               //     alignment: Alignment.center,
                               //     width: 30,
                               //     height: 30,
                               //     decoration: BoxDecoration(
                               //         shape: BoxShape.circle,
                               //         color:
                               //         // widget.notification.type == 'friend'
                               //         //     ?
                               //         Colors.blue,),
                               //             // : widget.notification.type == 'comment'
                               //             //     ? Colors.green[400]
                               //             //     : widget.notification.type == 'page'
                               //             //         ? Colors.orange
                               //             //         : widget.notification.type == 'group'
                               //             //             ? Colors.blue
                               //             //             : widget.notification.type ==
                               //             //                     'security'
                               //             //                 ? Colors.blue
                               //             //                 : widget.notification.type ==
                               //             //                         'date'
                               //             //                     ? Colors.purple
                               //             //                     : widget.notification
                               //             //                                 .type ==
                               //             //                             'badge'
                               //             //                         ? Colors
                               //             //                             .yellow.shade700
                               //             //                         : Colors.white),
                               //     child: (widget.notification.type == 'memory')
                               //         ? const Icon(
                               //             Icons.facebook,
                               //             color: Colors.blue,
                               //             size: 30,
                               //           )
                               //         : (widget.notification.type == 'friend')
                               //             ? const Icon(
                               //                 Icons.person_rounded,
                               //                 color: Colors.white,
                               //                 size: 22,
                               //               )
                               //             : (widget.notification.type == 'comment')
                               //                 ? const ImageIcon(
                               //                     AssetImage(
                               //                         'assets/images/white-cmt.png'),
                               //                     color: Colors.white,
                               //                     size: 16,
                               //                   )
                               //                 : (widget.notification.type == 'page')
                               //                     ? const CircleAvatar(
                               //                         backgroundImage: AssetImage(
                               //                             'assets/images/flag.png'))
                               //                     : (widget.notification.type ==
                               //                             'group')
                               //                         ? const Icon(
                               //                             Icons.groups_rounded,
                               //                             color: Colors.white,
                               //                             size: 24,
                               //                           )
                               //                         : (widget.notification.type ==
                               //                                 'security')
                               //                             ? const Icon(
                               //                                 Icons.security_rounded,
                               //                                 color: Colors.white,
                               //                                 size: 20,
                               //                               )
                               //                             : (widget.notification.type ==
                               //                                     'date')
                               //                                 ? const Icon(
                               //                                     Icons
                               //                                         .favorite_rounded,
                               //                                     color: Colors.white,
                               //                                     size: 20,
                               //                                   )
                               //                                 : (widget.notification
                               //                                             .type ==
                               //                                         'badge')
                               //                                     ? const ImageIcon(
                               //                                         AssetImage(
                               //                                           'assets/images/trophy.png',
                               //                                         ),
                               //                                         size: 18,
                               //                                         color:
                               //                                             Colors.white,
                               //                                       )
                               //                                     : (widget.notification
                               //                                                 .type ==
                               //                                             'like')
                               //                                         ? Image.asset(
                               //                                             'assets/images/reactions/like.png')
                               //                                         : (widget.notification
                               //                                                     .type ==
                               //                                                 'love')
                               //                                             ? Image.asset(
                               //                                                 'assets/images/reactions/love.png')
                               //                                             : (widget.notification
                               //                                                         .type ==
                               //                                                     'haha')
                               //                                                 ? Image.asset(
                               //                                                     'assets/images/reactions/haha.png')
                               //                                                 : (widget.notification.type ==
                               //                                                         'wow')
                               //                                                     ? Image.asset(
                               //                                                         'assets/images/reactions/wow.png')
                               //                                                     : (widget.notification.type == 'lovelove')
                               //                                                         ? Image.asset('assets/images/reactions/care.png')
                               //                                                         : (widget.notification.type == 'sad')
                               //                                                             ? Image.asset('assets/images/reactions/sad.png')
                               //                                                             : (widget.notification.type == 'angry')
                               //                                                                 ? Image.asset('assets/images/reactions/angry.png')
                               //                                                                 : const Icon(
                               //                                                                     Icons.facebook,
                               //                                                                     color: Colors.blue,
                               //                                                                     size: 30,
                               //                                                                   ),
                               //   ),
                               // )
                             ],
                           ),
                         ),
                         Expanded(
                           child: Container(
                             padding: const EdgeInsets.only(left: 10,right: 18),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 RichText(
                                   overflow: TextOverflow.ellipsis,
                                   maxLines: 3,
                                   text: TextSpan(
                                     // Note: Styles for TextSpans must be explicitly defined.
                                     // Child text spans will inherit styles from parent
                                       style: const TextStyle(
                                           color: Colors.black,
                                           fontSize: 16,
                                           height: 1.4),
                                       children:[
                                         TextSpan(
                                           text:  widget.notification.message?.split('_').first,
                                           style: TextStyle(
                                             fontWeight: FontWeight.bold,
                                           ),
                                         ), TextSpan(
                                           text:  widget.notification.message?.split('_').last,
                                           style: TextStyle(
                                             fontWeight: FontWeight.normal,
                                           ),
                                         ),
                                       ]),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.only(top: 5),
                                   child: Text(
                                     "${DateFormat('d MMMM hh:mm').format(widget.notification.createdAt?.toDate()??DateTime.now())}",
                                     style: const TextStyle(
                                       color: Colors.black54,
                                       fontSize: 14,
                                     ),
                                   ),
                                 ),
                                 // if (widget.notification.notificationType == 1)
                                 //   Row(
                                 //     children: [
                                 //       Expanded(
                                 //         child: ElevatedButton(
                                 //           onPressed: () {
                                 //             UserManagement.acceptFriendRequest(receiverUserId:widget.notification.senderId ??'' );
                                 //           },
                                 //           style: ElevatedButton.styleFrom(
                                 //             shadowColor: Colors.transparent,
                                 //             backgroundColor: Colors.blue[700],
                                 //             shape: RoundedRectangleBorder(
                                 //               borderRadius: BorderRadius.circular(8),
                                 //             ),
                                 //           ),
                                 //           child: const Text(
                                 //             'Confirm',
                                 //             style: TextStyle(
                                 //               color: Colors.white,
                                 //               fontWeight: FontWeight.w500,
                                 //               fontSize: 15,
                                 //             ),
                                 //           ),
                                 //         ),
                                 //       ),
                                 //       const SizedBox(
                                 //         width: 10,
                                 //       ),
                                 //       Expanded(
                                 //         child: ElevatedButton(
                                 //           onPressed: () {
                                 //             UserManagement.withdrawFriendRequest(receiverUserId:widget.notification.userId ??'' );
                                 //           },
                                 //           style: ElevatedButton.styleFrom(
                                 //             shadowColor: Colors.transparent,
                                 //             backgroundColor: Colors.grey[300],
                                 //             shape: RoundedRectangleBorder(
                                 //               borderRadius: BorderRadius.circular(8),
                                 //             ),
                                 //           ),
                                 //           child: const Text(
                                 //             'Delete',
                                 //             style: TextStyle(
                                 //               color: Colors.black,
                                 //               fontWeight: FontWeight.w500,
                                 //               fontSize: 15,
                                 //             ),
                                 //           ),
                                 //         ),
                                 //       ),
                                 //     ],
                                 //   )
                               ],
                             ),
                           ),
                         ),
                         const SizedBox(height: 20,)
                         // SizedBox(
                         //   width: 30,
                         //   height: 30,
                         //   child: IconButton(
                         //     padding: const EdgeInsets.all(5),
                         //     splashRadius: 20,
                         //     onPressed: () {},
                         //     icon: const Icon(
                         //       Icons.more_horiz_rounded,
                         //       size: 20,
                         //     ),
                         //   ),
                         // )
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
      ),
    );
  }
}
