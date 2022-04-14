
import 'package:core/data/model/movie_table.dart';
import 'package:core/data/model/tv/tv_model.dart';
import 'package:core/data/model/tv/tv_response.dart';
import 'package:core/data/model/tv/tv_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
  'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
  originalLanguage: '',
  popularity: 0,
  video: true,
  status: '',
  homepage: '',
  revenue: 0,
  tagline: '',
  budget: 0,
);

final testWatchlistMovie = Movie.wathclist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTVShowModel = TvModel(
  backdropPath: "/oC9SgtJTDCEpWnTBtVGoAvjl5hb.jpg",
  genreIds: [10767],
  id: 1991,
  name: "Rachael Ray",
  originCountry: ["US"],
  originalLanguage: "en",
  originalName: "Rachael Ray",
  overview:
  "Rachael Ray, also known as The Rachael Ray Show, is an American talk show starring Rachael Ray that debuted in syndication in the United States and Canada on September 18, 2006. It is filmed at Chelsea Television Studios in New York City. The show's 8th season premiered on September 9, 2013, and became the last Harpo show in syndication to switch to HD with a revamped studio. In January 2012, CBS Television Distribution announced a two-year renewal for the show, taking it through the 2013–14 season.",
  popularity: 1765.863,
  posterPath: "/dsAJhCLYX1fiNRoiiJqR6Up4aJ.jpg",
  voteAverage: 5.8,
  voteCount: 29,
);

final testTVShowModelList = <TvModel>[testTVShowModel];

final testTVShow = testTVShowModel.toEntity();

final testTVShowList = <Tv>[testTVShow];

final testTVShowResponse = TvResponse(tvList: testTVShowModelList);

final testTVShowDetailResponse = TvModel(
  backdropPath: '',
  id: 2,
  name: 'name',
  originalLanguage: 'en',
  originalName: 'name',
  overview: 'overview',
  popularity: 12.323,
  posterPath: '',
  voteAverage: 3,
  voteCount: 3,
  genreIds: [],
  originCountry: [],
);

final testTVShowDetail = testTVShowDetailResponse.toEntity();

/*final testTVShowTable = TvTable.fromEntity(testTVShowDetail);*/

/*final testTVShowTableList = <TvTable>[testTVShowTable];*/

/*final testWatchlistTVShow = [testTVShowTable.toEntity()];*/

final testTVShowMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};