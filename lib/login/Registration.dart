import 'package:commerce/model/User.dart';
import 'package:commerce/network/ServiceApi.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';
class Registration extends StatefulWidget {
  const Registration({Key key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController _nameController=TextEditingController();
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passController=TextEditingController();
  TextEditingController  _confirmPassController =TextEditingController();
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"), centerTitle: true,

      ), body: SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: "name"),
                  validator: (value) {
                    if (value.isEmpty)
                      return "Required";
                    else
                      return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: "Email"),
                  validator: (value) {
                    if (value.isEmpty)
                      return "Required";
                    else if (!EmailValidator.validate(value))
                      return "Wrong Email";
                    else
                      return null;
                  },

                ),
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(hintText: "Password"),
                  obscureText: true,
                  validator: (value) {
                    if(value.isEmpty)
                      return"Required";
                    else
                      return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPassController,
                  decoration: InputDecoration(hintText: "confirmPassword"),
                  obscureText: true,
                  validator: (value) {
                    if(value.isEmpty)
                      return"Required";
                    else if(value!=_passController.text)
                      return "Password Don't match";
                    else
                      return null;
                  },



                ),

                ElevatedButton(onPressed: () => registerBtnClicked() , child: Text("Register"))
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }

  registerBtnClicked() async {
    if (!_formkey.currentState.validate()) {
      Fluttertoast.showToast(msg:"Missing",toastLength:Toast.LENGTH_SHORT,fontSize:16.0);
      return;
    }
    print("Register");



    User user = User(name: _nameController.text,email: _emailController.text,password: _passController.text);
    dynamic res= await  ServiceApi.instance.register(user);
    if(ServiceApi.statusCode==201){
      user.token=res;
      print('Token:$res');
    }

    else {
      print('Error: ${ServiceApi.statusCode},$res');
    }
  }
}



