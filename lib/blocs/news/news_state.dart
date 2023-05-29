part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoadingState extends NewsState {
  @override
  List<Object> get props => [];
}

class NewsLoadedState extends NewsState {
  final List<NewsModel> newsList;
  const NewsLoadedState(this.newsList);

  @override
  List<Object> get props => [newsList];
}

class NewsErrorState extends NewsState {
  final String error;
  const NewsErrorState(this.error);
  @override
  List<Object> get props => [error];
}
