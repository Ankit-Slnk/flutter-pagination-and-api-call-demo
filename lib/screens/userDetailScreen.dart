import 'package:flutter/material.dart';
import 'package:flutterPaginationApi/models/SingleUserResponse.dart';
import 'package:flutterPaginationApi/models/UsersResponse.dart';
import 'package:flutterPaginationApi/utility/apiManager.dart';
import 'package:flutterPaginationApi/utility/appDimens.dart';
import 'package:flutterPaginationApi/utility/appStrings.dart';
import 'package:flutterPaginationApi/utility/utiity.dart';
import 'package:flutterPaginationApi/widgets/fullScreenImageSlider.dart';
import 'package:flutterPaginationApi/widgets/userEmailView.dart';
import 'package:flutterPaginationApi/widgets/userImageView.dart';
import 'package:flutterPaginationApi/widgets/userNameView.dart';

import '../utility/appColors.dart';

class UserDetailScreen extends StatefulWidget {
  int id;
  UserDetailScreen({@required this.id});
  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  bool isLoading = false;
  UserDetails userDetails = UserDetails();
  AppDimens appDimens;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    //first check for internet connectivity
    if (await ApiManager.checkInternet()) {
      //show progress
      if (mounted)
        setState(() {
          isLoading = true;
        });

      //convert json response to class
      SingleUserResponse response = SingleUserResponse.fromJson(
        await ApiManager(context).getCall(
          url: AppStrings.USERS + "/" + widget.id.toString(),
          request: null,
        ),
      );

      //hide progress
      if (mounted)
        setState(() {
          isLoading = false;
        });

      if (response?.data != null) {
        if (mounted) {
          setState(() {
            userDetails = response.data;
          });
        }
      }
    } else {
      //if no internet connectivity available then show apecific message
      Utility.showToast("No Internet Connection");
    }
  }

  @override
  Widget build(BuildContext context) {
    appDimens = new AppDimens(MediaQuery.of(context).size);

    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    return Stack(
      children: [
        Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: kToolbarHeight),
                  height: kToolbarHeight * 2,
                  decoration: BoxDecoration(
                    color: AppColors.appColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        BackButton(
                          color: AppColors.whiteColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: kToolbarHeight * 3,
                  child: Column(
                    children: [
                      SizedBox(
                        height: kToolbarHeight,
                      ),
                      UserImageView(
                        userDetails: userDetails,
                        onImageTap: () {
                          Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  FullScrennImageSlider(
                                imagelist: [userDetails.avatar],
                                selectedimage: 0,
                              ),
                            ),
                          );
                        },
                        isDetailScreen: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            userNameView()
          ],
        ),
        isLoading ? Utility.progress(context) : Container()
      ],
    );
  }

  Widget userNameView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UserNameView(
          isDetailScreen: true,
          userDetails: userDetails,
        ),
        SizedBox(
          height: appDimens.paddingw4,
        ),
        UserEmailView(
          userDetails: userDetails,
          isDetailScreen: true,
        )
      ],
    );
  }
}
