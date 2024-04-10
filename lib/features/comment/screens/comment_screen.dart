import 'package:avrod/cubits/getUserData/user_cubit.dart';
import 'package:avrod/models/post.dart';
import 'package:avrod/features/comment/widgets/single_comment.dart';
import 'package:avrod/models/comment.dart';
import 'package:avrod/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:avrod/models/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../cubits/getAllUsersDetails/getAllUsersdetails_cubit.dart';
import '../../../models/post_model.dart';
import '../../../models/user_model.dart';
import '../../../services/firebase_post.dart';

class CommentScreen extends StatefulWidget {
  static const String routeName = '/comment-screen';
  final PostModel post;
  const CommentScreen({super.key, required this.post});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

enum SortingOption { fit, newest, all }

class _CommentScreenState extends State<CommentScreen> {
  List<String> icons = [];
  String reactions = '0';
  bool isInWidgetTree = true;
  String userId=FirebaseAuth.instance.currentUser?.uid??'';
  SortingOption _sortingOption = SortingOption.fit;


  final TextEditingController searchController =TextEditingController();
  @override
  void initState() {



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child:BlocBuilder<GetAllUsersDetailsCubit, GetAllUsersDetailsState>(
        builder: (context, allUserState) {
        if(allUserState is GetAllUsersDetailsLoaded) {
        List<UserModel> allUsersList = allUserState.props.first as List<UserModel>;

        return StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').doc(widget.post.postId).collection('command').doc('allCommands').snapshots(),
          builder: (context, snap) {
      if (snap.hasData) {
        List cmdListss = snap.data?.data()?['commands']??[];
        List<Commands> cmdList =[];
        cmdListss.forEach((element) {
        Commands nn=Commands.fromJson(element);
        cmdList.add(nn);
        });
        List<Comment> comments =[];
        cmdList.forEach((element) {
          UserModel postedUser = allUsersList.firstWhere((elemen) => elemen.userId == element.userId);

          comments.add(Comment(
            user: UserData(
                name: '${postedUser.name}',
                avatar: '${postedUser.userProfileImg}',
                verified: true),
            content: '${element.command}',
            time: '${DateFormat("dd/MM/yyyy hh:ss").format(element.createdAt!.toDate())}',
            replies: [],
          ),);
        });

        return CustomScrollView(
        slivers: [
          SliverAppBar(
            leadingWidth: 0,
            leading: Container(),
            toolbarHeight: 60,
            pinned: true,
            flexibleSpace: Material(
              elevation: 6,
              // top: 8,
              // bottom: 4,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 12, top: 12,bottom: 6),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                          child: const Icon(Icons.arrow_back)),
                       const SizedBox(width: 6,),
                      Expanded(
                        child: TextFormField(
                          showCursor: true,
                          cursorColor: Colors.blue,
                          // cursorHeight: 30,
                          cursorWidth: 2,
                          textAlignVertical: TextAlignVertical.center,
                          onChanged: (val) {
                            // context.read<SearchCubit>().searchUser(searchController.text);/
                          },
                          controller: searchController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 4),
                            hintText: 'Comment',

                            // Add a clear button to the search bar
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: InkWell(
                                onTap: () async{
                                  await PostManagement.postCommand(userId: userId,
                                    postId: widget.post.postId ?? '',
                                    command: searchController.text,
                                    receiverUserId: widget.post.userId ?? '',);
                                  searchController.text='';
                                },
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.blue),
                                  child: Center(child: Icon(
                                    Icons.send, color: Colors.white,),),
                                ),
                              ),
                            ),
                            // Add a search icon or button to the search bar
                            prefixIcon: const Icon(
                              Icons.comment, color: Colors.black, size: 20,),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  // const SizedBox(height: 48,),
                  Container(
                    // height: MediaQuery
                    //     .of(context)
                    //     .size
                    //     .height -
                    //     100 -
                    //     MediaQuery
                    //         .of(context)
                    //         .padding
                    //         .vertical,
                    child: SingleChildScrollView(
                      child: (comments.isNotEmpty) ? Column(
                        children: [
                          const SizedBox(height: 18,),
                          for (int i = 0; i < comments.length; i++)
                            SingleComment(
                              comment: comments[i],
                              level: 0,
                            ),
                        ],
                      ) : Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 88.0),
                            child: Center(child: Text("No Comments Yet")),
                          )),
                    ),
                  ),
                  const SizedBox(height: 48,),
                ],
              ),
            ),
          ),

        ],
        );
      } else {
        return const Column(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 66,),
          Center(child: SizedBox(height: 28,
            width: 28,
            child: CircularProgressIndicator(
              strokeWidth: 1.8, color: Colors.blue,),)),
        ],
        );
      }
          },
        );
        }else{
        return Container();
        }
  },
)

        ),
      ),
    );
  }
}
