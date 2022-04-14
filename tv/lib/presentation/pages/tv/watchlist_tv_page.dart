import 'package:core/utils/utils.dart';
import 'package:core/widgets/card_tv_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/tv_watchlist/tv_watchlist_bloc.dart';

class WatchlistTvPage extends StatefulWidget {
  static const routeName = '/watchlist_tv_page';

  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  State<WatchlistTvPage> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
        () => context.read<TvWatchListBloc>().add(OnFetchTvWatchList()));
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<TvWatchListBloc>().add(OnFetchTvWatchList());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    routeObserver.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<TvWatchListBloc, TvWatchListState>(
          builder: (context, state) {
        if (state is TvWatchListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TvWatchListHasData) {
          final data = state.result;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final tv = data[index];
              return CardTvList(tv);
            },
          );
        } else if (state is TvWatchListEmpty) {
          return Center(
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
