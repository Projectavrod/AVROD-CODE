import 'dart:math';

import 'package:avrod/models/comment.dart';
import 'package:flutter/material.dart';

import '../../../Widgets/image_widget.dart';

class SingleComment extends StatefulWidget {
  final Comment comment;
  final int level;
  const SingleComment({super.key, required this.comment, required this.level});

  @override
  State<SingleComment> createState() => _SingleCommentState();
}

Size _textSize(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr)
    ..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size;
}

class _SingleCommentState extends State<SingleComment> {
  List<String> icons = [];
  String reactions = '0';
  bool viewReplies = false;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            )
        ,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  height: 40,width: 40,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
                  child: ImageWidget(url: widget.comment.user.avatar),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              (widget.comment.content.isNotEmpty)
                  ? Container(
                    width: 200,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Wrap(
                              children: [
                                Text(
                                  widget.comment.user.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                // (widget.comment.user.verified == true
                                //     ? const Padding(
                                //         padding: EdgeInsets.only(left: 2),
                                //         child: Icon(
                                //           Icons.verified,
                                //           color: Colors.blue,
                                //           size: 15,
                                //         ),
                                //       )
                                //     : const SizedBox()),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.comment.content,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.comment.user.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          (widget.comment.user.verified == true
                              ? const Padding(
                                  padding: EdgeInsets.only(left: 2),
                                  child: Icon(
                                    Icons.verified,
                                    color: Colors.blue,
                                    size: 15,
                                  ),
                                )
                              : const SizedBox()),
                        ],
                      ),
                    ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
      Padding(
        padding: const EdgeInsets.only(left: 48.0),
        child: Text(
                widget.comment.time,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
      ),
          // if (widget.comment.image != null)
          //   Padding(
          //     padding: EdgeInsets.only(
          //       bottom: 5,
          //       left: widget.level == 0 ? 45 : 45 + widget.level * 35,
          //     ),
          //     child: ClipRRect(
          //       borderRadius: BorderRadius.circular(20),
          //       child: Image.asset(
          //         widget.comment.image!,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     SizedBox(
          //       width: widget.level == 0 ? 50 : 40,
          //     ),
          //     Text(
          //       widget.comment.time,
          //       style: const TextStyle(fontSize: 16, color: Colors.black54),
          //     ),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     const Text(
          //       'Likes',
          //       style: TextStyle(
          //           fontSize: 16,
          //           color: Colors.black54,
          //           fontWeight: FontWeight.w500),
          //     ),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     const Text(
          //       'Reply',
          //       style: TextStyle(
          //         fontSize: 16,
          //         color: Colors.black54,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     if (reactions != '0')
          //       Row(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Text(
          //             reactions,
          //             style: const TextStyle(
          //               color: Colors.black54,
          //               fontWeight: FontWeight.w300,
          //               fontSize: 16,
          //             ),
          //           ),
          //           const SizedBox(
          //             width: 5,
          //           ),
          //           // SizedBox(
          //           //   width: 60,
          //           //   child: Stack(
          //           //     children: [
          //           //       const SizedBox(
          //           //         width: 24,
          //           //         height: 24,
          //           //       ),
          //           //       // if (icons.length > 2)
          //           //       //   Positioned(
          //           //       //     top: 2,
          //           //       //     left: 38,
          //           //       //     child: Image.asset(
          //           //       //       icons[2],
          //           //       //       width: 20,
          //           //       //     ),
          //           //       //   ),
          //           //       // if (icons.length > 1)
          //           //       //   Positioned(
          //           //       //     top: 0,
          //           //       //     left: 18,
          //           //       //     child: Container(
          //           //       //       decoration: BoxDecoration(
          //           //       //           shape: BoxShape.circle,
          //           //       //           border: Border.all(
          //           //       //             color: Colors.white,
          //           //       //             width: 2,
          //           //       //           )),
          //           //       //       child: Image.asset(
          //           //       //         icons[1],
          //           //       //         width: 20,
          //           //       //       ),
          //           //       //     ),
          //           //       //   ),
          //           //       // Positioned(
          //           //       //   top: 0,
          //           //       //   left: 0,
          //           //       //   child: Container(
          //           //       //     decoration: BoxDecoration(
          //           //       //         shape: BoxShape.circle,
          //           //       //         border: Border.all(
          //           //       //           color: Colors.white,
          //           //       //           width: 2,
          //           //       //         )),
          //           //       //     child: Image.asset(
          //           //       //       icons[0],
          //           //       //       width: 20,
          //           //       //     ),
          //           //       //   ),
          //           //       // ),
          //           //     ],
          //           //   ),
          //           // ),
          //         ],
          //       ),
          //   ],
          // ),
          // if (widget.comment.replies.isNotEmpty && !viewReplies)
          //   Padding(
          //     padding: const EdgeInsets.only(top: 5, left: 40),
          //     child: InkWell(
          //       onTap: () {
          //         setState(() {
          //           viewReplies = true;
          //         });
          //       },
          //       child: Text(
          //         'See ${widget.comment.replies.length} Reply',
          //         style: const TextStyle(
          //           fontSize: 15,
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //     ),
          //   ),
          // if (viewReplies)
          //   for (int i = 0; i < widget.comment.replies.length; i++)
          //     SingleComment(
          //       comment: widget.comment.replies[i],
          //       level: widget.level + 1,
          //     ),
        ],
      ),
    );
  }
}
