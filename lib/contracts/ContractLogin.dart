import 'package:flutter_mvp_pattern/contracts/BasePresenter.dart';
import 'package:flutter_mvp_pattern/contracts/BaseView.dart';

abstract class View extends BaseView {
  showError(var msg); 
  showSuccess(var msg); 
  gotoHomePage();
}

abstract class Presenter extends BasePresenter {
  setEmail(String email); 
  setPassword(String pwd);
  doLogin();
}
