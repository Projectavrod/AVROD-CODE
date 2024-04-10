import 'package:flutter/material.dart';
class UserFriendsList extends StatefulWidget {
  const UserFriendsList({Key? key}) : super(key: key);

  @override
  State<UserFriendsList> createState() => _UserFriendsListState();
}

class _UserFriendsListState extends State<UserFriendsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0.5),
            child: Container(
              color: Colors.blue,
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
                'Friends',
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
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
