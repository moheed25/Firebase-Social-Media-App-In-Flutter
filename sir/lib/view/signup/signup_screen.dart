import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sir/res/components/input_textfield.dart';
import 'package:sir/res/components/round_buttons.dart';
import 'package:sir/utils/route/route_name.dart';
import 'package:sir/utils/utils.dart';
import 'package:sir/viewmodel/sigup/signup_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ChangeNotifierProvider(
              create: (_) => SignupController(),
              child: Consumer<SignupController>(
                  builder: (context, provider, child) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * .01,
                      ),
                      Text(
                        "Welcome to App",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      Text(
                        "Enter your email address\nto register   your account",
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
                                  myController: userNameController,
                                  focusNode: usernameFocusNode,
                                  onFieldSubmittedValue: (value) {},
                                  keyboardType: TextInputType.emailAddress,
                                  obscureText: false,
                                  hint: "Username",
                                  onValidator: (value) {
                                    return value.isEmpty ? 'enter email' : null;
                                  }),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              InputTextField(
                                  myController: emailController,
                                  focusNode: emailFocusNode,
                                  onFieldSubmittedValue: (value) {
                                    Utils.fieldFocus(context, emailFocusNode,
                                        passwordFocusNode);
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  obscureText: false,
                                  hint: "Email",
                                  onValidator: (value) {
                                    return value.isEmpty ? 'enter email' : null;
                                  }),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              InputTextField(
                                  myController: passwordController,
                                  focusNode: passwordFocusNode,
                                  onFieldSubmittedValue: (value) {},
                                  keyboardType: TextInputType.emailAddress,
                                  obscureText: true,
                                  hint: "Password",
                                  onValidator: (value) {
                                    return value.isEmpty
                                        ? 'enter password'
                                        : null;
                                  }),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      RoundButton(
                        title: 'SignUp',
                        loading: provider.loading,
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            provider.signup(context, userNameController.text,
                                emailController.text, passwordController.text);
                          }
                        },
                      ),
                      SizedBox(
                        height: height * .03,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.loginview);
                        },
                        child: Text.rich(TextSpan(
                            text: "Already have an account ?",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontSize: 15),
                            children: [
                              TextSpan(
                                text: "Login",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        fontSize: 15,
                                        decoration: TextDecoration.underline),
                              )
                            ])),
                      ),
                    ],
                  ),
                );
              }),
            )),
      ),
    );
  }
}
