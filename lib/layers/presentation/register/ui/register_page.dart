import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../injection_container.dart';
import '../../../../resources/colour_manager.dart';
import '../../../../resources/font_manager.dart';
import '../../../../resources/styles_manager.dart';
import '../../../../resources/values_manager.dart';
import '../../login/ui/login_screen.dart';
import '../../login/widgets/sign_in_button.dart';
import '../bloc/user_add_bloc.dart';
import '../bloc/user_add_event.dart';
import '../bloc/user_add_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  final UserAddBloc userAddBloc = sl<UserAddBloc>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return BlocConsumer<UserAddBloc, UserAddState>(
      bloc: userAddBloc,
      listenWhen: (previous, current) => current is UserAddActionState,
      buildWhen: (previous, current) => current is! UserAddActionState,
      listener: (context, state) {
        if (state is AddUserLoadingState) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const Center(child: CircularProgressIndicator());
            },
          );
        } else if (state is AddUserSavedState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const LoginPage(),
              fullscreenDialog: true,
            ),
          );
        } else if (state is AddUserErrorState) {
          Fluttertoast.showToast(
            msg: (state.failure.message) + (state.failure.cause),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: ColorManager.error,
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: AppWidth.w30),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(
                      AppRadius.r20,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: AppHeight.h40,
                      ),
                      Text(
                        "Email",
                        style: getBoldStyle(
                          fontSize: FontSize.s15,
                          color: ColorManager.primary,
                        ),
                      ),
                      SizedBox(
                        height: AppHeight.h10,
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*Required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: ColorManager.redWhite,
                          filled: true,
                          hintText: 'Email',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.blueGrey),
                            borderRadius: BorderRadius.circular(AppRadius.r10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.primary),
                            borderRadius: BorderRadius.circular(AppRadius.r10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.red),
                            borderRadius: BorderRadius.circular(AppRadius.r10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppHeight.h10,
                      ),
                      Text(
                        "Password",
                        style: getBoldStyle(
                          fontSize: FontSize.s15,
                          color: ColorManager.primary,
                        ),
                      ),
                      SizedBox(
                        height: AppHeight.h10,
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*Required';
                          }
                          return null;
                        },
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: ColorManager.redWhite,
                          filled: true,
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible ? Icons.visibility : Icons.visibility_off,
                              color: ColorManager.blue,
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  _passwordVisible = !_passwordVisible;
                                },
                              );
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.blueGrey),
                            borderRadius: BorderRadius.circular(AppRadius.r10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.primary),
                            borderRadius: BorderRadius.circular(AppRadius.r10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.red),
                            borderRadius: BorderRadius.circular(AppRadius.r10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppHeight.h10,
                      ),
                      Text(
                        "Confirm Password",
                        style: getBoldStyle(
                          fontSize: FontSize.s15,
                          color: ColorManager.primary,
                        ),
                      ),
                      SizedBox(
                        height: AppHeight.h10,
                      ),
                      TextFormField(
                        controller: confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*Required';
                          } else if (value != passwordController.text) {
                            return "password didn't match";
                          }
                          return null;
                        },
                        obscureText: !_confirmPasswordVisible,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: ColorManager.redWhite,
                          filled: true,
                          hintText: 'Confirm Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: ColorManager.blue,
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  _confirmPasswordVisible = !_confirmPasswordVisible;
                                },
                              );
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.blueGrey),
                            borderRadius: BorderRadius.circular(AppRadius.r10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.primary),
                            borderRadius: BorderRadius.circular(AppRadius.r10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.red),
                            borderRadius: BorderRadius.circular(AppRadius.r10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppHeight.h30,
                      ),
                      SigninButton(
                        child: Text(
                          "Register",
                          // widget.userModel == null ? AppStrings.register : AppStrings.updateUser,
                          style: getRegularStyle(
                            fontSize: FontSize.s16,
                            color: ColorManager.white,
                          ),
                        ),
                        onPressed: () async {
                          var email = emailController.text;
                          var password = passwordController.text;

                          if (_formKey.currentState!.validate()) {
                            userAddBloc.add(UserAddSaveButtonPressEvent(
                              email,
                              password,
                            ));
                          }
                        },
                      ),
                      SizedBox(
                        height: AppHeight.h10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Login",
                            style: getBoldStyle(
                              fontSize: FontSize.s16,
                              color: ColorManager.primary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppHeight.h16,
                      ),
                    ],
                  ),
                  // ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
