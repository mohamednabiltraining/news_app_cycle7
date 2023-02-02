import 'package:news_app/Core/api/api_manager.dart';
import 'package:news_app/Core/model/Source.dart';
import 'package:news_app/View/category/navigator.dart';
import 'package:news_app/base/base_viewModel.dart';

class CategoryNewsListViewModel
    extends BaseViewModel<CategoryNewsListNavigator> {
  List<Source>? sources = null;
  String? errorMessage = null;

  void loadNewsSources(String categoryId) async {
    // navigator?.showProgressDialog('loading...');
    // reinitialize to return loading state
    errorMessage = null;
    sources = null;
    notifyListeners();
    try {
      var response = await ApiManager.getSources(categoryId);
      if (response.status == 'error') {
        errorMessage = response.message;
      } else {
        sources = response.sources;
      }
    } catch (e) {
      errorMessage = 'error getting news sources';
    }
    notifyListeners();
  }
}
