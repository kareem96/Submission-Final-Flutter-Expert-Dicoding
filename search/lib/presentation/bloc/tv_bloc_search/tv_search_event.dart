

part of 'tv_search_bloc.dart';

abstract class TvSearchEvent extends Equatable{}

class OnQueryTvChange extends TvSearchEvent{
  final String query;

  OnQueryTvChange(this.query);
  @override
  // TODO: implement props
  List<Object?> get props => [query];

}