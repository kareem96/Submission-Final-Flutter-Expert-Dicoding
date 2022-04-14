

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/text_style.dart';
import 'package:core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/pages/movies/movie_detail_page.dart';
import '../../domain/entities/movie.dart';

class CardList extends StatelessWidget {
  final Movie movie;
  const CardList(this.movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, MovieDetailPage.routeName, arguments: movie.id);
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(left: 16 + 80 + 16, bottom: 8, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title ?? '-', maxLines: 1, overflow: TextOverflow.ellipsis, style: Heading6,),
                    Text(movie.overview ?? '-', maxLines: 2, overflow: TextOverflow.ellipsis,),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left:16, bottom: 16),
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  width: 80,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error
                  ),
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
