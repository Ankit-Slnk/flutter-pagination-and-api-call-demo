import 'package:flutter/material.dart';
import 'package:flutterPaginationApi/bloc/selectedUserIdBloc.dart';
import 'package:flutterPaginationApi/models/SingleUserResponse.dart';
import 'package:flutterPaginationApi/models/UsersResponse.dart';
import 'package:flutterPaginationApi/screens/user/userScreen.dart';
import 'package:flutterPaginationApi/utility/apiManager.dart';
import 'package:flutterPaginationApi/utility/appStrings.dart';
import 'package:flutterPaginationApi/utility/utiity.dart';
import 'package:flutterPaginationApi/widgets/fullScreenImageSlider.dart';
import 'package:flutterPaginationApi/widgets/userEmailView.dart';
import 'package:flutterPaginationApi/widgets/userImageView.dart';
import 'package:flutterPaginationApi/widgets/userNameView.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utility/appColors.dart';

class UserDetailScreen extends StatefulWidget {
  int selectedUserId;
  UserDetailScreen({
    @required this.selectedUserId,
  });
  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  bool isLoading = false;
  UserDetails userDetails = UserDetails();

  @override
  void initState() {
    super.initState();
    if (widget.selectedUserId == null) {
      SelectedUserIdBloc.getSteam.listen((event) {
        getUser(event);
      });
    } else {
      getUser(widget.selectedUserId);
    }
  }

  getUser(int selectedUserId) async {
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
          url: AppStrings.USERS + "/" + selectedUserId.toString(),
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
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    return Column(
      children: [
        Expanded(
          child: Stack(
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
                        child: Utility.isNotMobileAndLandscape(context) &&
                                widget.selectedUserId == null
                            ? Container()
                            : Container(
                                padding: EdgeInsets.only(left: 8),
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    BackButton(
                                      color: AppColors.whiteColor,
                                      onPressed: () {
                                        if (Utility.isNotMobileAndLandscape(
                                                context) &&
                                            widget.selectedUserId == null) {
                                          SelectedUserIdBloc()
                                              .setSelectedUserId(null);
                                        } else {
                                          // case where detail page is open in portrait mode
                                          // and converted to landscape.
                                          // Then we need to open userScreen again.
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  new MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        UserScreen(),
                                                  ),
                                                  (Route<dynamic> route) =>
                                                      false);
                                        }
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
                                showDialog(
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Container(
                                        height: 250,
                                        width: 250,
                                        child: FullScreenImageSlider(
                                          imagelist: [userDetails.avatar],
                                          selectedimage: 0,
                                        ),
                                      ),
                                    );
                                  },
                                  context: context,
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
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 8),
          alignment: Alignment.bottomCenter,
          child: Text("Made with ♥ in Flutter"),
        )
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
          height: Vx.dp4,
        ),
        UserEmailView(
          userDetails: userDetails,
          isDetailScreen: true,
        )
      ],
    );
  }
}
