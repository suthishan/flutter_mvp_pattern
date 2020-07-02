import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp_pattern/contracts/ContractLogin.dart';
import 'package:flutter_mvp_pattern/presenters/PresenterLogin.dart';
import 'package:flutter_mvp_pattern/views/HomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements View {
  TextEditingController cntrlEmail = TextEditingController();
  TextEditingController cntrlPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var msg;
  Presenter presenter;

  @override
  void initState() {
    super.initState();
    PresenterLogin(this);
    presenter.subscribe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            backgroundImageWidget(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Image.asset('assets/img/logo.png', height: 120),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  loginFormWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  signupButtonWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget backgroundImageWidget() {
    return Positioned(
      top: -40,
      height: 400,
      width: MediaQuery.of(context).size.width,
      child: Container(
        color: Colors.blue,
      ),
    );
  }

  Widget loginFormWidget() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(196, 135, 198, .3),
              blurRadius: 20,
              offset: Offset(0, 10),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 100,
                child: Text(
                  "Sign In",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      color: Color(0xFFB74951),
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(msg == null ? '' : '$msg'),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 55.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(color: Colors.grey)),
                child: TextFormField(
                  controller: cntrlEmail,
                  style: TextStyle(fontWeight: FontWeight.w600),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(
                        fontSize: 15, color: Colors.grey.withOpacity(0.8)),
                    icon: Icon(Icons.email),
                    border: InputBorder.none,
                  ),
                  onSaved: (String value) {
                    presenter.setEmail(value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 55.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(color: Colors.grey)),
                child: TextFormField(
                  controller: cntrlPassword,
                  obscureText: true,
                  style: TextStyle(fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.withOpacity(0.8),
                      ),
                      icon: Icon(Icons.lock),
                      border: InputBorder.none),
                  onSaved: (String value) {
                    presenter.setPassword(value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Password is required.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () async {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    presenter.doLogin();
                  }
                },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30)),
                    alignment: Alignment.center,
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )),
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () async {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                  }
                },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(30)),
                    alignment: Alignment.center,
                    child: Text(
                      "Sign in with Facebook",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget signupButtonWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Don’t have an account?"),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                "Sign Up",
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  gotoHomePage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return HomePage();
    }));
  }

  @override
  refresh() {
    setState(() {});
  }

  @override
  setPresenter(t) {
    presenter = t;
  }

  @override
  showError(msg) {
    this.msg = msg;
    refresh();
  }

  @override
  showSuccess(msg) {
    this.msg = msg;
    refresh();
  }
}
