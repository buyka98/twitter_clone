import 'dart:math';

import 'package:bwitter/helper/enum.dart';
import 'package:bwitter/helper/utility.dart';
import 'package:bwitter/model/user.dart';
import 'package:bwitter/state/auth_state.dart';
import 'package:bwitter/widgets/custom_flat_button.dart';
import 'package:bwitter/widgets/custom_widgets/custom_loader.dart';
import 'package:bwitter/widgets/custom_widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  final Function? loginCallBack;
  const SignUp({Key? key, this.loginCallBack}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmController = TextEditingController();
  CustomLoader loader = CustomLoader();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText("Sign Up"),
      ),
      body: SingleChildScrollView(child: _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _entryField('Name', controller: _nameController),
              _entryField('Enter email', controller: _emailController, isEmail: true),
              _entryField('Enter password', controller: _passwordController, isPassword: true),
              _entryField('Confirm password', controller: _confirmController, isPassword: true),
              _submitButton(context),

              const Divider(height: 30),
              const SizedBox(height: 30),
              // GoogleLoginButton(
              //   loginCallback: widget.loginCallback,
              //   loader: loader,
              // ),
              const SizedBox(height: 30),
            ],
          )),
    );
  }

  Widget _entryField(String hint, {required TextEditingController controller, bool isPassword = false, bool isEmail = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        style: const TextStyle(
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.normal,
        ),
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
            borderSide: BorderSide(color: Colors.blue),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 35),
      child: CustomFlatButton(
        label: "Sign up",
        onPressed: () => _submitForm(context),
        borderRadius: 30,
      ),
    );
  }

  void _submitForm(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_nameController.text.isEmpty) {
      Utility.customSnackBar(context, 'Please enter name');
      return;
    }
    if (_nameController.text.length > 27) {
      Utility.customSnackBar(context, 'Name length cannot exceed 27 character');
      return;
    }
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      Utility.customSnackBar(context, 'Please fill form carefully');
      return;
    } else if (_passwordController.text != _confirmController.text) {
      Utility.customSnackBar(context, 'Password and confirm password did not match');
      return;
    }
    loader.showLoader(context);
    Random random = Random();
    int randomNumber = random.nextInt(8);

    UserModel user = UserModel(
      email: _emailController.text.toLowerCase(),
      bio: 'Edit profile to update bio',
      // contact:  _mobileController.text,
      displayName: _nameController.text,
      dob: DateTime(1950, DateTime.now().month, DateTime.now().day + 3).toString(),
      location: 'Somewhere in universe',
      // profilePic: Constants.dummyProfilePicList[randomNumber],
      isVerified: false,
    );

    var state = Provider.of<AuthState>(context, listen: false);
    state
        .signUp(
      user,
      password: _passwordController.text,
      context: context,
    )
        .then((status) {
      print("status ${status}");
    }).whenComplete(
      () {
        loader.hideLoader();
        if (state.authStatus == AuthStatus.LOGGED_IN) {
          Navigator.pop(context);
          if (widget.loginCallBack != null) widget.loginCallBack!();
        }
      },
    );
  }
}
