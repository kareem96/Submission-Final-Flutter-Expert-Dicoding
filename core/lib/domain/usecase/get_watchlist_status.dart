

import '../repositories/movie_respository.dart';

class GetWatchListStatus{
  final MovieRepository repository;

  GetWatchListStatus(this.repository);

  Future<bool> execute(int id)async{
    return repository.isAddedToWatchlist(id);
  }
}