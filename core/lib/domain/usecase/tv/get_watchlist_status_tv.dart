


import '../../repositories/tv_repository.dart';

class GetWatchlistStatusTv{
  final TvRepository repository;
  GetWatchlistStatusTv(this.repository);
  Future<bool> execute(int id)async{
    return repository.isAddedToWatchlistTv(id);
  }
}