import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetTvOnTheAir {
  final TvRepository repository;

  GetTvOnTheAir(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTvOnTheAir();
  }
}
