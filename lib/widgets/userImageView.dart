import 'package:flutter/material.dart';

import '../models/UsersResponse.dart';
import '../utility/appAssets.dart';
import '../utility/utiity.dart';

class UserImageView extends StatelessWidget {
  UserDetails userDetails;
  Function onImageTap;
  bool isDetailScreen;

  UserImageView({
    @required this.isDetailScreen,
    @required this.onImageTap,
    @required this.userDetails,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onImageTap,
      child: Container(
        height: isDetailScreen ? 100 : 50,
        width: isDetailScreen ? 100 : 50,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Theme.of(context).scaffoldBackgroundColor,
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Utility.imageLoader(
              userDetails.avatar,
              AppAssets.imagePlaceholder,
            ),
          ),
        ),
      ),
    );
  }
}
