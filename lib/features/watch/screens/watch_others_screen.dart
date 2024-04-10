import 'package:avrod/features/watch/screens/watch_screen.dart';
import 'package:avrod/features/watch/widgets/watch_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:video_player/video_player.dart';

import '../../../models/post.dart';
import '../../../models/user.dart';

class WatchOthersScreen extends StatefulWidget {
  final VideoControllerWrapper controllerInit;
  final Post postInit;
  const WatchOthersScreen({
    super.key,
    required this.controllerInit,
    required this.postInit,
  });

  @override
  State<WatchOthersScreen> createState() => _WatchOthersScreenState();
}

class _WatchOthersScreenState extends State<WatchOthersScreen> {
  final keyInit = GlobalKey();
  ScrollController scrollController = ScrollController();
  int index = 0;
  List<VideoControllerWrapper> videoController = [];
  final posts = [
    Post(
      user: UserData(name: 'Dawn', avatar: 'assets/images/user/aki.jpg'),
      time: '14 thg 7, 2022',
      shareWith: 'public',
      content: 'Serena is a Pokemon trainer who has a crush on Ash Ketchum .',
      like: 15000,
      angry: 3,
      comment: 210,
      haha: 3000,
      love: 1100,
      lovelove: 78,
      sad: 36,
      share: 98,
      wow: 18,
      video: ['assets/videos/4.mp4'],
    ),
    Post(
      user: UserData(
          name: 'Madonna Louise',
          avatar: 'assets/images/user/daiphatthanh.jpg'),
      time: '17 thg 1, 2021',
      shareWith: 'public',
      content:
      'Madonna Louise Ciccone is an American singer, songwriter, and actress.\n-\nMadonna has been widely recognized for her continual reinvention and versatility in music production, songwriting, and visual presentation.\n Live Session…',
      like: 12000,
      angry: 1,
      comment: 902,
      haha: 21,
      love: 2100,
      lovelove: 67,
      sad: 20,
      share: 98,
      wow: 5,
      video: ['assets/videos/5.mp4'],
    ),
    Post(
      user: UserData(name: 'Messi', avatar: 'assets/images/user/spezon.jpg'),
      time: '27 tháng 8',
      shareWith: 'public',
      content: 'Lionel Messi World cup Champion [Messi EP. FINAL]',
      like: 4100,
      angry: 1,
      comment: 72,
      haha: 21,
      love: 888,
      lovelove: 100,
      sad: 20,
      share: 98,
      wow: 5,
      video: ['assets/videos/6.mp4'],
    ),
  ];
  List<GlobalKey> key = [];

  @override
  void initState() {
    super.initState();
    videoController =
        List.generate(posts.length, (index) => VideoControllerWrapper(null));
    key = List.generate(
        posts.length, (index) => GlobalKey(debugLabel: index.toString()));
  }

  @override
  void dispose() {
    scrollController.dispose();

    /*for (int i = 0; i < videoController.length; i++) {
      videoController[i].value?.dispose();
    }*/
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.black87,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.5),
              child: Container(
                color: Colors.black12,
                height: 0.5,
              )),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                splashRadius: 20,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              const Expanded(
                child: Text(
                  'Video',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                onPressed: () {},
                splashRadius: 20,
                icon: const Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scroll) {
          var currentContext = keyInit.currentContext;
          if (currentContext != null) {
            var renderObject = currentContext.findRenderObject();
            RenderAbstractViewport viewport =
                RenderAbstractViewport.of(renderObject);
            var offsetToRevealBottom =
                viewport.getOffsetToReveal(renderObject!, 1.0);
            var offsetToRevealTop =
                viewport.getOffsetToReveal(renderObject, 0.0);

            if (offsetToRevealBottom.offset > scroll.metrics.pixels ||
                scroll.metrics.pixels > offsetToRevealTop.offset) {
              //print('$i out of viewport');
            } else {
              //print('$i in viewport');
              if (widget.controllerInit.value != null) {
                if (widget.controllerInit.value!.value.isInitialized) {
                  widget.controllerInit.value?.play();
                }
              }
              return false;
            }
          }
          for (int i = 0; i < posts.length; i++) {
            var currentContext = key[i].currentContext;
            if (currentContext == null) continue;

            var renderObject = currentContext.findRenderObject();
            RenderAbstractViewport viewport =
                RenderAbstractViewport.of(renderObject);
            var offsetToRevealBottom =
                viewport.getOffsetToReveal(renderObject!, 1.0);
            var offsetToRevealTop =
                viewport.getOffsetToReveal(renderObject, 0.0);

            if (offsetToRevealBottom.offset > scroll.metrics.pixels ||
                scroll.metrics.pixels > offsetToRevealTop.offset) {
              //print('$i out of viewport');
            } else {
              //print('$i in viewport');
              if (videoController[i].value != null) {
                if (videoController[i].value!.value.isInitialized) {
                  videoController[i].value!.play();
                }
              }
            }
          }
          return false;
        },
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              Column(
                children: [
                  WatchVideo(
                    post: widget.postInit,
                    videoKey: keyInit,
                    controller:
                        VideoControllerWrapper(widget.controllerInit.value),
                    autoPlay: true,
                    isDarkMode: true,
                    noDispose: true,
                  ),
                  Container(
                    width: double.infinity,
                    height: 5,
                    color: Colors.black87,
                  ),
                  ...posts.asMap().entries.map((e) {
                    return Column(
                      children: [
                        WatchVideo(
                          post: e.value,
                          videoKey: key[e.key],
                          controller: videoController[e.key],
                          autoPlay: false,
                          isDarkMode: true,
                        ),
                        Container(
                          width: double.infinity,
                          height: 5,
                          color: Colors.black87,
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
