import 'package:avrod/Widgets/image_widget.dart';
import 'package:avrod/cubits/getUserData/user_cubit.dart';
import 'package:avrod/features/news-feed/widgets/post_card.dart';
import 'package:avrod/features/personal-page/screens/personal_page_screen.dart';
import 'package:avrod/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../Screens/post_page/postmian.dart';
import '../../../models/post_model.dart';
import '../../../services/firebase_post.dart';
import '../../notifications/widgets/prevideoplayer_widget.dart';

class NewsFeedScreen extends StatefulWidget {
  static double offset = 0;
  final ScrollController parentScrollController;
  const NewsFeedScreen({super.key, required this.parentScrollController});

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  Color colorNewPost = Colors.transparent;
  final TextEditingController searchController =TextEditingController();

  ScrollController scrollController =
      ScrollController(initialScrollOffset: NewsFeedScreen.offset);

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUserData(userId: FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    scrollController.addListener(() {
      if (widget.parentScrollController.hasClients) {
        widget.parentScrollController.jumpTo(
            widget.parentScrollController.offset +
                scrollController.offset -
                NewsFeedScreen.offset);
        NewsFeedScreen.offset = scrollController.offset;
      }
    });
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(
                      context,
                      PersonalPageScreen.routeName,
                      arguments:FirebaseAuth.instance.currentUser?.uid ??'',
                    );
                  },
                  child: Padding(
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
                ),

                Expanded(
                  child: Container(
                    height: 40,
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyMedium?.apply(color: Colors.black),
                      showCursor: true,
                      cursorColor: Colors.blue,
                      // cursorHeight: 30,
                      cursorWidth: 2,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (val){
                        // context.read<SearchCubit>().searchUser(searchController.text);
                      },
                      controller: searchController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 4,left: 14),
                        hintText: "What's on Your Mind ?",

                        // Add a clear button to the search bar
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send,color: Colors.grey,size: 18,),
                          onPressed: ()async{
                            if(searchController.text.isNotEmpty) {
                              if (await PostManagement.postAPost(
                                  mediaUrl: '',
                                  mediaType: 0,
                                  text: searchController.text
                              )) {
                                searchController.clear();
                              }
                            }else{
                              // Fluttertoast.showToast(msg: '');
                            }

                            // context.read<SearchCubit>().searchUser('');
                          },
                        ),
                        // Add a search icon or button to the search bar
                        // prefixIcon: const Icon(Icons.search,color: Colors.black,),

                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const PostMainPage()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 6),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(2),
                    color: Colors.blue.shade100),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4,bottom: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.image,
                            color: Colors.blue.shade600,
                            size: 20,
                          ),
                          const SizedBox(width: 4,),
                          Text("Post",style: Theme.of(context).textTheme.bodyMedium?.apply(fontWeightDelta: 1,color: Colors.black),)
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 5,
            color: Colors.black26,
          ),
          const SizedBox(
            height: 10,
          ),

          const SizedBox(
            height: 10,
          ),


          BlocBuilder<UserCubit, UserState>(
            builder: (context, profileState) {
              if(profileState is UserSuccess) {
                UserModel user= profileState.props.first as UserModel;
                List<String>? frs=[];
                frs.clear();
                frs.add(user.userId!);
                frs=user.friends;

                return StreamBuilder(
                  stream:  FirebaseFirestore.instance.collection('posts')
                      .where("userId",whereIn: frs )
                      .orderBy('createdAt',descending: true)
                      .snapshots(),
                  builder: (context, snap) {
                    if(snap.hasData){

                      List<PostModel> posts =[];
                      snap.data?.docs.forEach((element) {
                        var post = PostModel.fromJson(element.data());
                        posts.add(post);
                      });
                      return (frs==null)?Center(child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30,),
                          Icon(Icons.my_library_books_rounded,size: 44,color: Colors.grey.shade500,),
                          SizedBox(height: 14,),
                          Text("No Post Available Yet",style: Theme.of(context).textTheme.labelLarge?.apply(fontSizeDelta: 2,color: Colors.black),),
                          SizedBox(height: 6,),
                          Text("Search and Find Your Friends",style: Theme.of(context).textTheme.labelLarge?.apply(fontSizeDelta: 2,color: Colors.black),),
                        ],
                      ),): posts.isEmpty? Center(child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30,),
                          Icon(Icons.my_library_books_rounded,size: 44,color: Colors.grey.shade500,),
                          SizedBox(height: 14,),
                          Text("No Post Available Yet",style: Theme.of(context).textTheme.labelLarge?.apply(fontSizeDelta: 2,color: Colors.black),),
                          SizedBox(height: 6,),
                          Text("Search and Find Your Friends",style: Theme.of(context).textTheme.labelLarge?.apply(fontSizeDelta: 2,color: Colors.black),),
                        ],
                      ),):
                        Column(
                        children:
                        posts
                            .map((e) => Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            PostCard(post: e),
                            Container(
                              width: double.infinity,
                              height: 5,
                              color: Colors.black26,
                            ),
                          ],
                        ))
                            .toList(),
                      );

                    }else if(snap.connectionState == ConnectionState.waiting){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }else {
                      return Container();
                    }
                  },
                );
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),

        ],
      ),
    );
  }
}
