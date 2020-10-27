import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

import '../models/UsersResponse.dart';
import '../utility/appColors.dart';

class UserEmailView extends StatelessWidget {
  UserDetails userDetails;
  bool isDetailScreen;
  UserEmailView({
    @required this.userDetails,
    @required this.isDetailScreen,
  });

  @override
  Widget build(BuildContext context) {
    return (userDetails?.email == null ? "" : userDetails.email)
        .text
        .gray500
        .size(16)
        .make();
  }
}
