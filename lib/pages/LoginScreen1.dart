import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:fundflow/utils/app_layout.dart';
import 'package:fundflow/utils/app_styles.dart';
import 'package:gap/gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AppLoginScreen extends StatefulWidget {
  const AppLoginScreen({Key? key}) : super(key: key);

  @override
  State<AppLoginScreen> createState() => _AppLoginScreenState();
}

class _AppLoginScreenState extends State<AppLoginScreen> {
  bool isChecked = false;
  bool isVisible = false;
  final _formkey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  Future<void> saveData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  void _submitForm() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      // Perform the save operation using backend
      // To do backend to be in node js user add
      String url = 'http://10.0.2.2:5000/auth/login';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      Map<String, String> body = {'username': _username, 'password': _password};
      try {
        final uri = Uri.parse(url);
        var response =
            await http.post(uri, headers: headers, body: jsonEncode(body));
        if (response.statusCode == 200) {
          // Successful login
          var responseData = jsonDecode(response.body);
          String accessToken = responseData['accessToken'];
          String refreshToken = responseData['refreshToken'];
          saveData("accessToken", accessToken);
          saveData("refreshToken", refreshToken);
          print('Logged in successfully');
        } else {
          // Login failed
          print('Login failed with status code: ${response.statusCode}');
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
                Gap(AppLayout.getHeight(40)),
                Container(
                  child: SvgPicture.asset(
                    'assets/images/fundflowlogo.svg',
                    width: 250, // Set the desired width
                    height: 250, // Set the desired height
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your Username";
                    }
                    return null;
                  },
                  onSaved: (newValue) => _username = newValue!,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        FluentSystemIcons.ic_fluent_person_filled,
                        color: Styles.primaryColor,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Styles.primaryColor)),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppLayout.getHeight(12)),
                      ),
                      labelText: "Username"),
                ),
                Gap(AppLayout.getHeight(10)),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your Password";
                    } else {
                      return null;
                    }
                  },
                  obscureText: isVisible,
                  onSaved: ((newValue) => _password = newValue!),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        FluentSystemIcons.ic_fluent_lock_filled,
                        color: Styles.primaryColor,
                      ),
                      suffixIcon: GestureDetector(
                        child: Icon(isVisible
                            ? FluentSystemIcons.ic_fluent_eye_hide_filled
                            : FluentSystemIcons.ic_fluent_eye_show_filled),
                        onTap: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Styles.primaryColor)),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppLayout.getHeight(12)),
                      ),
                      labelText: "Password",
                      labelStyle: Styles.headLineStyle3
                          .copyWith(fontWeight: FontWeight.normal)),
                ),
                Gap(AppLayout.getHeight(15)),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //checkbox
                      Flex(direction: Axis.horizontal, children: [
                        Checkbox(
                            value: isChecked,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            onChanged: (e) => {
                                  setState(() {
                                    isChecked = !isChecked;
                                  })
                                }),
                        Text(
                          "Remember Me",
                          style: Styles.headLineStyle3
                              .copyWith(fontWeight: FontWeight.normal),
                        )
                      ]),

                      //forget password
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Styles.primaryColor),
                        ),
                      )
                    ],
                  ),
                ),
                Gap(AppLayout.getHeight(15)),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => _submitForm(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Styles.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  AppLayout.getHeight(8))),
                          padding: EdgeInsets.all(AppLayout.getHeight(12))),
                      child: Text(
                        "Login",
                        style: Styles.headLineStyle2.copyWith(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      )),
                ),
                Gap(AppLayout.getHeight(12)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        " Register Here!",
                        style: Styles.headLineStyle3
                            .copyWith(color: Styles.primaryColor, fontSize: 12),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
