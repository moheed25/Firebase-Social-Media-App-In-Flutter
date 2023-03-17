import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sir/res/components/input_textfield.dart';
import 'package:sir/res/components/round_buttons.dart';
import 'package:sir/utils/route/route_name.dart';
import 'package:sir/view/forgot_password/controller_forgot_password.dart';
import 'package:sir/view/login/login_controller.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  final emailFocusNode = FocusNode();
  // final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();

    emailFocusNode.dispose();
    // passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        //title: Text(''),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * .01,
                ),
                Text(
                  "Forgot Password",
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: height * .01,
                ),
                Text(
                  "Enter your email address\nto recover your password",
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height * .01,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: height * .06, bottom: height * 0.03),
                    child: Column(
                      children: [
                        InputTextField(
                            myController: emailController,
                            focusNode: emailFocusNode,
                            onFieldSubmittedValue: (value) {},
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            hint: "Email",
                            onValidator: (value) {
                              return value.isEmpty ? 'enter email' : null;
                            }),
                        SizedBox(
                          height: height * 0.01,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                ChangeNotifierProvider(
                  create: (_) => ForgotController(),
                  child: Consumer<ForgotController>(
                      builder: (context, provider, child) {
                    return RoundButton(
                      title: 'Recover',
                      loading: provider.loading,
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          provider.forgotpassword(
                            context,
                            emailController.text,
                          );
                        }
                      },
                    );
                  }),
                ),
                SizedBox(
                  height: height * .03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
