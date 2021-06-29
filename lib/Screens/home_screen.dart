import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:insta_checker/Screens/view_profile_screen.dart';
import 'package:insta_checker/Theme/theme_data.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (BuildContext context, theme, _) => MaterialApp(
          routes: <String, WidgetBuilder>{
            '/viewScreen': (BuildContext context) => new ViewProfileScreen(),
          },
          debugShowCheckedModeBanner: false,
          theme: theme.getTheme(),
          home: MyClass()),
    );
  }
}

class MyClass extends StatefulWidget {
  const MyClass({Key key}) : super(key: key);

  @override
  _MyClassState createState() => _MyClassState();
}

class _MyClassState extends State<MyClass> {
  FlutterInsta flutterInsta = FlutterInsta();
  TextEditingController usernameController = TextEditingController();

  String username = 'amin._.samad';
  String posts = '1';
  String followers = '15.2k';
  String followings = '4';
  String website = "https://url.bio/aminsamad";
  String profileImageLink = 'assets/my-picture.jpg';
  String bio =
      'If you have ever got tired of life tell yourself hope starts in darkness';
//get data from api
  Future printDetails(String username) async {
    await flutterInsta.getProfileData(username);
    setState(() {
      this.username = flutterInsta.username; //username
      this.followers = flutterInsta.followers; //number of followers
      this.followings = flutterInsta.following; // number of following
      this.website = flutterInsta.website; // bio link
      this.bio = flutterInsta.bio; // Bio
      this.profileImageLink = flutterInsta.imgurl; // Profile picture URL
      print(followers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (BuildContext context, theme, _) => AnnotatedRegion<
              SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          child: SafeArea(
              child: Scaffold(
                  backgroundColor: theme.getTheme().scaffoldBackgroundColor,
                  body: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        /**App Bar*/
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //Welcome Text
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Welcome to",
                                      style: theme
                                          .getTheme()
                                          .textTheme
                                          .headline3
                                          .copyWith(fontSize: 18),
                                    ),
                                    Text(
                                      "Kurd Checker",
                                      style: theme
                                          .getTheme()
                                          .textTheme
                                          .headline4
                                          .copyWith(fontSize: 30),
                                    ),
                                  ],
                                ),

                                //Logo
                                Container(
                                  decoration: BoxDecoration(
                                      color: theme
                                          .getTheme()
                                          .backgroundColor
                                          .withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 20,
                                          color: theme.getTheme().shadowColor,
                                        )
                                      ]),
                                  child: Image.asset(
                                    'assets/logo.png',
                                    height: 65,
                                    width: 65,
                                  ),
                                ),
                              ]),
                        ),

                        /**Search Bar*/
                        Container(
                          margin: EdgeInsets.only(
                              bottom: 30, left: 20, right: 20, top: 15),
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 8, right: 8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: theme
                                .getTheme()
                                .highlightColor
                                .withOpacity(0.1),
                          ),
                          child: TextField(
                            maxLines: 1,
                            controller: usernameController,
                            scrollPhysics: BouncingScrollPhysics(),
                            textAlign: TextAlign.left,
                            cursorColor: theme.getTheme().primaryColor,
                            textDirection: TextDirection.ltr,
                            decoration: InputDecoration(
                              suffixIcon: Container(
                                  decoration: BoxDecoration(
                                    color: theme.getTheme().buttonColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: theme.getTheme().primaryColor,
                                          blurRadius: 5,
                                          offset: Offset(0, 2))
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  )),
                              border: InputBorder.none,
                              hintText: "Search friend",
                              hintStyle: TextStyle(color: Color(0xff9e9e9e)),
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              printDetails(usernameController.text); //get Data
                            },
                            child: Text("Tap Button")),
                        // /**Recently Searched */
                        // SingleChildScrollView(
                        //   scrollDirection: Axis.horizontal,
                        //   physics: BouncingScrollPhysics(),
                        //   child: Row(children: [
                        //     Material(
                        //         color: Colors.transparent,
                        //         shape: CircleBorder(
                        //             side: BorderSide(
                        //                 color:
                        //                     theme.getTheme().primaryColor)),
                        //         child: Padding(
                        //           padding: EdgeInsets.all(20),
                        //           child: Icon(
                        //             MaterialCommunityIcons.plus,
                        //           ),
                        //         ))
                        //   ]),
                        // ),

                        /**Users */
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                                child: Image.asset(
                                  profileImageLink,
                                ),
                              ),
                              ListTile(
                                tileColor: theme.getTheme().backgroundColor,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ViewProfileScreen(
                                                bio: bio,
                                                followers: followers,
                                                followings: followings,
                                                posts: posts,
                                                profileImagLink:
                                                    profileImageLink,
                                                username: username,
                                                website: website,
                                              )));
                                },
                                leading: CircleAvatar(
                                    backgroundImage:
                                        AssetImage(profileImageLink)),
                                trailing: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: theme.getTheme().buttonColor,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                theme.getTheme().primaryColor,
                                            blurRadius: 5,
                                            offset: Offset(0, 2))
                                      ],
                                    ),
                                    child: Transform.rotate(
                                      angle: 180 * math.pi / 180,
                                      child: Icon(
                                        Icons.arrow_back_ios_new_rounded,
                                        color: Colors.white,
                                      ),
                                    )),
                                title: Text(
                                  username,
                                  style: theme.getTheme().textTheme.headline4,
                                ),
                                subtitle: Text(
                                  "${bio.length > 30 ? bio.substring(0, 30) : bio}...",
                                  style: theme.getTheme().textTheme.headline3,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(20))),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )))),
    );
  }
}

/**
 body: Center(
            child: Row(
              children: [
                Container(
                  child: FlatButton(
                      onPressed: () => {
                            print(
                              'Set Light Theme',
                            ),
                            theme.setLightMode(),
                          },
                      child: Text(
                        'Set Light Theme',
                        style: theme.getTheme().textTheme.headline6,
                      )),
                ),
                Container(
                  child: FlatButton(
                    onPressed: () => {
                      print('Set Dark theme'),
                      theme.setDarkMode(),
                    },
                    child: Text(
                      'Set Dark theme',
                      style: theme.getTheme().textTheme.headline6,
                    ),
                  ),
                ),
              ],
            ),
          ),
 */
