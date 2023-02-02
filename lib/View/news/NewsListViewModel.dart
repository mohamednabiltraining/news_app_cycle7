import 'package:news_app/Core/api/api_manager.dart';
import 'package:news_app/Core/model/News.dart';
import 'package:news_app/View/news/Navigator.dart';
import 'package:news_app/base/base_viewModel.dart';

class NewsListViewModel extends BaseViewModel<NewsListNavigator> {
  String? errorMessage;
  List<News>? newsList;

  void getNewsBySourceId(String sourceId) async {
    errorMessage = null;
    newsList = null;
    notifyListeners();
    try {
      var response = await ApiManager.getNews(sourceId);
      if (response.status == 'error') {
        errorMessage = response.message;
      } else {
        newsList = response.newsList;
      }
    } catch (e) {
      errorMessage = "error loading news";
    }
    notifyListeners();
  }
}
