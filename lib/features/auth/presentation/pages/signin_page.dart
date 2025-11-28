import 'package:blog/core/common/constants/app_strings.dart';
import 'package:blog/core/common/theme/app_texttheme.dart';
import 'package:blog/core/router/router_names.dart';
import 'package:blog/core/services/widget_service.dart';
import 'package:blog/features/auth/data/models/signin_model.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/auth/presentation/bloc/status/signin_status.dart';
import 'package:blog/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog/features/auth/presentation/widgets/link_button.dart';
import 'package:blog/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final WidgetServices widgetServices = locator.get();
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 50),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTitle(),
              SizedBox(height: 50),
              SizedBox(height: 20),
              _buildEmailField(),
              SizedBox(height: 20),
              _buildPasswordField(),
              SizedBox(height: 30),
              _buildSignupButton(),
              SizedBox(height: 20),
              signupLink(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.question),
        onPressed: () => showHelpSheet(),
      ),
    );
  }

  LinkButton signupLink() {
    return LinkButton(
      title: 'SignUp',
      text: 'Don\'t have an account?',
      routeName: RouterNames.signupPage,
    );
  }

  Text _buildTitle() {
    return Text(
      textAlign: TextAlign.center,
      style: AppTexttheme.white30PoppinsBold,
      'Login To Blog',
    );
  }

  AuthField _buildEmailField() {
    return AuthField(
      hint: 'email',
      icon: CupertinoIcons.mail,
      controller: emailController,
    );
  }

  AuthField _buildPasswordField() {
    return AuthField(
      hint: 'password',
      icon: CupertinoIcons.lock,
      controller: passwordController,
    );
  }

  FilledButton _buildSignupButton() {
    return FilledButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          BlocProvider.of<AuthBloc>(context).add(
            SigninEvent(
              signinModel: SigninModel(
                email: emailController.text,
                password: passwordController.text,
              ),
            ),
          );
        }
      },
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          final status = state.signinStatus;
          if (status is SigninFail) {
            widgetServices.showSnackbar(message: status.errorMessage);
          }
          if (status is SigninSuccess) {
            context.push(RouterNames.homePage);
          }
        },
        builder: (context, state) {
          final status = state.signinStatus;
          if (status is SigninInitial) {
            return Text(SigninStrings.login);
          }
          if (status is SigninLoading) {
            return CircularProgressIndicator();
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  showHelpSheet() {
    widgetServices.showBottomSheet(
      children: [
        TextButton(
          child: Text(
            style: AppTexttheme.white17PoppinsRegular,
            SigninStrings.forgotPassword,
          ),
          onPressed: () {},
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            style: AppTexttheme.white17PoppinsRegular,
            SigninStrings.dontGetEmail,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
