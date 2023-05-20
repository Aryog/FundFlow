import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:fundflow/utils/app_layout.dart';
import 'package:fundflow/utils/app_styles.dart';
import 'package:gap/gap.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLoginScreen extends StatefulWidget {
  const AppLoginScreen({super.key});

  @override
  State<AppLoginScreen> createState() => _AppLoginScreenState();
}

class _AppLoginScreenState extends State<AppLoginScreen> {
  bool isChecked = false;

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
                  if (value == null) {
                    return "Please enter your Username";
                  } else {
                    return null;
                  }
                },
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
                  if (value == null) {
                    return "Please enter your Password";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      FluentSystemIcons.ic_fluent_lock_filled,
                      color: Styles.primaryColor,
                    ),
                    suffixIcon:
                        Icon(FluentSystemIcons.ic_fluent_eye_hide_filled),
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Styles.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppLayout.getHeight(8))),
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
          ))
        ],
      ),
    );
  }
}
