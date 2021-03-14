import 'package:book_catalog/Constants/Strings.dart';
import 'package:book_catalog/common_classes/base_viewmodel.dart';
import 'package:book_catalog/common_classes/locator.dart';
import 'package:book_catalog/common_classes/network/api_call.dart';
import 'package:book_catalog/common_classes/view_state.dart';
import 'package:book_catalog/common_widgets/common_dialog.dart';
import 'package:book_catalog/model/books_server_response.dart';
import 'package:book_catalog/repository/selected_category_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectedCategoryBookViewModel extends BaseViewModel {
  ApiCall<BooksServerResponse> _apiCall = ApiCall();
  ApiCall<BooksServerResponse> get apiCall => _apiCall;
  SelectedCategoryRepository _selectedCategoryRepository = locator<SelectedCategoryRepository>();
  BuildContext buildContext;
  int _pageNumber = 1;
  bool _isNextPageAvailable = false;
  bool isLoading = false;

  void _getBooks(String topic, String searchTerm, int page, BuildContext context) async {
    this.buildContext = context;
    setState(apiCall, ViewState.BUSY);
    try {
      BooksServerResponse response = await _selectedCategoryRepository.getRequestedBooks(topic, searchTerm, page);
      _isNextPageAvailable = response.next != null;
      if (page == 1)
        setSuccessResponse(_apiCall, response);
      else
        addMoreData(apiCall, response);
    } catch (e) {
      setErrorResponse(_apiCall, e);
    }
  }

  void getFirstPage(String topic, String searchTerm, BuildContext context) {
    _getBooks(topic, searchTerm, 1, context);
  }

  void getNextPage(String topic, String searchTerm, BuildContext context) {
    if (_isNextPageAvailable)
      _getBooks(topic, searchTerm, ++_pageNumber, context);
    else{
      isLoading = false;
      setState(apiCall, ViewState.IDLE);
    }
  }

  void openBookLinkInBrowser(BuildContext context,Formats format) async {
    if (format.textHtmlCharsetIso88591 != null &&
        !format.textHtmlCharsetIso88591.endsWith('zip')) {
      _launchUrl(format.textHtmlCharsetIso88591);
    } else if (format.textHtml != null && !format.textHtml.endsWith('zip')) {
      _launchUrl(format.textHtml);
    } else if (format.textHtmlCharsetUsAscii != null &&
        !format.textHtmlCharsetUsAscii.endsWith('zip')) {
      _launchUrl(format.textHtmlCharsetUsAscii);
    } else if (format.textHtmlCharsetUtf8 != null &&
        !format.textHtmlCharsetUtf8.endsWith('zip')) {
      _launchUrl(format.textHtmlCharsetUtf8);
    } else if (format.applicationPdf != null) {
      _launchUrl(format.applicationPdf);
    } else if (format.textPlain != null) {
      _launchUrl(format.textPlain);
    } else if (format.textPlainCharsetUsAscii != null) {
      _launchUrl(format.textPlainCharsetUsAscii);
    } else if (format.textPlainCharsetUtf8 != null) {
      _launchUrl(format.textPlainCharsetUtf8);
    } else if (format.textPlainCharsetIso88591 != null) {
      _launchUrl(format.textPlainCharsetIso88591);
    } else {
      CommonDialog.showDialogWithOkButton(context , Strings.ERROR,Strings.UNAVAILABLE_VIEWABLE_VERSION, dismissDialog);
    }
  }

  void dismissDialog(){
    Navigator.pop(buildContext);
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("can not open");
    }
  }

  void addMoreData(ApiCall<BooksServerResponse> apiCall, BooksServerResponse data) {
    apiCall.isSuccess = true;
    apiCall.data.next = data.next;
    apiCall.data.results.addAll(data.results);
    apiCall.state = ViewState.IDLE;
    notifyListeners();
  }

}
