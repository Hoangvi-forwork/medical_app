import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medical_app/model/news_model.dart';
import 'package:medical_app/repositories/news_repositories.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository;
  NewsBloc(this._newsRepository) : super(NewsLoadingState()) {
    on<NewsLoadEvent>((event, emit) async {
      emit(NewsLoadingState());
      print('Loading');
      try {
        print('wait loading');
        final news = await _newsRepository.fetchNews();
        print('wait loading: $news');
        emit(NewsLoadedState(news as dynamic));
        print(news);
      } catch (e) {
        emit(NewsErrorState(e.toString()));
      }
    });
  }
}
