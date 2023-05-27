import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: ListView(
        padding: EdgeInsets.all(AppLayout.getHeight(12)),
        children: [
          Form(
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
                  if (value.length > 2) {
                    return "Please enter valid Username";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      FluentSystemIcons.ic_fluent_person_filled,
                      color: Styles.primaryColor,
                    ),
                    labelText: "Username",
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppLayout.getHeight(12)))),
              ),
              Gap(AppLayout.getHeight(10)),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter email";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      FluentSystemIcons.ic_fluent_mail_filled,
                      color: Styles.primaryColor,
                    ),
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppLayout.getHeight(12)))),
              ),
              Gap(AppLayout.getHeight(10)),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter mobile number";
                  }
                  if (value.length > 10) {
                    return "Invalid Number";
                  }
                  return null;
                },
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
                        borderRadius:
                            BorderRadius.circular(AppLayout.getHeight(12)))),
              ),
              Gap(AppLayout.getHeight(10)),
              TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password";
                  }
                  if (value.length > 8) {
                    return "Password is weak";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      FluentSystemIcons.ic_fluent_lock_filled,
                      color: Styles.primaryColor,
                    ),
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppLayout.getHeight(12)))),
              ),
              Gap(AppLayout.getHeight(10)),
              TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter confirm password";
                  }
                  if (value.length > 8) {
                    return "Password is weak";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      FluentSystemIcons.ic_fluent_lock_filled,
                      color: Styles.primaryColor,
                    ),
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppLayout.getHeight(12)))),
              ),
              Gap(AppLayout.getHeight(20)),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Styles.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppLayout.getHeight(8))),
                        padding: EdgeInsets.all(AppLayout.getHeight(12))),
                    child: Text(
                      "Register",
                      style: Styles.headLineStyle2.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    )),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
