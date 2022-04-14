
import 'package:core/data/model/tv/tv_model.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  final tvModel = TvModel(
    backdropPath: "backdropPath",
    genreIds: [18],
    id: 11250,
    name: "Name",
    originCountry: ["CO"],
    originalLanguage: "es",
    originalName: "originalName",
    overview: "Toverview",
    popularity: 1.0,
    posterPath: "posterPath",
    voteAverage: 1.0,
    voteCount: 1
);
  final tv = Tv(
      backdropPath: "backdropPath",
      genreIds: [18],
      id: 11250,
      name: "Name",
      originCountry: ["CO"],
      originalLanguage: "es",
      originalName: "originalName",
      overview: "Toverview",
      popularity: 1.0,
      posterPath: "posterPath",
      voteAverage: 1.0,
      voteCount: 1
  );


  test('should be a subclass of tv entity', () async {
    final result = tvModel.toEntity();
    expect(result, tv);
  });
}