

part of 'tv_search_bloc.dart';

abstract class TvSearchState extends Equatable{}

class TvSearchInitial extends TvSearchState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TvSearchLoading extends TvSearchState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class TvSearchEmpty extends TvSearchState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class TvSearchError extends TvSearchState{
  final String message;

  TvSearchError(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class TvSearchHasData extends TvSearchState{
  final List<Tv> result;

  TvSearchHasData(this.result);
  @override
  // TODO: implement props
  List<Object?> get props => [result];
}