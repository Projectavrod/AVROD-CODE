import 'package:avrod/features/comment/screens/comment_screen.dart';
import 'package:avrod/features/friends/screens/friends_screen.dart';
import 'package:avrod/features/friends/screens/friends_search_screen.dart';
import 'package:avrod/features/friends/screens/friends_suggest_screen.dart';
import 'package:avrod/features/home/screens/home_screen.dart';
// import 'package:avrod/features/market_place/screens/product_details_screen.dart';
import 'package:avrod/features/memory/screens/memory_screen.dart';
import 'package:avrod/features/news-feed/screen/image_fullscreen.dart';
import 'package:avrod/features/news-feed/screen/multiple_images_post_screen.dart';
import 'package:avrod/features/news-feed/widgets/story_details.dart';
import 'package:avrod/features/personal-page/screens/personal_page_screen.dart';
import 'package:avrod/models/post.dart';
import 'package:avrod/models/product.dart';
import 'package:avrod/models/story.dart';
import 'package:avrod/models/user.dart';
import 'package:flutter/material.dart';

import 'features/news-feed/screen/liked_users_screen.dart';
import 'models/post_model.dart';
import 'models/user_model.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
    case StoryDetails.routeName:
      final Story story = routeSettings.arguments as Story;
      return PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => StoryDetails(story: story),
      );

    // case ProductDetailsScreen.routeName:
    //   final Product product = routeSettings.arguments as Product;
    //   return PageRouteBuilder(
    //     pageBuilder: (context, animation, secondaryAnimation) =>
    //         ProductDetailsScreen(
    //       product: product,
    //     ),
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       const begin = Offset(1.0, 0.0);
    //       const end = Offset.zero;
    //       const curve = Curves.ease;
    //
    //       var tween =
    //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    //
    //       return SlideTransition(
    //         position: animation.drive(tween),
    //         child: child,
    //       );
    //     },
    //   );
    case CommentScreen.routeName:
      final PostModel post = routeSettings.arguments as PostModel;
      return PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) => CommentScreen(
          post: post,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
    case LikedUsersScreen.routeName:
      final String postId = routeSettings.arguments as String;
      return PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) => LikedUsersScreen(
          postId: postId,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
    case ImageFullScreen.routeName:
      final Post post = routeSettings.arguments as Post;
      return PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) =>
            ImageFullScreen(
          post: post,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      );
    case MultipleImagesPostScreen.routeName:
      final Post post = routeSettings.arguments as Post;
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            MultipleImagesPostScreen(
          post: post,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
    case MemoryScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const MemoryScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
    case FriendsScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const FriendsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
    case FriendsSuggestScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const FriendsSuggestScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
    case FriendsSearchScreen.routeName:
      final String userId = routeSettings.arguments as String;
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
             FriendsSearchScreen(userId: userId),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
    case PersonalPageScreen.routeName:
      final String userId = routeSettings.arguments as String;
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            PersonalPageScreen(userId: userId),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('404: Not Found'),
          ),
        ),
        settings: routeSettings,
      );
  }
}
