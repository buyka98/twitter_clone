import 'package:bwitter/helper/enum.dart';
import 'package:bwitter/helper/utility.dart';
import 'package:bwitter/model/feed_model.dart';
import 'package:bwitter/state/feed_state.dart';
import 'package:bwitter/ui/theme/theme.dart';
import 'package:bwitter/widgets/custom_widgets.dart';
import 'package:bwitter/widgets/custom_widgets/title_text.dart';
import 'package:bwitter/widgets/tweet/tweet_image.dart';
import 'package:bwitter/widgets/tweet/unavailable_tweet.dart';
import 'package:bwitter/widgets/url_text/custom_url_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RetweetWidget extends StatelessWidget {
  const RetweetWidget({Key? key, required this.childRetwetkey, required this.type, this.isImageAvailable = false})
      : super(key: key);

  final String childRetwetkey;
  final bool isImageAvailable;
  final TweetType type;

  Widget _tweet(BuildContext context, FeedModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          width: MediaQuery.of(context).size.width - 12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              // SizedBox(
              //   width: 20,
              //   height: 20,
              //   child: CircularImage(path: model.user!.profilePic),
              // ),
              const SizedBox(width: 10),
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: 0, maxWidth: MediaQuery.of(context).size.width * .5),
                child: TitleText(
                  model.user!.displayName!,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 3),
              // model.user!.isVerified!
              //     ? customIcon(
              //         context,
              //         icon: AppIcon.blueTick,
              //         isTwitterIcon: true,
              //         iconColor: AppColor.primary,
              //         size: 13,
              //         paddingIcon: 3,
              //       )
              //     : const SizedBox(width: 0),
              SizedBox(
                width: model.user!.isVerified! ? 5 : 0,
              ),
              Flexible(
                child: customText(
                  '${model.user!.userName}',
                  style: TextStyles.userNameStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              customText(
                '· ${Utility.getChatTime(model.createdAt)}',
                style: TextStyles.userNameStyle.copyWith(fontSize: 12),
              ),
            ],
          ),
        ),
        model.description == null
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: UrlText(
                  // text: model.description!.takeOnly(150),
                  text: model.description!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  urlStyle: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w400),
                ),
              ),
        SizedBox(height: model.imagePath == null ? 8 : 0),
        TweetImage(model: model, type: type, isRetweetImage: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var feedstate = Provider.of<FeedState>(context, listen: false);
    return FutureBuilder(
      future: feedstate.fetchTweet(childRetwetkey),
      builder: (context, AsyncSnapshot<FeedModel?> snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: EdgeInsets.only(
                left: type == TweetType.Tweet || type == TweetType.ParentTweet ? 70 : 12,
                right: 16,
                top: isImageAvailable ? 8 : 5),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.extraLightGrey, width: .5),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            // todo
            // child: RippleButton(
            //   borderRadius: const BorderRadius.all(Radius.circular(15)),
            //   onPressed: () {
            //     feedstate.getPostDetailFromDatabase(null, model: snapshot.data!);
            //     Navigator.push(context, FeedPostDetail.getRoute(snapshot.data!.key!));
            //   },
            //   child: ClipRRect(
            //     borderRadius: const BorderRadius.all(Radius.circular(15)),
            //     child: _tweet(context, snapshot.data!),
            //   ),
            // ),
          );
        }
        if ((snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.waiting) &&
            !snapshot.hasData) {
          return UnavailableTweet(
            snapshot: snapshot,
            type: type,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
