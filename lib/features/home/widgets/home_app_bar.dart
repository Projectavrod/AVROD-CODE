import 'package:avrod/constants/global_variables.dart';
import 'package:avrod/features/home/widgets/search_screen.dart';
import 'package:flutter/material.dart';

import '../../chats/chat_screen.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            // IconButton(
            //   splashRadius: 20,
            //   onPressed: () {},
            //   icon:
               Container(
                color: Colors.black,
                height: 40,width: 40,
                child:Image.asset('assets/images/logo.jpeg'),
              ),
            const SizedBox(width: 4,),
            // ),
            const Text(
              'AVROD',
              style: TextStyle(
                color: GlobalVariables.secondaryColor,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: 35,
              height: 35,
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black12,
              ),
              child: IconButton(
                splashRadius: 18,
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen(),));
                },
                icon: const ImageIcon(
                  AssetImage('assets/images/search.png'),
                  size: 22,
                  color: Colors.black,
                ),
              ),
            ),
            // Container(
            //   alignment: Alignment.center,
            //   margin: const EdgeInsets.symmetric(horizontal: 5),
            //   width: 35,
            //   height: 35,
            //   padding: const EdgeInsets.all(0),
            //   decoration: const BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: Colors.black12,
            //   ),
            //   child: IconButton(
            //     splashRadius: 18,
            //     padding: const EdgeInsets.all(0),
            //     onPressed: () {
            //       Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
            //     },
            //     icon: const ImageIcon(
            //       AssetImage('assets/images/message.png'),
            //       size: 23,
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
          ],
        )
      ],
    );
  }
}
