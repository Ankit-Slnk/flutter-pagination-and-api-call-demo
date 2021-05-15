# Flutter Pagination & Api Call Demo

![Flutter Pagination & Api Call Demo](flutter-pagination-and-api-call-demo.png)

This demo will show us how to call `post` and `get` HTTP request in flutter. This will also show us how to use `pagination` in list.

![Flutter Pagination & Api Call Demo](flutter_pagination_api_call.gif)

We will be using [REQ | RES](https://reqres.in/), which simulates real api.

## Setup

Use latest versions of below mentioned plugins in `pubspec.yaml`.

| Plugin | Pub | Explanation |
|--------|-----|-------------|
| [http](https://github.com/dart-lang/http) | [![pub package](https://img.shields.io/pub/v/http.svg)](https://pub.dev/packages/http) | Used to make HTTP request.
| [connectivity](https://github.com/flutter/plugins/tree/master/packages/connectivity/connectivity) | [![pub package](https://img.shields.io/pub/v/connectivity.svg)](https://pub.dev/packages/connectivity) | Used to check internet connectivity.
| [visibility_detector](https://github.com/google/flutter.widgets) | [![pub package](https://img.shields.io/pub/v/visibility_detector.svg)](https://pub.dev/packages/visibility_detector) | Detect the visibility of widget. Used for pagination.
[cached_network_image](https://github.com/Baseflow/flutter_cached_network_image) | [![pub package](https://img.shields.io/pub/v/cached_network_image.svg)](https://pub.dev/packages/cached_network_image) | Caching image loaded from internet.
[velocity_x](https://github.com/iampawan/VelocityX) | [![pub package](https://img.shields.io/pub/v/velocity_x.svg)](https://pub.dev/packages/velocity_x) | Open-source minimalist UI Framework built with Flutter SDK.

And then

    flutter pub get

#### For Android

    <uses-permission android:name="android.permission.INTERNET" />

Please mention `internet` permission in `AndroidManifest.xml`. This will not affect in `debug` mode but in `release` mode it will give `socket exception`.

#### For iOS

No Setup required.

### Check internet connectivity

    static Future<bool> checkInternet() async {
        try {
            var connectivityResult = await (Connectivity().checkConnectivity());
            if (connectivityResult == ConnectivityResult.none) {
                return false;
            } else {
                return true;
            }
        } catch (e) {
            return false;
        }
    }

### GET Request

    GET     https://reqres.in/api/users?page=<page_number>

Convert `JSON` response from this api to `dart class` using [JSON to Dart](https://javiercbk.github.io/json_to_dart/).

`getCall` function will return `json` from string http get response.

    getCall({@required String url, @required Map<String, dynamic> request}) async {
        var uri = Uri.parse(url);
        uri = uri.replace(queryParameters: request);
        http.Response response = await http.get(uri);
        return await jsonDecode(response.body);
    }

Now we need to convert this `json` response to `class`.

    UsersResponse response = UsersResponse.fromJson(
        await ApiManager(context).getCall(
            url: AppStrings.USERS,
            request: request,
        ),
    );

##### Function to get user page wise

    getUsers() async {
        //first check for internet connectivity
        if (await ApiManager.checkInternet()) {
            //show progress
            if (mounted)
              setState(() {
                isLoading = true;
              });

            page = page + 1;
            var request = Map<String, dynamic>();
            request["page"] = page.toString();

            //convert json response to class
            UsersResponse response = UsersResponse.fromJson(
              await ApiManager(context).getCall(
                url: AppStrings.USERS,
                request: request,
              ),
            );

            //hide progress
            if (mounted)
              setState(() {
                isLoading = false;
              });

            if (response != null) {
              if (response.data.length > 0) {
                if (mounted) {
                  setState(() {
                    //add paginated list data in list
                    userDetails.addAll(response.data);
                  });
                }
              } else {
                noDataLogic(page);
              }
            } else {
              noDataLogic(page);
            }
        }   else {
            //if no internet connectivity available then show apecific message
            Utility.showToast("No Internet Connection");
        }
    }

##### View to show paginated data in list

    Widget body() {
      return Stack(
        children: <Widget>[
            RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () async {
                refresh();
              },
              child: !isLoading && userDetails.length == 0
                  /*

                    i have shown empty view in list view because refresh indicator will not work if there is no   list.

                  */
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height -
                              ((AppBar().preferredSize.height * 2) + 30),
                          child: Utility.emptyView("No Users"),
                        ),
                      ],
                    )

                  //try this code you can see that refresh indicator will not work
                  // return Utility.emptyView("No Users");

                  : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.only(
                        bottom: 12,
                      ),
                      itemCount: userDetails.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            (userDetails.length - 1) == index
                                /*

                              VisibilityDetector is only attached to last item of list.
                              when this view is visible we will call api for next page.

                            */
                                ? VisibilityDetector(
                                    key: Key(index.toString()),
                                    child: itemView(index),
                                    onVisibilityChanged: (visibilityInfo) {
                                      if (!stop) {
                                        getUsers();
                                      }
                                    },
                                  )
                                : itemView(index)
                          ],
                        );
                      },
                    ),
            ),
            //show progress
            isLoading ? Utility.progress(context) : Container()
        ],
      );
    }


Put a click on users itemview to redirect to `UserDetailScreen`

    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (BuildContext context) => UserDetailScreen(
          id: userDetails[index].id,
        ),
      ),
    );

### POST Request

    POST     https://reqres.in/api/users/<id>

Replace `<id>` with user id.

#### Function to call single user

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

Finally

    flutter run

<!-- ##### Please refer to my [blogs](https://ankitsolanki.netlify.app/blog.html) for more information. -->

Checkout [this demo](https://flutter-web-pagination-api-call.netlify.app/#/) in [Flutter Web](https://flutter.dev/docs/get-started/web).