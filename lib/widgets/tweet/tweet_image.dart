import 'package:bwitter/helper/enum.dart';
import 'package:bwitter/model/feed_model.dart';
import 'package:bwitter/state/feed_state.dart';
import 'package:bwitter/widgets/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TweetImage extends StatelessWidget {
  const TweetImage({Key? key, required this.model, this.type, this.isRetweetImage = false}) : super(key: key);

  final FeedModel model;
  final TweetType? type;
  final bool isRetweetImage;
  @override
  Widget build(BuildContext context) {
    if (model.imagePath != null) assert(type != null);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      alignment: Alignment.centerRight,
      child: model.imagePath == null
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.only(top: 8),
              child: InkWell(
                borderRadius: BorderRadius.all(
                  Radius.circular(isRetweetImage ? 0 : 20),
                ),
                onTap: () {
                  if (type == TweetType.ParentTweet) {
                    return;
                  }
                  var state = Provider.of<FeedState>(context, listen: false);
                  state.getPostDetailFromDatabase(model.key);
                  state.setTweetToReply = model;
                  Navigator.pushNamed(context, '/ImageViewPge');
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(isRetweetImage ? 0 : 20),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * (type == TweetType.Detail ? .95 : .8) - 8,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: CacheImage(
                        path: model.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}