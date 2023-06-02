import 'dart:convert';
import 'dart:ffi';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fundflow/utils/app_styles.dart';
import 'package:fundflow/utils/app_layout.dart';
import 'package:gap/gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class AppRegsiterScreen extends StatefulWidget {
  const AppRegsiterScreen({super.key});

  @override
  State<AppRegsiterScreen> createState() => _AppRegsiterScreenState();
}

class _AppRegsiterScreenState extends State<AppRegsiterScreen> {
  final _formkey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _cPassword = '';
  String _email = '';
  String _phoneNo = '';
  bool isRegistered = false;
  final TextEditingController passwordController = TextEditingController();
  void registerBtn(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      String url = 'http://10.0.2.2:5000/auth/register';
      Map<String, String> headers = {'Content-Type': 'application/json'};
      Map<String, dynamic> body = {
        "username": _username,
        'email': _email,
        'password': _password,
        'mobile_number': double.parse(_phoneNo)
      };
      try {
        final uri = Uri.parse(url);
        var response =
            await http.post(uri, headers: headers, body: jsonEncode(body));
        if (response.statusCode == 200) {
          print('Registered succesfully');
          setState(() {
            isRegistered = true;
            _username = '';
            _password = '';
            _cPassword = '';
            _email = '';
            _phoneNo = '';
          });
          // navigate to login option
        } else {
          // Login failed
          print('Registered failed with status code: ${response.statusCode}');
        }
      } catch (e) {
        print("Error ${e}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: ListView(
        padding: EdgeInsets.all(AppLayout.getHeight(12)),
        children: [
          Form(
              key: _formkey,
              child: Column(
                children: [
                  Container(
                    // color: Colors.red,
                    child: SvgPicture.asset(
                      'assets/images/fundflowlogo.svg',
                      width: 200, // Set the desired width
                      height: 200, // Set the desired height
                    ),
                  ),
                  // User name field
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Username";
                      }
                      if (value.length < 2) {
                        return "Please enter valid Username";
                      }
                      return null;
                    },
                    onSaved: (newValue) => _username = newValue!,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          FluentSystemIcons.ic_fluent_person_filled,
                          color: Styles.primaryColor,
                        ),
                        labelText: "Username",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                AppLayout.getHeight(12)))),
                  ),
                  Gap(AppLayout.getHeight(10)),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter email";
                      }
                      return null;
                    },
                    onSaved: (newValue) => _email = newValue!,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          FluentSystemIcons.ic_fluent_mail_filled,
                          color: Styles.primaryColor,
                        ),
                        labelText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                AppLayout.getHeight(12)))),
                  ),
                  Gap(AppLayout.getHeight(10)),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter mobile number";
                      }
                      if (value.length < 10 || value.length > 10) {
                        return "Invalid Number";
                      }
                      return null;
                    },
                    onSaved: (newValue) => _phoneNo = newValue!,
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: Image.asset(
                            'assets/images/flag.png',
                            width: 25,
                            height: 25,
                          ),
                          onPressed: () {},
                        ),
                        prefixText: "+977-",
                        labelText: "Mobile Number",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                AppLayout.getHeight(12)))),
                  ),
                  Gap(AppLayout.getHeight(10)),
                  TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password";
                      }
                      if (value.length < 8) {
                        return "Password is weak";
                      }
                      return null;
                    },
                    onSaved: (newValue) => _password = newValue!,
                    controller: passwordController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          FluentSystemIcons.ic_fluent_lock_filled,
                          color: Styles.primaryColor,
                        ),
                        labelText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                AppLayout.getHeight(12)))),
                  ),
                  Gap(AppLayout.getHeight(10)),
                  TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter confirm password";
                      }
                      if (value.length < 8) {
                        return "Password is weak";
                      }
                      if (passwordController.text != value) {
                        print(passwordController.text);
                        return "Confirm password should match";
                      }
                      return null;
                    },
                    onSaved: (newValue) => _cPassword = newValue!,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          FluentSystemIcons.ic_fluent_lock_filled,
                          color: Styles.primaryColor,
                        ),
                        labelText: "Confirm Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                AppLayout.getHeight(12)))),
                  ),
                  Gap(AppLayout.getHeight(20)),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          // clear localstorage here
                          registerBtn(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Styles.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    AppLayout.getHeight(8))),
                            padding: EdgeInsets.all(AppLayout.getHeight(12))),
                        child: Text(
                          "Register",
                          style: Styles.headLineStyle2.copyWith(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        )),
                  ),
                  Gap(AppLayout.getHeight(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text(
                          " Login Here!",
                          style: Styles.headLineStyle3.copyWith(
                              color: Styles.primaryColor, fontSize: 12),
                        ),
                      )
                    ],
                  ),
                  Visibility(
                      visible: isRegistered,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: Container(
                        child: Text(
                          "Suceessfull Registration now Login",
                          style: Styles.headLineStyle3
                              .copyWith(color: Colors.green, fontSize: 16),
                        ),
                      ))
                ],
              ))
        ],
      ),
    );
  }
}
