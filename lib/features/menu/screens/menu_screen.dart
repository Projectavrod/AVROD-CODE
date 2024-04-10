import 'package:avrod/Widgets/image_widget.dart';
import 'package:avrod/cubits/getUserData/user_cubit.dart';
import 'package:avrod/features/friends/screens/friends_screen.dart';
import 'package:avrod/features/menu/screens/privacy_policy.dart';
import 'package:avrod/features/menu/widgets/menu_choice.dart';
import 'package:avrod/features/menu/widgets/shortcut.dart';
import 'package:avrod/models/user.dart';
import 'package:avrod/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Screens/Auth_Screens/reset_password.dart';
import '../../personal-page/screens/personal_page_screen.dart';
import 'contact_us.dart';

class MenuScreen extends StatefulWidget {
  static double offset = 0;
  static bool viewMoreShortcuts = false;
  static bool viewMoreHelps = true;
  static bool viewMoreSettings = true;
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  ScrollController scrollController =
      ScrollController(initialScrollOffset: MenuScreen.offset);
  ScrollController headerScrollController = ScrollController();

  @override
  void initState() {
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
          MenuScreen.offset);
      MenuScreen.offset = scrollController.offset;
    });
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: NestedScrollView(
        controller: headerScrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 60,
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
                      // IconButton(
                      //   splashRadius: 20,
                      //   onPressed: () {},
                      //   icon: const ImageIcon(
                      //     AssetImage('assets/images/menu.png'),
                      //     color: Colors.black,
                      //     size: 50,
                      //   ),
                      // ),
                      const SizedBox(width: 18,),
                      const Text(
                        'Menu',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Container(
                  //       alignment: Alignment.center,
                  //       width: 35,
                  //       height: 35,
                  //       padding: const EdgeInsets.all(0),
                  //       margin: const EdgeInsets.symmetric(horizontal: 5),
                  //       decoration: const BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         color: Colors.black12,
                  //       ),
                  //       child: IconButton(
                  //         splashRadius: 18,
                  //         padding: const EdgeInsets.all(0),
                  //         onPressed: () {},
                  //         icon: const Icon(
                  //           Icons.settings_rounded,
                  //           color: Colors.black,
                  //           size: 24,
                  //         ),
                  //       ),
                  //     ),
                  //     Container(
                  //       alignment: Alignment.center,
                  //       width: 35,
                  //       height: 35,
                  //       padding: const EdgeInsets.all(0),
                  //       margin: const EdgeInsets.symmetric(horizontal: 5),
                  //       decoration: const BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         color: Colors.black12,
                  //       ),
                  //       child: IconButton(
                  //         splashRadius: 18,
                  //         padding: const EdgeInsets.all(0),
                  //         onPressed: () {},
                  //         icon: const Icon(
                  //           Icons.search,
                  //           color: Colors.black,
                  //           size: 24,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          )
        ],
        body: BlocBuilder<UserCubit, UserState>(
  builder: (context, profileState) {
    if(profileState is UserSuccess) {
      UserModel user= profileState.props.first as UserModel;
      return SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 8,),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    PersonalPageScreen.routeName,
                    arguments: FirebaseAuth.instance.currentUser!.uid,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black12,
                                width: 1,
                              ),
                            ),
                            child:  Container(
                              height: 40,width: 40,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
                              child: ImageWidget(url: user.userProfileImg),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  FirebaseAuth.instance.currentUser?.displayName ??'',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                 Text(
                                  FirebaseAuth.instance.currentUser?.email ??'',
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.black12,
                indent: 10,
                endIndent: 10,
                height: 0,
              ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 5),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Expanded(
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Container(
              //               width: double.infinity,
              //               margin: const EdgeInsets.all(5),
              //               decoration: BoxDecoration(
              //                   color: Colors.white,
              //                   shape: BoxShape.rectangle,
              //                   border: Border.all(
              //                     color: Colors.black12,
              //                     width: 0.5,
              //                   ),
              //                   borderRadius: BorderRadius.circular(10),
              //                   boxShadow: [
              //                     BoxShadow(
              //                       color: Colors.black.withOpacity(0.2),
              //                       blurRadius: 20,
              //                       offset: const Offset(0, 0),
              //                       spreadRadius: 0,
              //                     ),
              //                   ]),
              //               child: Material(
              //                 color: Colors.transparent,
              //                 child: InkWell(
              //                   borderRadius: BorderRadius.circular(10),
              //                   onTap: () {
              //                     Navigator.pushNamed(
              //                         context, MemoryScreen.routeName);
              //                   },
              //                   child: const Padding(
              //                     padding: EdgeInsets.all(10),
              //                     child: Shortcut(
              //                         img: 'assets/images/menu/memory.png',
              //                         title: 'Kỷ niệm'),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             Container(
              //               width: double.infinity,
              //               margin: const EdgeInsets.all(5),
              //               decoration: BoxDecoration(
              //                   color: Colors.white,
              //                   shape: BoxShape.rectangle,
              //                   border: Border.all(
              //                     color: Colors.black12,
              //                     width: 0.5,
              //                   ),
              //                   borderRadius: BorderRadius.circular(10),
              //                   boxShadow: [
              //                     BoxShadow(
              //                       color: Colors.black.withOpacity(0.2),
              //                       blurRadius: 20,
              //                       offset: const Offset(0, 0),
              //                       spreadRadius: 0,
              //                     ),
              //                   ]),
              //               child: Material(
              //                 color: Colors.transparent,
              //                 child: InkWell(
              //                   borderRadius: BorderRadius.circular(10),
              //                   onTap: () {
              //                     Navigator.pushNamed(
              //                         context, FriendsScreen.routeName);
              //                   },
              //                   child: const Padding(
              //                     padding: EdgeInsets.all(10),
              //                     child: Shortcut(
              //                         img: 'assets/images/menu/friends.png',
              //                         title: 'Bạn bè'),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             Container(
              //               width: double.infinity,
              //               margin: const EdgeInsets.all(5),
              //               padding: const EdgeInsets.all(10),
              //               decoration: BoxDecoration(
              //                   color: Colors.white,
              //                   shape: BoxShape.rectangle,
              //                   border: Border.all(
              //                     color: Colors.black12,
              //                     width: 0.5,
              //                   ),
              //                   borderRadius: BorderRadius.circular(10),
              //                   boxShadow: [
              //                     BoxShadow(
              //                       color: Colors.black.withOpacity(0.2),
              //                       blurRadius: 20,
              //                       offset: const Offset(0, 0),
              //                       spreadRadius: 0,
              //                     ),
              //                   ]),
              //               child: const Shortcut(
              //                   img: 'assets/images/menu/video.png',
              //                   title: 'Video'),
              //             ),
              //             Container(
              //               width: double.infinity,
              //               margin: const EdgeInsets.all(5),
              //               padding: const EdgeInsets.all(10),
              //               decoration: BoxDecoration(
              //                   color: Colors.white,
              //                   shape: BoxShape.rectangle,
              //                   border: Border.all(
              //                     color: Colors.black12,
              //                     width: 0.5,
              //                   ),
              //                   borderRadius: BorderRadius.circular(10),
              //                   boxShadow: [
              //                     BoxShadow(
              //                       color: Colors.black.withOpacity(0.2),
              //                       blurRadius: 20,
              //                       offset: const Offset(0, 0),
              //                       spreadRadius: 0,
              //                     ),
              //                   ]),
              //               child: const Shortcut(
              //                   img: 'assets/images/menu/feed.png',
              //                   title: 'Bảng feed'),
              //             ),
              //             if (MenuScreen.viewMoreShortcuts)
              //               for (int i = 0; i < shortcuts.length; i += 2)
              //                 shortcuts[i],
              //           ],
              //         ),
              //       ),
              //       Expanded(
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Container(
              //               width: double.infinity,
              //               margin: const EdgeInsets.all(5),
              //               padding: const EdgeInsets.all(10),
              //               decoration: BoxDecoration(
              //                 color: Colors.white,
              //                 shape: BoxShape.rectangle,
              //                 border: Border.all(
              //                   color: Colors.black12,
              //                   width: 0.5,
              //                 ),
              //                 borderRadius: BorderRadius.circular(10),
              //                 boxShadow: [
              //                   BoxShadow(
              //                     color: Colors.black.withOpacity(0.2),
              //                     blurRadius: 20,
              //                     offset: const Offset(0, 0),
              //                     spreadRadius: 0,
              //                   ),
              //                 ],
              //               ),
              //               child: const Shortcut(
              //                   img: 'assets/images/menu/saved.png',
              //                   title: 'Đã lưu'),
              //             ),
              //             Container(
              //               width: double.infinity,
              //               margin: const EdgeInsets.all(5),
              //               padding: const EdgeInsets.all(10),
              //               decoration: BoxDecoration(
              //                 color: Colors.white,
              //                 shape: BoxShape.rectangle,
              //                 border: Border.all(
              //                   color: Colors.black12,
              //                   width: 0.5,
              //                 ),
              //                 borderRadius: BorderRadius.circular(10),
              //                 boxShadow: [
              //                   BoxShadow(
              //                     color: Colors.black.withOpacity(0.2),
              //                     blurRadius: 20,
              //                     offset: const Offset(0, 0),
              //                     spreadRadius: 0,
              //                   ),
              //                 ],
              //               ),
              //               child: const Shortcut(
              //                   img: 'assets/images/menu/dating.png',
              //                   title: 'Hẹn hò'),
              //             ),
              //             Container(
              //               width: double.infinity,
              //               margin: const EdgeInsets.all(5),
              //               padding: const EdgeInsets.all(10),
              //               decoration: BoxDecoration(
              //                 color: Colors.white,
              //                 shape: BoxShape.rectangle,
              //                 border: Border.all(
              //                   color: Colors.black12,
              //                   width: 0.5,
              //                 ),
              //                 borderRadius: BorderRadius.circular(10),
              //                 boxShadow: [
              //                   BoxShadow(
              //                     color: Colors.black.withOpacity(0.2),
              //                     blurRadius: 20,
              //                     offset: const Offset(0, 0),
              //                     spreadRadius: 0,
              //                   ),
              //                 ],
              //               ),
              //               child: const Shortcut(
              //                   img: 'assets/images/menu/market.png',
              //                   title: 'Marketplace'),
              //             ),
              //             Container(
              //               width: double.infinity,
              //               margin: const EdgeInsets.all(5),
              //               padding: const EdgeInsets.all(10),
              //               decoration: BoxDecoration(
              //                 color: Colors.white,
              //                 shape: BoxShape.rectangle,
              //                 border: Border.all(
              //                   color: Colors.black12,
              //                   width: 0.5,
              //                 ),
              //                 borderRadius: BorderRadius.circular(10),
              //                 boxShadow: [
              //                   BoxShadow(
              //                     color: Colors.black.withOpacity(0.2),
              //                     blurRadius: 20,
              //                     offset: const Offset(0, 0),
              //                     spreadRadius: 0,
              //                   ),
              //                 ],
              //               ),
              //               child: const Shortcut(
              //                   img: 'assets/images/menu/event.png',
              //                   title: 'Sự kiện'),
              //             ),
              //             if (MenuScreen.viewMoreShortcuts)
              //               for (int i = 1; i < shortcuts.length; i += 2)
              //                 shortcuts[i],
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 10,
              //     vertical: 10,
              //   ),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: ElevatedButton(
              //           style: ElevatedButton.styleFrom(
              //             backgroundColor: Colors.grey[300],
              //             shadowColor: Colors.transparent,
              //             side: const BorderSide(
              //               color: Colors.black12,
              //               width: 0.5,
              //             ),
              //           ),
              //           onPressed: () {
              //             setState(() {
              //               MenuScreen.viewMoreShortcuts =
              //                   !MenuScreen.viewMoreShortcuts;
              //             });
              //           },
              //           child: Text(
              //             MenuScreen.viewMoreShortcuts ? 'Ẩn bớt' : 'Xem thêm',
              //             style: const TextStyle(
              //               color: Colors.black,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const Divider(
              //   height: 0,
              //   color: Colors.black12,
              // ),


              InkWell(
                onTap: () {
                  setState(() {
                    MenuScreen.viewMoreHelps = !MenuScreen.viewMoreHelps;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/menu/help.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Help and Support',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Icon(
                          MenuScreen.viewMoreHelps
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 30,
                          color: Colors.grey),
                    ],
                  ),
                ),
              ),
              if (MenuScreen.viewMoreHelps)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      InkWell(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsScreen(),));

                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.black12,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 0),
                                  spreadRadius: 0,
                                ),
                              ]),
                          child: const MenuChoice(
                              img: 'assets/images/menu/center.png',
                              title: 'Help Center'),
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyScreen(),));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.black12,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 0),
                                  spreadRadius: 0,
                                ),
                              ]),
                          child: const MenuChoice(
                              img: 'assets/images/menu/policy.png',
                              title: 'Terms and Policy'),
                        ),
                      ),
                    ],
                  ),
                ),
              const Divider(
                height: 0,
                color: Colors.black12,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    MenuScreen.viewMoreSettings = !MenuScreen.viewMoreSettings;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/menu/settings.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Settings',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Icon(
                          MenuScreen.viewMoreSettings
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 30,
                          color: Colors.grey),
                    ],
                  ),
                ),
              ),
              if (MenuScreen.viewMoreSettings)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.black12,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 0),
                                spreadRadius: 0,
                              ),
                            ]),
                        child: const MenuChoice(
                            img: 'assets/images/menu/settings2.png',
                            title: 'Account Settings'),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.black12,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 0),
                                spreadRadius: 0,
                              ),
                            ]),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordScreen(),));
                          },
                          child: const MenuChoice(
                              img: 'assets/images/menu/settings.png',
                              title: 'Reset Password'),
                        ),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          shadowColor: Colors.transparent,
                          side: const BorderSide(
                            color: Colors.black12,
                            width: 0.5,
                          ),
                        ),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        child: const Text(
                          'Log Out',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
    }else{
      return Container();
    }
  },
),
      ),
    );
  }
}
