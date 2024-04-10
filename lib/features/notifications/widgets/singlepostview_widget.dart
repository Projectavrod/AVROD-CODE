import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/post_model.dart';
import '../../news-feed/widgets/post_card.dart';
class SinglePostViewWidget extends StatefulWidget {
  const SinglePostViewWidget({Key? key, required this.postId}) : super(key: key);
  final String postId;
  @override
  State<SinglePostViewWidget> createState() => _SinglePostViewWidgetState();
}

class _SinglePostViewWidgetState extends State<SinglePostViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post',style: Theme.of(context).textTheme.labelLarge?.apply(fontWeightDelta: 1,fontSizeDelta: 2,color: Colors.black),),
      ),
      body:Column(
        children: [
           SizedBox(height: 8,),

          StreamBuilder(
            stream:  FirebaseFirestore.instance.collection('posts')
                .doc(widget.postId)
                .snapshots(),
            builder: (context, snap) {
              if(snap.hasData){

                PostModel post = PostModel.fromJson(snap.data?.data() ?? {});

                return Column(
                  children: [
                    const SizedBox(height: 10),
                    PostCard(
                      post:post,
                    ),
                    Container(
                      width: double.infinity,
                      height: 1.5,
                      color: Colors.grey.shade300,
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
      ),
    );
  }
}
