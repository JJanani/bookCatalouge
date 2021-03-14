import 'package:book_catalog/common_classes/network/api_call.dart';
import 'package:book_catalog/common_classes/network/app_exception.dart';
import 'package:book_catalog/common_classes/view_state.dart';
import 'package:flutter/cupertino.dart';

class BaseViewModel extends ChangeNotifier{
  void setSuccessResponse<T> (ApiCall<T> apiCall,T data){
    apiCall.isSuccess=true;
    apiCall.data=data;
    apiCall.state=ViewState.IDLE;
    notifyListeners();
  }

  void setErrorResponse<T> (ApiCall<T> apiCall,AppException data){
    apiCall.isSuccess=false;
    apiCall.errorMessage=data;
    apiCall.state=ViewState.IDLE;
    notifyListeners();
  }

  void setState(ApiCall apiCall,ViewState state){
    apiCall.state=state;
    notifyListeners();
  }

}