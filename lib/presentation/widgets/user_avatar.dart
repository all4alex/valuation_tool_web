import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String? profilePicture;
  final String? initials;
  final double? width;
  final double? height;

  UserAvatar({this.profilePicture, this.height, this.width, this.initials});

  @override
  Widget build(BuildContext context) {
    String? profilePicture = this.profilePicture;

    final MediaQueryData queryData = MediaQuery.of(context);

    return profilePicture!.isNotEmpty
        ? Container(
            width: width,
            height: height,
            child: CachedNetworkImage(
              imageUrl: profilePicture,
              imageBuilder: (context, imageProvider) => Container(
//                            height: imageWidth.toDouble(),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 1.0,
                    ),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover, image: imageProvider),
                  )),
              errorWidget: (context, url, error) => Container(
//                            height: imageWidth.toDouble(),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 1.0,
                    ),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/default_avatar.png'))),
              ),
            ))
        : Container(
            width: width,
            height: height,
            child: Center(
                child: initials != null
                    ? Text(
                        initials!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      )
                    : Container(
//                            height: imageWidth.toDouble(),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 1.0,
                            ),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/images/default_avatar.png'))),
                      )),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
                width: 1.0,
              ),
              shape: BoxShape.circle,
            ),
          );
  }
}
