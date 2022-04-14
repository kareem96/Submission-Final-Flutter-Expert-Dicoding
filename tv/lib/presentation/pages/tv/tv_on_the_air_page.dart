import 'package:core/widgets/card_tv_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_on_the_air/tv_on_the_air_bloc.dart';

class TvOnTheAirPage extends StatefulWidget {
  static const routeName = '/tv_on_the_air_page';

  const TvOnTheAirPage({Key? key}) : super(key: key);

  @override
  _TvOnTheAirPageState createState() => _TvOnTheAirPageState();
}

class _TvOnTheAirPageState extends State<TvOnTheAirPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => context.read<TvOnTheAirBloc>().add(OnTvOnTheAir()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TV On The Air'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocBuilder<TvOnTheAirBloc, TvOnTheAirState>(
              builder: (context, state) {
            if (state is TvOnTheAirLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvOnTheAirHasData) {
              final data = state.result;
              return ListView.builder(
                  itemCount: state.result.length,
                  itemBuilder: (context, index) {
                    final onTheAir = data[index];
                    return CardTvList(onTheAir);
                  });
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text((state as TvOnTheAirError).message),
              );
            }
          }),
        ));
  }
}
