import 'package:flutter_mvp_pattern/contracts/ContractLogin.dart';
import 'package:flutter_mvp_pattern/models/User.dart';

class PresenterLogin implements Presenter {
  View mView;
  User user;

  PresenterLogin(View v) {
    v.setPresenter(this);
    mView = v;
    user = User();
  }

  @override
  doLogin() {
    if (user.isLoginValid()) {
      onSuccess('payload from server', 'success');
    } else
      mView.showError('User credentials not valid, try again');
  }

  @override
  onError(String msg) {
    mView.showError(msg);
  }

  @override
  onSuccess(payload, String msg) {
    mView.showSuccess(msg);
    mView.gotoHomePage();
  }

  @override
  setEmail(String email) {
    user.email = email;
  }

  @override
  setPassword(String pwd) {
    user.password = pwd;
  }

  @override
  Future subscribe() {
  }

  @override
  Future unsubscribe() {
  }
}
