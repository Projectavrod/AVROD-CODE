import 'package:avrod/features/notifications/widgets/single_notification.dart';
import 'package:avrod/models/noti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/getnotification_cubit/getnotification_cubit.dart';
import '../../../models/getnotifymodel.dart';

class NotificationsScreen extends StatefulWidget {
  static double offset = 0;
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {


  ScrollController scrollController =
      ScrollController(initialScrollOffset: NotificationsScreen.offset);
  ScrollController headerScrollController = ScrollController();

  @override
  void initState() {
    context.read<GetnotificationCubit>().GetNotification();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    headerScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      headerScrollController.jumpTo(headerScrollController.offset +
          scrollController.offset -
          NotificationsScreen.offset);
      NotificationsScreen.offset = scrollController.offset;
    });
    return  Scaffold(
      // body:
      body: BlocBuilder<GetnotificationCubit, GetnotificationState>(
  builder: (context, notifyState) {

    if(notifyState is GetnotificationLoaded){
      List<GetNotificationModel> notifygetList=notifyState.props.first as List<GetNotificationModel>;
      
      List<GetNotificationModel> notifyList=notifygetList.where((element) => element.userId==FirebaseAuth.instance.currentUser?.uid).toList();

      return NestedScrollView(
        controller: headerScrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            toolbarHeight: 50,
            titleSpacing: 0,
            pinned: true,
            floating: true,
            primary: false,
            centerTitle: true,
            automaticallyImplyLeading: false,
            snap: true,
            forceElevated: innerBoxIsScrolled,
            bottom: const PreferredSize(
                preferredSize: Size.fromHeight(0), child: SizedBox()),
            title: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                        splashRadius: 20,
                        onPressed: () {},
                        icon: Icon(Icons.notifications_none_outlined)
                      ),
                      const Text(
                        'Notification',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //   alignment: Alignment.center,
                  //   width: 35,
                  //   height: 35,
                  //   padding: const EdgeInsets.all(0),
                  //   margin: const EdgeInsets.symmetric(horizontal: 5),
                  //   decoration: const BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: Colors.black12,
                  //   ),
                  //   child: IconButton(
                  //     splashRadius: 18,
                  //     padding: const EdgeInsets.all(0),
                  //     onPressed: () {},
                  //     icon: const Icon(
                  //       Icons.search,
                  //       color: Colors.black,
                  //       size: 24,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          )
        ],
        body: (notifyList.isEmpty)?Center(child: Text("No Notifications Yet"),):
        SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: notifyList
                .map((e) => SingleNotification(notification: e))
                .toList(),
          ),
        ),
      );
    }else if (notifyState is GetnotificationLoading){
      return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(color: Colors.orange,strokeWidth: 1.5,),
            ),
            const SizedBox(height: 18,),
            const Text("Loading Notifications...")
          ],
        ),
      );
    }else{
      return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(color: Colors.orange,strokeWidth: 1.5,),
            ),
            const SizedBox(height: 18,),
            const Text("Loading Notifications...")
          ],
        ),
      );
    }

  },
),
    );
  }
}
