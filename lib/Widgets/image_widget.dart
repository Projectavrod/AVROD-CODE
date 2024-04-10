

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key,required this.url,this.icon,this.iconSize});
  final String? url;
  final IconData? icon;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: (url != null || url?.isNotEmpty==true || icon == null)? url??''  : 'https://firebasestorage.googleapis.com/v0/b/avrod-5c1c9.appspot.com/o/2023-12-06%2002%3A41%3A55.430846profileImage?alt=media&token=43de1df5-7afc-4556-b0f7-831637000a90',
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          Container(
            height: iconSize??40,width: iconSize??40,
              child: CircularProgressIndicator(value: downloadProgress.progress)),
      errorWidget: (context, url, error) =>  Image.asset('assets/images/user/userImage.png',height:iconSize?? 40,width: iconSize?? 40,),
    );
  }
}
