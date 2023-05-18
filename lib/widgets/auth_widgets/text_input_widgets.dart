// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../colors.dart';

class buildTextFormField extends StatefulWidget {
  final String hintText;
  final Icon iconName;
  final String inputType;
  final String validatorType;
  TextEditingController controller;

  buildTextFormField({
    Key? key,
    required this.hintText,
    required this.iconName,
    required this.inputType,
    required this.validatorType,
    required this.controller,
  }) : super(key: key);

  @override
  State<buildTextFormField> createState() => _buildTextFormFieldState();
}

// ignore: camel_case_types
class _buildTextFormFieldState extends State<buildTextFormField> {
  // Validata
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // check validateType
    String? Function(String?)? validator;
    if (widget.validatorType == 'emailValid') {
      validator = validateEmail;
    } else if (widget.validatorType == 'passwordValid') {
      validator = validatePassword;
    } else if (widget.validatorType == 'usernameValid') {
      validator = validateUsername;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.inputType == 'password' ? true : false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: Container(
            margin: const EdgeInsets.only(right: 16),
            child: Icon(
              widget.iconName.icon,
              color: AppColors.primaryColor,
            ),
          ),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: widget.inputType == 'pass'
              ? Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: const Icon(
                    Icons.visibility,
                    color: AppColors.primaryColor,
                  ),
                )
              : null,
          suffixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
