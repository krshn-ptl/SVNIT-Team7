import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryService {
  static const _LIMIT = 20;
  static const SEARCH_HISTORY = "searchHistory";
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> clearSearchHistory() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setStringList(SEARCH_HISTORY, []);
  }

  Future<List<String>> getSearchHistory() async {
    final SharedPreferences prefs = await _prefs;
    final searchHistroy = prefs.getStringList(SEARCH_HISTORY);
    return searchHistroy ?? [];
  }

  Future<void> setSearchHistory(String text) async {
    final SharedPreferences prefs = await _prefs;
    List<String>? searchHistory = prefs.getStringList(SEARCH_HISTORY);
    // ignore: unnecessary_null_comparison
    if (searchHistory == null) {
      searchHistory = [];
      searchHistory.insert(0, text);
    } else {
      final pos = searchHistory.indexOf(text);
      if (pos != 0) {
        if (pos != -1) {
          searchHistory.removeAt(pos);
        }
        searchHistory.insert(0, text);
        if (_LIMIT != -1 && searchHistory.length > _LIMIT)
          searchHistory.removeLast();
      }
    }
    prefs.setStringList(SEARCH_HISTORY, searchHistory);
  }
}
