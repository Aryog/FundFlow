import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fundflow/pages/HomeScreen.dart';
import 'package:fundflow/utils/app_styles.dart';
import 'package:get/get.dart';

class AppLoginScreen extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  bool _isChecked = false;
  void _checkBoxChange(bool value) {
    _isChecked = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 76, 175, 80),
      backgroundColor: Theme.of(context).primaryColor,
      //appBar: AppBar(backgroundColor: Styles.bgColor),
      body: Center(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/logo1.png'),
                height: 85,
                width: 250,
                fit: BoxFit.fill,
              ),
              // Text(
              //   'Welcome',
              //   style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 25,
              //       fontWeight: FontWeight.w500),
              // ),
              SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(12),
                child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        icon: Icon(Icons.person_2_sharp),
                        labelText: 'Username')),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                margin: EdgeInsets.all(12),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                    icon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password Incorrect';
                    } else if (value.length < 6) {
                      return 'Password must be greater than 6';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(200, 0, 0, 0),
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Row(
                children: [
                  Checkbox(
                      value: _isChecked,
                      onChanged: (Value) {
                        _checkBoxChange(true);
                      }),
                  Text(
                    'Remember Me',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AppHomeScreen()));
                    }
                  },
                  //Navigator.of(context).push(AppHomeScreen());
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
