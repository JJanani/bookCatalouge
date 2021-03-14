import 'package:book_catalog/common_classes/api_constants.dart';
import 'package:book_catalog/common_classes/base_repository.dart';
import 'package:book_catalog/common_classes/network/app_exception.dart';
import 'package:book_catalog/common_classes/network/http.dart';
import 'package:book_catalog/model/books_server_response.dart';

class SelectedCategoryRepository extends BaseRepository {
  Future<BooksServerResponse> _getBooksByCategory(String query) async {
    try {
      String path = ApiConstants.BOOKS_ENDPOINT + query;
      var response = await httpClient().get(path);
      if (response.statusCode == 200) {
        return BooksServerResponse.fromJson(response.data);
      } else {
        throw AppException(
          errorCode: response.statusCode,
          errorMessage: response.data,
        );
      }
    } catch (e) {
      return null;
    }
  }

  Future<BooksServerResponse> getRequestedBooks(String topic, String search, int page) async {
    String query = "?mime_type=image&";
    if(page != null){
      query = query + "page=$page&";
    }
    if (topic != null) {
      query = query + "topic=$topic&";
    }
    if (search != null) {
      query = query + "search=$search&";
    }
    return await _getBooksByCategory(query);
  }
}
