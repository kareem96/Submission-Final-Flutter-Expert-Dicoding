import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_style.dart';
import 'package:core/utils/constant.dart';
import 'package:core/widgets/scrollable_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/presentation/bloc/detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import '../../bloc/movie_watchlist/movie_watchlist_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  static const routeName = '/detail';
  final int id;

  const MovieDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieDetailBloc>().add(OnMovieDetail(widget.id));
      context
          .read<MovieRecommendationBloc>()
          .add(OnMovieRecommendation(widget.id));
      context.read<MovieWatchListBloc>().add(MovieWatchListStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMovieAddedToWatchList =
        context.select<MovieWatchListBloc, bool>((bloc) {
      if (bloc.state is MovieWatchListIsAdded) {
        return (bloc.state as MovieWatchListIsAdded).isAdded;
      }
      return false;
    });
    return SafeArea(
      child: Scaffold(body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailHasData) {
            final movie = state.result;
            return ContentDetails(
                movie: movie, isAddedWatchlist: isMovieAddedToWatchList);
          } else {
            return const Center(
              child: Text("Failed"),
            );
          }
        },
      )),
    );
  }
}

class ContentDetails extends StatefulWidget {
  final MovieDetail movie;
  bool isAddedWatchlist;

  ContentDetails({
    Key? key,
    required this.movie,
    required this.isAddedWatchlist,
  }) : super(key: key);

  @override
  State<ContentDetails> createState() => _ContentDetailsState();
}

class _ContentDetailsState extends State<ContentDetails> {
  @override
  Widget build(BuildContext context) {
    return ScrollableSheet(
      background: '$BASE_IMAGE_URL${widget.movie.posterPath}',
      scrollableContents: [
        Text(
          widget.movie.title,
          style: Heading5,
        ),
        ElevatedButton(
            onPressed: () async {
              if (!widget.isAddedWatchlist) {
                context
                    .read<MovieWatchListBloc>()
                    .add(MovieWatchListAdd(widget.movie));
              } else {
                context
                    .read<MovieWatchListBloc>()
                    .add(MovieWatchListRemove(widget.movie));
              }
              final state = BlocProvider.of<MovieWatchListBloc>(context).state;
              String message = "";

              if (state is MovieWatchListIsAdded) {
                final isAdded = state.isAdded;
                message = isAdded == false ? notifAdd : notifRemove;
              } else {
                message = !widget.isAddedWatchlist ? notifAdd : notifRemove;
              }
              if (message == notifAdd || message == notifRemove) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message)));
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(message),
                      );
                    });
              }
              setState(() {
                widget.isAddedWatchlist = !widget.isAddedWatchlist;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.isAddedWatchlist
                    ? const Icon(Icons.check)
                    : const Icon(Icons.add),
                const SizedBox(
                  width: 6,
                ),
                const Text("Watchlist"),
                const SizedBox(
                  width: 6,
                ),
              ],
            )),
        Text(_showGenres(widget.movie.genres)),
        Text(_showDuration(widget.movie.runtime!)),
        Row(
          children: [
            RatingBarIndicator(
              rating: widget.movie.voteAverage / 2,
              itemCount: 5,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: kYellow,
              ),
              itemSize: 24,
            ),
            Text("${widget.movie.voteAverage}")
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Overview',
          style: Heading6,
        ),
        Text(widget.movie.overview.isNotEmpty ? widget.movie.overview : "-"),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Recommendations',
          style: Heading6,
        ),
        BlocBuilder<MovieRecommendationBloc, MovieRecommendationState>(
            builder: (context, state) {
          if (state is MovieRecommendationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieRecommendationHasData) {
            final movieRecommendation = state.result;
            print("berhasil");
            return Container(
              margin: const EdgeInsets.only(top: 8),
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final recommendation = movieRecommendation[index];
                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, MovieDetailPage.routeName,
                            arguments: recommendation.id);
                      },
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: CachedNetworkImage(
                          imageUrl:
                              "$BASE_IMAGE_URL${recommendation.posterPath}",
                          placeholder: (context, url) => const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: movieRecommendation.length,
              ),
            );
          } else if (state is MovieRecommendationEmpty) {
            return const Text("-");
          } else {
            return const Text("Failed");
          }
        }),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }
    if (result.isEmpty) {
      return result;
    }
    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
