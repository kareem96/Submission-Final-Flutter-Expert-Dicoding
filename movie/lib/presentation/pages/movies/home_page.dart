import 'package:about/about_page.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/styles/text_style.dart';
import 'package:core/utils/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/widgets/tab_pager.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/now_playing/movie_now_playing_bloc.dart';
import 'package:movie/presentation/bloc/popular/movie_popular_bloc.dart';
import 'package:movie/presentation/pages/movies/popular_movies_page.dart';
import 'package:movie/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:search/presentation/page/search/search_page.dart';
import 'package:tv/presentation/pages/tv/tv_page.dart';
import '../../bloc/top_rated/movie_top_rated_bloc.dart';
import 'movie_detail_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/movie_home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<MovieNowPlayingBloc>().add(OnMovieNowPLayingCalled());
      context.read<MovieTopRatedBloc>().add(OnMovieTopRated());
      context.read<MoviePopularBloc>().add(OnMoviePopular());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/ui.png'),
                ),
                accountName: Text('Nonton Kuy'),
                accountEmail: Text('')),
            ListTile(
              leading: const Icon(Icons.movie_outlined),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv_outlined),
              title: const Text('TV'),
              onTap: () {
                Navigator.pushNamed(context, TvPage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt_outlined),
              title: const Text('Watchlist'),
              onTap: () {
                // Navigator.pushNamed(context, WatchlistPage.routeName);
                Navigator.pushNamed(context, TabPager.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outlined),
              title: const Text('About'),
              onTap: () {
                Navigator.pushNamed(context, AboutPage.routeName);
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Nonton Kuy'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SearchPage.routeName);
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: Heading6,
              ),
              BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
                  builder: (context, state) {
                if (state is MovieNowPlayingLoading) {
                  return const CircularProgressIndicator();
                } else if (state is MovieNowPlayingHasData) {
                  final data = state.result;
                  return MovieList(data);
                } else if (state is MovieNowPlayingError) {
                  return const Text("Failed");
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                  title: 'Popular',
                  onTap: () {
                    Navigator.pushNamed(context, PopularMoviesPage.routeName);
                  }),
              BlocBuilder<MoviePopularBloc, MoviePopularState>(
                  builder: (context, state) {
                if (state is MoviePopularLoading) {
                  return const CircularProgressIndicator();
                } else if (state is MoviePopularHasData) {
                  final data = state.result;
                  return MovieList(data);
                } else if (state is MoviePopularError) {
                  return const Text("Failed");
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                  title: 'Top Rated',
                  onTap: () {
                    Navigator.pushNamed(context, TopRatedMoviesPage.routeName);
                  }),
              BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
                  builder: (context, state) {
                if (state is MovieTopRatedLoading) {
                  return const CircularProgressIndicator();
                } else if (state is MovieTopRatedHasData) {
                  final data = state.result;
                  return MovieList(data);
                } else if (state is MovieTopRatedError) {
                  return const Text("Failed");
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Heading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: const [Text('See more'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        )
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                debugPrint('${movie.id}');
                Navigator.pushNamed(context, MovieDetailPage.routeName,
                    arguments: movie.id);
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
