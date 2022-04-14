import 'package:core/widgets/card_tv_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_airing_today/tv_airing_today_bloc.dart';

class AiringTodayPage extends StatefulWidget {
  static const routeName = '/airing_today_page';

  const AiringTodayPage({Key? key}) : super(key: key);

  @override
  State<AiringTodayPage> createState() => _AiringTodayPageState();
}

class _AiringTodayPageState extends State<AiringTodayPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
        () => context.read<TvAiringTodayBloc>().add(OnTvAiringToday()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tv Airing Today'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<TvAiringTodayBloc, TvAiringTodayState>(
            builder: (context, state) {
          if (state is TvAiringTodayLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvAiringTodayHasData) {
            return ListView.builder(
                itemCount: state.result.length,
                itemBuilder: (context, index) {
                  final airingToday = state.result[index];
                  return CardTvList(airingToday);
                });
          } else {
            return Center(
              key: const Key("error_message"),
              child: Text((state as TvAiringTodayError).message),
            );
          }
        }),
      ),
    );
  }
}
