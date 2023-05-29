// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/views/landing_screen.dart';
import 'package:medical_app/widgets/colors.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../widgets/auth_widgets/buttons_widget.dart';
import '../../widgets/auth_widgets/text_input_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernamedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Container(
          margin: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 14,
              ),
            ),
          ),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => LandingScreen(),
            ));
          }
          if (state is AuthError) {
            // Displaying the error message if the user is not authenticated
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/icons/medicine.gif',
                  width: 86,
                  height: 86,
                  filterQuality: FilterQuality.high,
                ),
              ),
            );
          }
          if (state is UnAuthenticated) {
            return _buildSignUpBodyScreen();
          }
          return _buildSignUpBodyScreen();
        },
      ),
    );
  }

  SingleChildScrollView _buildSignUpBodyScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const _topImage(),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 16, right: 16, top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const _topTitle(),
                const SizedBox(
                  height: 44,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        buildTextFormField(
                          controller: emailController,
                          hintText: 'Enter your email',
                          iconName: Icon(Icons.email),
                          inputType: 'email',
                          validatorType: 'emailValid',
                        ),
                        buildTextFormField(
                          controller: usernamedController,
                          hintText: 'Username',
                          iconName: Icon(Icons.person),
                          inputType: 'username',
                          validatorType: 'usernameValid',
                        ),
                        buildTextFormField(
                          controller: passwordController,
                          hintText: 'Password',
                          iconName: Icon(Icons.lock),
                          inputType: 'password',
                          validatorType: 'passwordValid',
                        ),
                        SizedBox(
                          height: 36,
                        ),
                        buildSignUpButton(
                          text: 'Register',
                          submitType: 'register',
                          submitButton: () {
                            _createNewAccountWithEmailAndPassword(context);
                          },
                        ),
                        Row(
                          children: [
                            buildComeBackButton(
                              text: 'I have a account!',
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _createNewAccountWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(emailController.text, passwordController.text),
      );
    }
  }
}

// top image widgets
class _topImage extends StatelessWidget {
  const _topImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      color: Colors.grey,
      child: Image.network(
        'https://i.pinimg.com/564x/e0/c8/0e/e0c80e4c6fad4391f14d371f9d86683f.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}

// top title
class _topTitle extends StatelessWidget {
  const _topTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Sign Up',
          style: TextStyle(
            color: AppColors.textColor.withOpacity(1),
            fontSize: 26,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          'Register to become a member of our healthcare community and experience top-notch healthcare services. ',
          style: TextStyle(
            color: AppColors.textColor.withOpacity(0.6),
            fontSize: 16,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.normal,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Divider(
            height: 1,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
