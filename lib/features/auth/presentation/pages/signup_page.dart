import 'package:blog/core/common/theme/app_text_theme.dart';
import 'package:blog/core/common/widgets/loading_widget.dart';
import 'package:blog/core/router/router_names.dart';
import 'package:blog/core/utils/widget_helper.dart';
import 'package:blog/features/auth/data/models/signup_model.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/auth/presentation/bloc/status/signup_status.dart';
import 'package:blog/core/common/widgets/custom_input.dart';
import 'package:blog/features/auth/presentation/widgets/link_button.dart';
import 'package:blog/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final WidgetHelper widgetServices = locator.get();
  final SupabaseClient supabse = locator.get();
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController usernameController = TextEditingController();
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
              _buildUsernameField(),
              SizedBox(height: 20),
              _buildEmailField(),
              SizedBox(height: 20),
              _buildPasswordField(),
              SizedBox(height: 30),
              _buildSignupButton(),
              SizedBox(height: 20),
              LinkButton(
                text: 'Already have an account?',
                routeName: RouterNames.signinPage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      textAlign: TextAlign.center,
      style: AppTextTheme.white30PoppinsBold,
      'Sign Up Here ',
    );
  }

  Widget _buildUsernameField() {
    return CustomInput(
      hint: 'username',
      icon: CupertinoIcons.person,
      controller: usernameController,
    );
  }

  Widget _buildEmailField() {
    return CustomInput(
      hint: 'email',
      icon: CupertinoIcons.mail,
      controller: emailController,
    );
  }

  Widget _buildPasswordField() {
    return CustomInput(
      hint: 'password',
      icon: CupertinoIcons.lock,
      controller: passwordController,
    );
  }

  Widget _buildSignupButton() {
    return FilledButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          BlocProvider.of<AuthBloc>(context).add(
            SignupEvent(
              signupModel: SignupModel(
                email: emailController.text,
                username: usernameController.text,
                password: passwordController.text,
              ),
            ),
          );
        }
      },
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          final status = state.signupStatus;
          if (status is SignupFail) {
            widgetServices.showSnackbar(message: status.errorMessage);
          }
          if (status is SignupSuccess) {
            widgetServices.showSnackbar(
              message: 'please verify you email then login',
            );
            context.go(RouterNames.signinPage);
          }
        },
        builder: (context, state) {
          final status = state.signupStatus;
          if (status is SignupInitial) {
            return Text('Sign Up');
          }
          if (status is SignupLoading) {
            return LoadingWidget();
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
