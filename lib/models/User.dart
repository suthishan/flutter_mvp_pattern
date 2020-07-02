class User {
  var firstname;
  var lastname;
  var email;
  var password;

  bool isLoginValid() {
    return email == "test@gmail.com" && password == "test@123";
  }
}
