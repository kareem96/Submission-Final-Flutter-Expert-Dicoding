import 'package:core/utils/utils.dart';
import 'package:core/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/movie_watchlist/movie_watchlist_bloc.dart';

class WatchlistPage extends StatefulWidget {
  static const routeName = '/watchlist';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<MovieWatchListBloc>().add(OnFetchMovieWatchList()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Future.microtask(
        () => context.read<MovieWatchListBloc>().add(OnFetchMovieWatchList()));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<MovieWatchListBloc, MovieWatchListState>(
          builder: (context, state) {
        if (state is MovieWatchListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieWatchListHasData) {
          final data = state.result;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final movie = data[index];
              return CardList(movie);
            },
          );
        } else if (state is MovieWatchListEmpty) {
          return const Center(
            child: Text("Watchlist Empty"),
          );
        } else {
          return const Center(
            key: Key("error_message"),
            child: Text("Failed"),
          );
        }
      }),
    );
  }
}
