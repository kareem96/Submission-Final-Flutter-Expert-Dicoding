import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/text_style.dart';
import 'package:core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:tv/presentation/pages/tv/tv_detail_page.dart';
import '../../domain/entities/tv/tv.dart';

class CardTvList extends StatelessWidget {
  final Tv tv;

  const CardTvList(this.tv, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, TvDetailPage.routeName,
              arguments: tv.id);
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                    left: 16 + 80 + 16, bottom: 8, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tv.name ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Heading6,
                    ),
                    Text(
                      tv.overview ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, bottom: 16),
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  width: 80,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
