import 'package:bwitter/ui/theme/theme.dart';
import 'package:bwitter/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<RefreshIndicatorState>? refreshIndicatorKey;
  const FeedPage({Key? key, required this.scaffoldKey, this.refreshIndicatorKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingActionButton(context),
      backgroundColor: TwitterColor.mystic,
      body: SafeArea(
        child: SizedBox(
          // height: context.size!.height,
          // width: context.width,
          child: RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: () async {
              /// refresh home page feed
              // var feedState = Provider.of<FeedState>(context, listen: false);
              // feedState.getDataFromDatabase();
              // return Future.value(true);
            },
            child: _FeedPageBody(
              refreshIndicatorKey: refreshIndicatorKey,
              scaffoldKey: scaffoldKey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/CreateFeedPage/tweet');
      },
      child: customIcon(
        context,
        // icon: AppIcon.fabTweet,
        icon: Icons.favorite_border,
        isTwitterIcon: true,
        iconColor: Theme.of(context).colorScheme.onPrimary,
        size: 25,
      ),
    );
  }
}

class _FeedPageBody extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  final GlobalKey<RefreshIndicatorState>? refreshIndicatorKey;

  const _FeedPageBody({Key? key, required this.scaffoldKey, this.refreshIndicatorKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var authState = Provider.of<AuthState>(context, listen: false);
    return SizedBox();
    // return Consumer<FeedState>(
    //   builder: (context, state, child) {
    //     final List<FeedModel>? list = state.getTweetList(authState.userModel);
    //     return CustomScrollView(
    //       slivers: <Widget>[
    //         child!,
    //         state.isBusy && list == null
    //             ? SliverToBoxAdapter(
    //                 child: SizedBox(
    //                   height: context.height - 135,
    //                   child: CustomScreenLoader(
    //                     height: double.infinity,
    //                     width: context.width,
    //                     backgroundColor: Colors.white,
    //                   ),
    //                 ),
    //               )
    //             : !state.isBusy && list == null
    //                 ? const SliverToBoxAdapter(
    //                     child: EmptyList(
    //                       'No Tweet added yet',
    //                       subTitle: 'When new Tweet added, they\'ll show up here \n Tap tweet button to add new',
    //                     ),
    //                   )
    //                 : SliverList(
    //                     delegate: SliverChildListDelegate(
    //                       list!.map(
    //                         (model) {
    //                           return Container(
    //                             color: Colors.white,
    //                             child: Tweet(
    //                               model: model,
    //                               trailing: TweetBottomSheet()
    //                                   .tweetOptionIcon(context, model: model, type: TweetType.Tweet, scaffoldKey: scaffoldKey),
    //                               scaffoldKey: scaffoldKey,
    //                             ),
    //                           );
    //                         },
    //                       ).toList(),
    //                     ),
    //                   )
    //       ],
    //     );
    //   },
    //   child: SliverAppBar(
    //     floating: true,
    //     elevation: 0,
    //     leading: Builder(
    //       builder: (BuildContext context) {
    //         return IconButton(
    //           icon: const Icon(Icons.menu),
    //           onPressed: () {
    //             scaffoldKey.currentState!.openDrawer();
    //           },
    //         );
    //       },
    //     ),
    //     title: Image.asset('assets/images/icon-480.png', height: 40),
    //     centerTitle: true,
    //     iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
    //     backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    //     bottom: PreferredSize(
    //       child: Container(
    //         color: Colors.grey.shade200,
    //         height: 1.0,
    //       ),
    //       preferredSize: const Size.fromHeight(0.0),
    //     ),
    //   ),
    // );
  }
}
