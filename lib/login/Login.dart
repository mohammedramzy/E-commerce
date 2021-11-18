
import 'package:commerce/login/Registration.dart';
import 'package:commerce/model/User.dart';
import 'package:commerce/network/ServiceApi.dart';
import 'package:commerce/tabs/tabsPage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value.isEmpty)
                      return "Must Enter Email";
                    else if (!EmailValidator.validate(value))
                      return "Must Enter a valid Email ";
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                  obscureText: true,
                  // validator: (value) => value.isEmpty ? "Must Enter Password"
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Doesn't have account",
                            style: TextStyle(color: Colors.black)),
                        WidgetSpan(child: SizedBox(width: 5)),
                        WidgetSpan(
                            child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Registration()));
                          },
                          child: Text("Register",
                              style: TextStyle(color: Colors.blueAccent)),
                        )),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () => loginBtnClicked(), child: Text("Login")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  loginBtnClicked() async {
    if (!_formkey.currentState.validate()) {
      Fluttertoast.showToast(
          msg: "Missing", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      return;
    }
    User user =
        User(email: _emailController.text, password: _passController.text);
    String res = await ServiceApi.instance.login(user);
    if (ServiceApi.statusCode == 200) {
      user.token = res;
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => TabsPage(token: user.token,)));
    } else {
      print('Error :${ServiceApi.statusCode},$res');
    }
  }
}
