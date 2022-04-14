import 'package:core/styles/text_style.dart';
import 'package:core/widgets/card_tv_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/tv_bloc_search/tv_search_bloc.dart';

class SearchTvPage extends StatefulWidget {
  static const routeName = '/search_tv';

  const SearchTvPage({Key? key}) : super(key: key);

  @override
  State<SearchTvPage> createState() => _SearchTvPageState();
}

class _SearchTvPageState extends State<SearchTvPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search TV"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<TvSearchBloc>().add(OnQueryTvChange(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search TV',
                prefixIcon: Icon(Icons.search_outlined),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Search Result',
              style: Heading6,
            ),
            BlocBuilder<TvSearchBloc, TvSearchState>(builder: (context, state) {
              if (state is TvSearchLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvSearchHasData) {
                final result = state.result;
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final movie = result[index];
                      return CardTvList(movie);
                    },
                    itemCount: result.length,
                  ),
                );
              } else if (state is TvSearchError) {
                return Expanded(
                  child: Center(
                    child: Text(state.message),
                  ),
                );
              } else {
                return Expanded(child: Container());
              }
            })
          ],
        ),
      ),
    );
  }
}
