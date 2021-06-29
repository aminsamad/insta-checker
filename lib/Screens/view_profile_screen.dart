import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:insta_checker/Theme/storage_manager.dart';
import 'package:insta_checker/Theme/theme_data.dart';
import 'package:provider/provider.dart';

bool status = true;

class ViewProfileScreen extends StatefulWidget {
  final String username;
  final String followers;
  final String followings;
  final String posts;
  final String bio;
  final String website;
  final String profileImagLink;
  const ViewProfileScreen(
      {Key key,
      this.username,
      this.followers,
      this.followings,
      this.posts,
      this.bio,
      this.website,
      this.profileImagLink})
      : super(key: key);

  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (BuildContext context, theme, _) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          child: SafeArea(
            child: Scaffold(
                backgroundColor: theme.getTheme().scaffoldBackgroundColor,
                appBar: AppBar(
                  actions: [
                    DayNightSwitcherIcon(
                      isDarkModeEnabled: status,
                      onStateChanged: (value) {
                        print("VALUE : $value");
                        setState(() {
                          status = value;
                          if (status == false) {
                            theme.setDarkMode();
                          } else {
                            theme.setLightMode();
                          }
                        });
                      },
                    ),
                  ],
                  backgroundColor: theme.getTheme().backgroundColor,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_rounded,
                        color: theme.getTheme().iconTheme.color),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Text Searched
                      Container(
                        width: double.infinity,
                        color: theme.getTheme().backgroundColor,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text("Searched For",
                              style: theme
                                  .getTheme()
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25)),
                        ),
                      ),
                      //Profile
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        decoration: BoxDecoration(
                            color: theme.getTheme().backgroundColor,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 15,
                                  offset: Offset(0, 20),
                                  color: theme.getTheme().shadowColor)
                            ],
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20))),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              child: Material(
                                shape: CircleBorder(
                                    side: BorderSide(
                                        width: 2,
                                        color: theme.getTheme().primaryColor)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(1000),
                                    child: Image.asset(widget.profileImagLink)),
                              ),
                            ),

                            //Username
                            Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 20),
                              child: Text(widget.username,
                                  style: theme
                                      .getTheme()
                                      .textTheme
                                      .headline4
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20)),
                            ),

                            //Bio
                            Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Text(widget.bio,
                                  textAlign: TextAlign.center,
                                  style: theme
                                      .getTheme()
                                      .textTheme
                                      .headline3
                                      .copyWith(fontSize: 17)),
                            ),

                            //Follow & Followings Row
                            Padding(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Posts",
                                          style: theme
                                              .getTheme()
                                              .textTheme
                                              .headline3
                                              .copyWith(fontSize: 14),
                                        ),
                                        Text(widget.posts,
                                            style: theme
                                                .getTheme()
                                                .textTheme
                                                .headline4
                                                .copyWith(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold))
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Followers",
                                          style: theme
                                              .getTheme()
                                              .textTheme
                                              .headline3
                                              .copyWith(fontSize: 14),
                                        ),
                                        Text(widget.followers,
                                            style: theme
                                                .getTheme()
                                                .textTheme
                                                .headline4
                                                .copyWith(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold))
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Followings",
                                          style: theme
                                              .getTheme()
                                              .textTheme
                                              .headline3
                                              .copyWith(fontSize: 14),
                                        ),
                                        Text(widget.followings,
                                            style: theme
                                                .getTheme()
                                                .textTheme
                                                .headline4
                                                .copyWith(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold))
                                      ],
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ));
    });
  }
}
