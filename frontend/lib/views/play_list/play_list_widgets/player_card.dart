import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../widgets/pretendard_text.dart';

class PlayerCardWidget extends StatefulWidget {
  const PlayerCardWidget({Key? key, required this.youtubeId}) : super(key: key);

  final String youtubeId;

  @override
  State<PlayerCardWidget> createState() => _PlayerCardWidgetState();
}

class _PlayerCardWidgetState extends State<PlayerCardWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        launchUrl(
          Uri.parse(
            "https://www.youtube.com/watch?v=${widget.youtubeId}",
          ),
          mode: LaunchMode.externalApplication,
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          right: 15,
          bottom: 15,
          left: 15,
        ),
        decoration: BoxDecoration(
          color: Color(0xFF7DFB4F),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: YoutubePlayer.getThumbnail(
                quality: ThumbnailQuality.max,
                videoId: widget.youtubeId,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                top: 7,
                bottom: 7,
              ),
              child: PText(
                "[페이스캠] IVE WONYOUNG - LOVE DIVE",
                color: Colors.black,
                size: 18,
                weight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
