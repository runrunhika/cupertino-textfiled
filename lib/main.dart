import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String value = '';
  late TextEditingController controller;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cupertino TextField'),
      ),
      child: SafeArea(
          child: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Text(
                value,
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              CupertinoTextField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                padding: EdgeInsets.all(16),
                placeholder: 'Email',
                placeholderStyle: TextStyle(color: CupertinoColors.activeBlue),
                style: TextStyle(color: Colors.black54),
                decoration: BoxDecoration(
                    color: CupertinoColors.extraLightBackgroundGray,
                    border: Border.all(
                        color: CupertinoColors.lightBackgroundGray, width: 2),
                    borderRadius: BorderRadius.circular(30)),
                cursorColor: CupertinoColors.activeGreen,
                onChanged: (value) {
                  setState(() {
                    this.value = value;
                  });
                },
                onSubmitted: (value) => print("$value"),
              ),
              Divider(),
              const SizedBox(
                height: 5,
              ),
              CupertinoTextField(
                controller: controller,
                padding: EdgeInsets.all(16),
                maxLength: 3,
                placeholder: 'Borderless TextField',
                placeholderStyle: TextStyle(color: Colors.amber),
                prefix: CupertinoButton(
                  child: Icon(CupertinoIcons.text_bubble),
                  onPressed: () {},
                ),
                suffix: CupertinoButton(
                  child: Icon(CupertinoIcons.clear),
                  onPressed: () {
                    controller.clear();
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CupertinoFormSection.insetGrouped(
                  header: Text('Create Account'),
                  footer: Divider(),
                  children: [
                    CupertinoFormRow(
                      // error: ,
                      prefix: Text('Email'),
                      child: CupertinoTextFormFieldRow(
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        placeholder: 'Enter email',
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return 'Enter a valid email';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    CupertinoFormRow(
                      prefix: Text('Password'),
                      helper: Text(
                        'YOu cannot change the Password',
                        style: TextStyle(
                            color: CupertinoColors.systemGrey, fontSize: 12),
                      ),
                      child: CupertinoTextFormFieldRow(
                        padding: EdgeInsets.all(16),
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        placeholder: 'PassWord',
                        obscureText: true,
                        obscuringCharacter: '*',
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return 'Enter a valid password';
                          } else if (password.length < 6) {
                            return '6文字以上で入力して下さい';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ]),
              const SizedBox(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  width: double.infinity,
                  child: CupertinoButton.filled(
                      child: Text('Submit'),
                      onPressed: () {
                        final form = formKey.currentState;

                        if (form!.validate()) {
                          Fluttertoast.showToast(
                              msg: 'Ok Email & Password', fontSize: 18);
                        }
                      }))
            ],
          ),
        ),
      )),
    );
  }
}
