import 'package:core/widgets/card_tv_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_popular/tv_popular_bloc.dart';

class PopularTvPage extends StatefulWidget {
  static const routeName = '/popular_tv_page';

  const PopularTvPage({Key? key}) : super(key: key);

  @override
  State<PopularTvPage> createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => context.read<TvPopularBloc>().add(OnTvPopular()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tv Popular'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<TvPopularBloc, TvPopularState>(
            builder: (context, state) {
          if (state is TvPopularLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvPopularHasData) {
            final popular = state.result;
            return ListView.builder(
              itemCount: state.result.length,
              itemBuilder: (context, index) {
                final tvPopular = popular[index];
                return CardTvList(tvPopular);
              },
            );
          } else {
            return Center(
              key: const Key("error_message"),
              child: Text((state as TvPopularError).message),
            );
          }
        }),
      ),
    );
  }
}
