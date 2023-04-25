import 'package:bwitter/helper/utility.dart';
import 'package:bwitter/state/auth_state.dart';
import 'package:bwitter/ui/theme/theme.dart';
import 'package:bwitter/widgets/custom_flat_button.dart';
import 'package:bwitter/widgets/custom_widgets/custom_loader.dart';
import 'package:bwitter/widgets/custom_widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  final Function? loginCallBack;
  const SignIn({Key? key, this.loginCallBack}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  CustomLoader loader = CustomLoader();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _entryField('Enter email', controller: _emailController),
          _entryField('Enter password', controller: _passwordController, isPassword: true), _emailLoginButton(context),
          const SizedBox(height: 20),
          _labelButton('Forget password?', onPressed: () {
            Navigator.of(context).pushNamed('/ForgetPasswordPage');
          }),
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

  Widget _entryField(String hint, {required TextEditingController controller, bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.normal,
        ),
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)), borderSide: BorderSide(color: Colors.blue)),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }

  Widget _labelButton(String title, {Function? onPressed}) {
    return TextButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Text(
        title,
        style: TextStyle(color: TwitterColor.dodgeBlue, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _emailLoginButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 35),
      child: CustomFlatButton(
        label: "Submit",
        onPressed: () {
          _emailLogin();
        },
        borderRadius: 30,
      ),
    );
  }

  void _emailLogin() {
    var state = Provider.of<AuthState>(context, listen: false);
    if (state.isbusy) {
      return;
    }
    loader.showLoader(context);
    var isValid = Utility.validateCredentials(context, _emailController.text, _passwordController.text);
    if (isValid) {
      state.signIn(_emailController.text, _passwordController.text, context: context).then((status) {
        if (state.user != null) {
          loader.hideLoader();
          Navigator.pop(context);
          widget.loginCallBack!();
        } else {
          cprint('Unable to login', errorIn: '_emailLoginButton');
          loader.hideLoader();
        }
      });
    } else {
      loader.hideLoader();
    }
  }
}
