import 'package:avrod/models/user.dart';
import 'package:flutter/material.dart';

import '../models/post.dart';
import '../models/story.dart';

class UserProvider extends ChangeNotifier {
  final UserData _user = UserData(
    name: 'Lalitha',
    avatar: 'assets/images/user/lcd.jpg',
    educations: [
      Education(
        majors: 'Software Engineering',
        school: 'KHMC School',
      ),
    ],
    hometown: 'Chennai',
    followers: 4820,
    friends: 1150,
    hobbies: [
      '💻 Laptop',
      '📚 Books',
      '⚽ Foot Ball',
      '🎮 Playing Games',
      '🎧 Hearing Music',
      '📖 Reading',
    ],
    socialMedias: [
      SocialMedia(
        icon: 'assets/images/github.png',
        name: 'Daniel',
        link: 'https://github.com/Dat-TG',
      ),
      SocialMedia(
          icon: 'assets/images/linkedin.png',
          name: 'Dhivya',
          link: 'https://www.linkedin.com/in/ddawst/'),
    ],
    stories: [
      Story(
        user: UserData(
          name: 'Lalitha',
          avatar: 'assets/images/user/lcd.jpg',
        ),
        image: ['assets/images/story/3.jpg'],
        time: ['5 giờ'],
        shareWith: 'friends-of-friends',
        name: 'Featured',
      ),
      Story(
        user: UserData(
          name: 'Lalitha',
          avatar: 'assets/images/user/lcd.jpg',
        ),
        image: [
          'assets/images/story/4.jpg',
          'assets/images/story/5.jpg',
          'assets/images/story/6.jpg',
          'assets/images/story/7.jpg',
        ],
        video: ['assets/videos/2.mp4', 'assets/videos/1.mp4'],
        time: ['1 phút'],
        shareWith: 'friends',
        name: '18+',
      ),
      Story(
        user: UserData(
          name: 'Lalitha',
          avatar: 'assets/images/user/lcd.jpg',
        ),
        video: ['assets/videos/3.mp4'],
        time: ['1 phút'],
        shareWith: 'friends',
        name: '20+',
      ),
    ],
    bio: 'I am Daniel',
    cover: 'assets/images/user/lcd-cover.jpg',
    guard: true,
    topFriends: [
      UserData(
        name: 'Kaviya',
        avatar: 'assets/images/user/khanhvy.jpg',
      ),
      UserData(
        name: 'Messi',
        avatar: 'assets/images/user/messi.jpg',
      ),
      UserData(
        name: 'Manikandon',
        avatar: 'assets/images/user/minhhuong.jpg',
      ),
      UserData(
        name: 'Baby Shalini',
        avatar: 'assets/images/user/baongan.jpg',
      ),
      UserData(
        name: 'Hema Malini',
        avatar: 'assets/images/user/halinh.jpg',
      ),
      UserData(
        name: 'Monisha',
        avatar: 'assets/images/user/minhtri.jpg',
      ),
    ],
    posts: [
      Post(
        user: UserData(
          name: 'Lalitha',
          avatar: 'assets/images/user/lcd.jpg',
        ),
        time: '3 phút',
        shareWith: 'public',
        content:
        'Football is an outdoor game played by two teams having eleven players in each.\n\n This game is also known as soccer and played with a spherical ball. \n\nIt has been estimated that it is played by around 250 million players over 150 countries which makes it a most popular game of the world. \n\nIt is played on a rectangular field having a goal-post at each end. \n\nIt is a competitive game generally played to win the game by any team or for entertainment and enjoyment. \n\nIt provides physical benefits to the players in many ways as it is a best exercise. \n\nIt is a most exciting and challenging game generally liked by everyone especially kids and children.',
        image: ['assets/images/post/2.jpg'],
        like: 163,
        love: 24,
        comment: 5,
        type: 'memory',
      ),
      Post(
        user: UserData(
          name: 'Lalitha',
          avatar: 'assets/images/user/lcd.jpg',
        ),
        time: '3 phút',
        shareWith: 'public',
        content: 'Do you like Photography?\nBecause I can be your Photo-ever ✨✨',
        image: [
          'assets/images/post/3.jpg',
          'assets/images/post/5.jpg',
          'assets/images/post/12.jpg',
          'assets/images/post/13.jpg',
          'assets/images/post/14.jpg',
          'assets/images/post/15.jpg',
          'assets/images/post/16.jpg',
        ],
        like: 15000,
        love: 7300,
        comment: 258,
        haha: 235,
        share: 825,
        lovelove: 212,
        wow: 9,
        layout: 'classic',
        type: 'memory',
      ),
      Post(
        user: UserData(
          name: 'Lalitha',
          avatar: 'assets/images/user/lcd.jpg',
        ),
        time: '3 phút',
        shareWith: 'public',
        content:
            'The news is a great resource for practicing listening to English in real-life scenarios.\n\n  The news anchors usually speak quickly so it will be a challenge to understand everything, but it’s a tool to exercise your listening and comprehension skills.\n\nCartoons are useful if you want to sit back, relax and have some fun. \n\n  If you enjoy watching animated shows, then you should watch them in English too. \n\n Cartoons are also good for exposing yourself to English culture and humour.',
        image: [
          'assets/images/post/3.jpg',
          'assets/images/post/4.jpg',
          'assets/images/post/5.jpg'
        ],
        like: 15000,
        love: 7300,
        comment: 258,
        haha: 235,
        share: 825,
        lovelove: 212,
        wow: 9,
        layout: 'column',
        type: 'memory',
      ),
    ],
  );
  UserData get user => _user;
}
