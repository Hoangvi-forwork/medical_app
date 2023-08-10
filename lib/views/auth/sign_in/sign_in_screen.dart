// ignore_for_file: use_build_context_synchronously, unused_local_variable, prefer_const_constructors_in_immutables
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:medical_app/views/landing/landing_screen.dart';
import 'package:medical_app/widgets/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../blocs/auth/auth_bloc.dart';
import '../../../config/url_config.dart';
import 'sign_in_utils.dart';
import '../../../widgets/buttons/auth/buttons_widget.dart';
import '../../../widgets/text_input_widgets/auth/text_input_widgets.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String message = '';
  bool isForgotPasswordButtonPressed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LandingScreen()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
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
            return _buildSignInScreen(context);
          },
        ),
      ),
    );
  }

  // MAIN LOGIN SCREEN BODY
  SingleChildScrollView _buildSignInScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          topImage(context),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 16, right: 16, top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                topTile(context),
                const SizedBox(height: 44),
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Text(message,
                                style: TextStyle(
                                    color: const Color.fromARGB(255, 255, 0, 0)
                                        .withOpacity(1),
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold))),
                        buildTextFormField(
                            controller: emailController,
                            hintText: 'Tên đăng nhập',
                            iconName: const Icon(Icons.email),
                            inputType: 'email',
                            validatorType: 'emailValid'),
                        buildTextFormField(
                            controller: passwordController,
                            hintText: 'Mật khẩu',
                            iconName: const Icon(Icons.lock),
                            inputType: 'password',
                            validatorType: 'passwordValid'),
                        const SizedBox(height: 26),
                        buildSignInButton(
                            text: 'Login',
                            submitType: 'login',
                            submitButton: login),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: const Center(
                              child: Text('--- Or ---',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold))),
                        ),
                        buildSignInButton(
                            text: 'Register',
                            submitType: 'register',
                            submitButton: () {}),
                        _buildForgotPassButton(context)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _buildForgotPassButton(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            showBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  width: double.infinity,
                  height: 420,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 12.0,
                        spreadRadius: 0.0,
                        offset: const Offset(0.0, 0.1),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Center(
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Image.asset('assets/images/down-arrow.png'),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 24),
                        child: Form(
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 12, bottom: 12),
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    const Text(
                                      'Cấp lại mật khẩu',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 18),
                                    Text(
                                      'Vui lòng nhập địa chỉ email của bạn. Bạn sẽ nhận được yêu cầu tạo mật khẩu mới tại email của mình.',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.8),
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  prefixIcon:
                                      Icon(Icons.email, color: Colors.white),
                                ),
                                style: const TextStyle(color: Colors.white),
                              ),
                              Container(
                                width: double.infinity,
                                height: 48,
                                margin: const EdgeInsets.only(top: 36),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: GestureDetector(
                                  child: const Center(
                                      child: Text('Gửi mã xác nhận')),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Text(
            "Quên mật khẩu",
            style: TextStyle(
              color: AppColors.secondaryColor.withOpacity(0.6),
              fontStyle: FontStyle.italic,
            ),
          ),
        )
      ],
    );
  }

  // LOGIN FUNCTIONS
  void login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_formKey.currentState!.validate()) {
      String apiUrl = '${Configs.IP4Local}login';
      final response = await http.post(Uri.parse(apiUrl), body: {
        'email': emailController.text,
        'password': passwordController.text,
      });
      final responseBody = json.decode(response.body);
      // final idUser = responseBody['id_taikhoan'];
      // print(idUser.toString());
      if (response.statusCode == 200) {
        // print("Day la ket qua:  $responseBody");
        prefs.setString('email', emailController.text);
        prefs.setInt('id', responseBody['id_taikhoan']);
        print("Day la ket qua ID:  ${responseBody['id_taikhoan']}");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LandingScreen()),
        );
      } else {
        setState(() {
          message = responseBody['message'];
        });
        if (message == "Tài khoản hoặc mật khẩu không chính xác") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tài khoản hoặc mật khẩu không chính xác'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    }
  }
}
