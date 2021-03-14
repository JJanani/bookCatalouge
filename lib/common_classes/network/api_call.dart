import 'package:book_catalog/common_classes/view_state.dart';
import 'package:book_catalog/common_classes/network/app_exception.dart';
class ApiCall<T>{
  bool _isSuccess=false;
  ViewState _state=ViewState.IDLE;
  T _data;
  AppException _errorMessage;

  bool get isSuccess => _isSuccess;

  set isSuccess(bool value) => _isSuccess=value;

  ViewState get state => _state;

  set state(ViewState value) => _state=value;

  T get data => _data;

  set data(T value) => _data = value;

  AppException get errorMessage => _errorMessage;

  set errorMessage(AppException value) => _errorMessage=value;

}