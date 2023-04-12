import 'package:bwitter/ui/page/feed/feed_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Container(
        // child: _getPage(Provider.of<AppState>(context).pageIndex),
        child: _getPage(0),
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return FeedPage(
          scaffoldKey: _scaffoldKey,
          refreshIndicatorKey: refreshIndicatorKey,
        );
      // case 1:
      //   return SearchPage(scaffoldKey: _scaffoldKey);
      // case 2:
      //   return NotificationPage(scaffoldKey: _scaffoldKey);
      // case 3:
      //   return ChatListPage(scaffoldKey: _scaffoldKey);
      default:
        return FeedPage(scaffoldKey: _scaffoldKey);
    }
  }
}
