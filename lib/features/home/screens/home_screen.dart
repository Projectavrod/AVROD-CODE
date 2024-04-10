import 'package:avrod/constants/global_variables.dart';
import 'package:avrod/cubits/getUserData/user_cubit.dart';
import 'package:avrod/features/friends/screens/friends_screen.dart';
import 'package:avrod/features/home/widgets/home_app_bar.dart';
import 'package:avrod/features/menu/screens/menu_screen.dart';
import 'package:avrod/features/news-feed/screen/news_feed_screen.dart';
import 'package:avrod/features/notifications/screens/notifications_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/getAllUsersDetails/getAllUsersdetails_cubit.dart';
import '../../../cubits/getallpost_cubit/getallpost_cubit.dart';
import '../../../cubits/getnotification_cubit/getnotification_cubit.dart';
import '../../chats/chat_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  double toolBarHeight = 60;
  ScrollController scrollController = ScrollController();
  late final list = <Widget>[
    NewsFeedScreen(parentScrollController: scrollController),
     ChatScreen(),
    const FriendsScreen(),

    const NotificationsScreen(
      key: Key('notifications-screen'),
    ),
    const MenuScreen()
  ];
  @override
  void initState(){
  String? uId=FirebaseAuth.instance.currentUser?.uid;
    super.initState();
    context.read<UserCubit>().getUserData(userId: uId??'');
    context.read<GetallpostCubit>().getOverAllPost();
    context.read<GetAllUsersDetailsCubit>().getAllUsersDetails();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
 providers: [
   BlocProvider(create: (context)=>GetnotificationCubit()..GetNotification()),

 ],
  child: SafeArea(
      child: Scaffold(
        body: NestedScrollView(
            controller: scrollController,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  toolbarHeight: toolBarHeight,
                  titleSpacing: 0,
                  title: AnimatedContainer(
                    onEnd: () {
                      setState(() {
                        if (index > 0) {
                          toolBarHeight = 0;
                        }
                      });
                    },
                    curve: Curves.linearToEaseOut,
                    height: (index > 0) ? 0 : 60,
                    duration: Duration(milliseconds: index == 0 ? 500 : 300),
                    child: const HomeAppBar(),
                  ),
                  floating: true,
                  snap: index == 0,
                  pinned: true,
                ),
              ];
            },
            body: list[index]),

        bottomNavigationBar: Container(
          color: Colors.blue.shade50,
          height: 55,
          child: PreferredSize(
            preferredSize: const Size.fromHeight(46),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              index = 0;
                              toolBarHeight = 60;
                              scrollController.jumpTo(
                                0,
                              );
                            });
                          },
                          child: bottomNavWidget(currIndex: 0,icon:Icons.home_outlined ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              index = 1;
                              scrollController.jumpTo(0);
                            });
                          },
                          child:bottomNavWidget(currIndex: 1,icon:Icons.chat_outlined ),
                        ),
                      ),

                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              index = 2;
                              scrollController.jumpTo(0);
                            });
                          },
                          child: bottomNavWidget(currIndex: 2,icon:CupertinoIcons.person_2 ),
                        ),
                      ),

                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              index = 3;
                              scrollController.jumpTo(0);
                            });
                          },
                          child: bottomNavWidget(currIndex: 3,icon:Icons.notifications_none_outlined ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              index = 4;
                              scrollController.jumpTo(0);
                            });
                          },
                          child: bottomNavWidget(currIndex: 4,icon:Icons.menu ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.black12,
                  height: 0,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
);
  }

  Widget bottomNavWidget({required IconData icon,required int currIndex}){
    return Container(
      height: 50,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 30,
            color:index != currIndex ? Colors.black87 : GlobalVariables.secondaryColor,
          ),
          if (index == currIndex)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: MediaQuery.of(context)
                  .size
                  .width /
                  6 -
                  10,
              height: 3,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(100),
                color: Colors.blue,
              ),
            ),
        ],
      ),
    );
  }

}
