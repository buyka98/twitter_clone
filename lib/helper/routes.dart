// ignore_for_file: prefer_const_constructors

import 'package:bwitter/helper/custom_route.dart';
import 'package:bwitter/ui/page/auth/sign_in.dart';
import 'package:bwitter/ui/page/common/splash.dart';
import 'package:flutter/material.dart';
import 'package:bwitter/ui/page/auth/sign_up.dart';

class Routes {
  static dynamic route() {
    return {
      'SplashPage': (BuildContext context) => const SplashPage(),
    };
  }

  static void sendNavigationEventToFirebase(String? path) {
    if (path != null && path.isNotEmpty) {
      // analytics.setCurrentScreen(screenName: path);
    }
  }

  static Route? onGenerateRoute(RouteSettings settings) {
    final List<String> pathElements = settings.name!.split('/');
    if (pathElements[0] != '' || pathElements.length == 1) {
      return null;
    }
    switch (pathElements[1]) {
      // case "ComposeTweetPage":
      //   bool isRetweet = false;
      //   bool isTweet = false;
      //   if (pathElements.length == 3 && pathElements[2].contains('retweet')) {
      //     isRetweet = true;
      //   } else if (pathElements.length == 3 && pathElements[2].contains('tweet')) {
      //     isTweet = true;
      //   }
      //   return CustomRoute<bool>(
      //       builder: (BuildContext context) => ChangeNotifierProvider<ComposeTweetState>(
      //             create: (_) => ComposeTweetState(),
      //             child: ComposeTweetPage(isRetweet: isRetweet, isTweet: isTweet),
      //           ));
      // case "FeedPostDetail":
      //   var postId = pathElements[2];
      //   return SlideLeftRoute<bool>(
      //       builder: (BuildContext context) => FeedPostDetail(
      //             postId: postId,
      //           ),
      //       settings: const RouteSettings(name: 'FeedPostDetail'));
      case "SignUp":
        return CustomRoute<bool>(builder: (BuildContext context) => SignUp());
      case "SignIn":
        return CustomRoute<bool>(builder: (BuildContext context) => SignIn());
      default:
        return onUnknownRoute(const RouteSettings(name: '/Feature'));
    }
  }

  static Route onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          // title: customTitleText(
          //   settings.name!.split('/')[1],
          // ),
          centerTitle: true,
        ),
        body: Center(
          child: Text('${settings.name!.split('/')[1]} Comming soon..'),
        ),
      ),
    );
  }
}
