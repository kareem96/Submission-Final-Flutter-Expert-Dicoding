import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv/season.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';
import 'package:core/widgets/scrollable_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_recommendation/tv_recommendation_bloc.dart';
import 'package:tv/presentation/bloc/tv_watchlist/tv_watchlist_bloc.dart';

class TvDetailPage extends StatefulWidget {
  static const routeName = '/page_detail_tv';
  final int id;

  const TvDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvDetailBloc>().add(OnTvDetail(widget.id));
      context.read<TvRecommendationBloc>().add(OnTvRecommendation(widget.id));
      context.read<TvWatchListBloc>().add(TvWatchListStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTvShowAddedToWatchlist = context.select<TvWatchListBloc, bool>(
        (bloc) => (bloc.state is TvWatchListIsAdded)
            ? (bloc.state as TvWatchListIsAdded).isAdded
            : false);

    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<TvDetailBloc, TvDetailState>(
          builder: (context, state) {
            if (state is TvDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvDetailHasData) {
              final tv = state.result;
              return ContentDetails(
                  tvDetail: tv, isAddedWatchlistTv: isTvShowAddedToWatchlist);
            } else {
              return const Center(
                child: Text("Failed"),
              );
            }
          },
        ),
      ),
    );
  }
}

class ContentDetails extends StatefulWidget {
  final TvDetail tvDetail;
  bool isAddedWatchlistTv;

  ContentDetails({required this.tvDetail, required this.isAddedWatchlistTv});

  @override
  State<ContentDetails> createState() => _ContentDetailsState();
}

class _ContentDetailsState extends State<ContentDetails> {
  @override
  Widget build(BuildContext context) {
    return ScrollableSheet(
        background: "$BASE_IMAGE_URL${widget.tvDetail.posterPath}",
        scrollableContents: [
          Text(
            widget.tvDetail.name,
            style: Heading5,
          ),
          ElevatedButton(
            onPressed: () async {
              if (!widget.isAddedWatchlistTv) {
                context
                    .read<TvWatchListBloc>()
                    .add(TvWatchListAdd(widget.tvDetail));
              } else {
                context
                    .read<TvWatchListBloc>()
                    .add(TvWatchListRemove(widget.tvDetail));
              }

              final state = BlocProvider.of<TvWatchListBloc>(context).state;
              String message = "";

              if (state is TvWatchListIsAdded) {
                final isAdded = state.isAdded;
                message = isAdded == false ? notifAdd : notifRemove;
              } else {
                message =
                    !widget.isAddedWatchlistTv ? notifAdd : notifRemove;
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
                widget.isAddedWatchlistTv = !widget.isAddedWatchlistTv;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.isAddedWatchlistTv
                    ? const Icon(Icons.check)
                    : const Icon(Icons.add),
                const SizedBox(width: 6.0),
                const Text('Watchlist'),
                const SizedBox(width: 4.0),
              ],
            ),
          ),
          Text(_showGenres(widget.tvDetail.genres)),
          Row(
            children: [
              RatingBarIndicator(
                rating: widget.tvDetail.voteAverage / 2,
                itemCount: 5,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: kYellow,
                ),
                itemSize: 24,
              ),
              Text("${widget.tvDetail.voteAverage}")
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "Overview",
            style: Heading6,
          ),
          Text(widget.tvDetail.overview.isNotEmpty
              ? widget.tvDetail.overview
              : "-"),
          const SizedBox(
            height: 12,
          ),
          Text(
            "Season",
            style: Heading6,
          ),
          widget.tvDetail.seasons.isNotEmpty
              ? Container(
                  height: 150,
                  margin: const EdgeInsets.only(top: 8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      final season = widget.tvDetail.seasons[index];

                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          child: Stack(
                            children: [
                              season.posterPath == null
                                  ? Container(
                                      width: 96.0,
                                      decoration: const BoxDecoration(
                                        color: kGrey,
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'No Image',
                                          style: TextStyle(color: kRichBlack),
                                        ),
                                      ),
                                    )
                                  : CachedNetworkImage(
                                      imageUrl:
                                          '$BASE_IMAGE_URL${season.posterPath}',
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                              Positioned.fill(
                                child: Container(
                                  color: kRichBlack.withOpacity(0.65),
                                ),
                              ),
                              Positioned(
                                left: 8.0,
                                top: 4.0,
                                child: Text(
                                  (index + 1).toString(),
                                  style: Heading5.copyWith(fontSize: 26.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: widget.tvDetail.seasons.length,
                  ),
                )
              : const Text("-"),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Recommendation",
            style: Heading6,
          ),
          BlocBuilder<TvRecommendationBloc, TvRecommendationState>(
            builder: (context, state) {
              if (state is TvRecommendationLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvRecommendationHasData) {
                final tvShowRecommendations = state.result;

                return Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final tvShowRecoms = tvShowRecommendations[index];
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              TvDetailPage.routeName,
                              arguments: tvShowRecoms.id,
                            );
                          },
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  '$BASE_IMAGE_URL${tvShowRecoms.posterPath}',
                              placeholder: (context, url) => const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 12.0),
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
                    itemCount: tvShowRecommendations.length,
                  ),
                );
              } else {
                return const Text('No recommendations found');
              }
            },
          )
        ]);
  }

  Widget _buildSeason(BuildContext context, List<Season> season) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: season.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Text(season[index].name)],
                    ),
                  ),
                );
              }),
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
}
