import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:merokaam/resources/assets_manager.dart';
import '../../../../core/entities/login.dart';
import '../../../../injection_container.dart';
import '../../../../resources/colour_manager.dart';
import '../../../../resources/font_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/styles_manager.dart';
import '../../../../resources/values_manager.dart';
import '../../JobProfile/read_job_profile/ui/read_job_profile_page.dart';
import '../../register/ui/register_page.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../widgets/bear_log_in_controller.dart';
import '../widgets/sign_in_button.dart';
import '../widgets/tracking_text_input.dart';

class LoginPage extends StatefulWidget {
  final LoginBloc? loginBloc;
  const LoginPage({super.key, this.loginBloc});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late BearLogInController bearLogInController;
  Offset? caretView;
  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    bearLogInController = BearLogInController();
    _loginBloc = widget.loginBloc ?? sl<LoginBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final EdgeInsets devicePadding = MediaQuery.of(context).padding;

    return BlocConsumer<LoginBloc, LoginState>(
      bloc: _loginBloc,
      listenWhen: (previous, current) => current is LoginActionState,
      buildWhen: (previous, current) => current is! LoginActionState,
      listener: (context, state) {
        _handleLoginState(context, state);
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) => showExitPopup(),
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            ),
            child: Scaffold(
              body: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Stack(
                  children: [
                    _buildBackground(),
                    _buildLoginForm(size, devicePadding),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleLoginState(BuildContext context, LoginState state) {
    if (state is LoginLoadingState) {
      _showLoadingDialog(context);
    } else if (state is LoggedState) {
      _userNameController.clear();
      _passwordController.clear();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ReadJobProfilePage(),
        ),
      );
    } else if (state is LoginErrorState) {
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: state.message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorManager.error,
      );
    }
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildBackground() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: const [0.0, 1.0],
            colors: [
              ColorManager.primary,
              ColorManager.primaryOpacity70,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(Size size, EdgeInsets devicePadding) {
    return Positioned.fill(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: AppWidth.w20,
          right: AppWidth.w20,
          top: devicePadding.top + AppHeight.h50,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTitle(),
            _buildAnimation(size),
            _buildFormContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text(
        AppStrings.appTitle,
        style: getBoldStyle(
          fontSize: FontSize.s30,
          color: ColorManager.white,
        ),
      ),
    );
  }

  Widget _buildAnimation(Size size) {
    return Container(
      height: size.height * 0.2,
      padding: EdgeInsets.symmetric(horizontal: AppWidth.w30),
      child: FlareActor(
        ImageAssets.teddy,
        shouldClip: false,
        alignment: Alignment.bottomCenter,
        fit: BoxFit.contain,
        controller: bearLogInController,
      ),
    );
  }

  Widget _buildFormContainer() {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppRadius.r25),
      ),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidth.w20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppHeight.h20),
              _buildUsernameField(),
              SizedBox(height: AppHeight.h8),
              _buildPasswordField(),
              SizedBox(height: AppHeight.h20),
              _buildSignInButton(),
              SizedBox(height: AppHeight.h10),
              _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.userName,
          style: getBoldStyle(
            fontSize: FontSize.s15,
            color: ColorManager.primary,
          ),
        ),
        SizedBox(height: AppHeight.h8),
        TrackingTextInput(
          key: const ValueKey("email_id"),
          hint: AppStrings.userName,
          textEditingController: _userNameController,
          isObscured: false,
          icon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.person,
              color: ColorManager.blue,
              size: FontSize.s20,
            ),
          ),
          onCaretMoved: (Offset? caret) {
            caretView = caret;
            bearLogInController.coverEyes(caret == null);
            bearLogInController.lookAt(caret);
          },
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.password,
          style: getBoldStyle(
            fontSize: FontSize.s15,
            color: ColorManager.primary,
          ),
        ),
        SizedBox(height: AppHeight.h8),
        TrackingTextInput(
          key: const ValueKey("password"),
          hint: AppStrings.password,
          isObscured: !_passwordVisible,
          textEditingController: _passwordController,
          icon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: ColorManager.blue,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
                if (_passwordVisible && caretView != null) {
                  bearLogInController.coverEyes(false);
                  bearLogInController.lookAt(caretView);
                }
              });
            },
          ),
          onCaretMoved: (Offset? caret) {
            if (!_passwordVisible) {
              bearLogInController.coverEyes(caret != null);
              bearLogInController.lookAt(null);
            } else {
              bearLogInController.coverEyes(false);
              bearLogInController.lookAt(caretView);
            }
          },
        ),
      ],
    );
  }

  Widget _buildSignInButton() {
    return SigninButton(
      child: Text(
        "Login",
        style: getRegularStyle(
          fontSize: FontSize.s16,
          color: ColorManager.white,
        ),
      ),
      onPressed: () => _onLogin(_loginBloc),
    );
  }

  Widget _buildRegisterButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterPage(),
            ),
          );
        },
        child: const Text('Register'),
      ),
    );
  }

  void _onLogin(LoginBloc loginBloc) async {
    if (_formKey.currentState!.validate()) {
      final loginModel = LoginModel(
        email: _userNameController.text,
        password: _passwordController.text,
      );
      loginBloc.add(LoginButtonPressEvent(loginModel));
    }
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Exit App',
              style: getBoldStyle(
                fontSize: FontSize.s18,
                color: ColorManager.error,
              ),
            ),
            content: Text(
              'Do you want to exit an App?',
              style: getRegularStyle(
                fontSize: FontSize.s16,
                color: ColorManager.black,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: Text(
                  'No',
                  style: getRegularStyle(
                    fontSize: FontSize.s14,
                    color: ColorManager.green,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                //return true when click on "Yes"
                child: Text(
                  'Yes',
                  style: getRegularStyle(
                    fontSize: FontSize.s14,
                    color: ColorManager.error,
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }
}
