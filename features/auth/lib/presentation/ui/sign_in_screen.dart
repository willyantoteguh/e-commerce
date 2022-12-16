import 'package:auth/presentation/bloc/sign_in_bloc/sign_in_event.dart';
import 'package:authentication/domain/entity/body/auth_request_entity.dart';
import 'package:common/utils/constants/app_constants.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:component/widget/base/base_navigator.dart';
import 'package:component/widget/button/custom_button.dart';
import 'package:component/widget/stack/loading_stack.dart';
import 'package:component/widget/text_field/custom_text_field.dart';
import 'package:component/widget/toast/custom_toast.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:resources/colors.gen.dart';

import '../bloc/sign_in_bloc/sign_in_bloc.dart';
import '../bloc/sign_in_bloc/sign_in_state.dart';

class SignInScreen extends StatelessWidget with BaseAuth {
  SignInScreen({Key? key}) : super(key: key);
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          final status = state.signInState.status;
          if (status.isHasData) {
            toHome();
            //Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
          }
          if (status.isError) {
            if (state.signInState.message != AppConstants.errorKey.username && state.signInState.message != AppConstants.errorKey.password) {
              CustomToast.showErrorToast(errorMessage: state.signInState.message);
            }
          }
        },
        builder: (context, state) {
          final status = state.signInState.status;

          return LoadingStack(
              isLoading: status.isLoading,
              widget: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  SizedBox(height: 124.h),
                  Text(
                    'Masuk',
                    style: TextStyle(color: ColorName.orange, fontSize: 30.sp, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 43.h,
                  ),
                  CustomTextField(
                    labelText: 'Username',
                    controller: usernameController,
                    errorText: state.signInState.message == AppConstants.errorKey.username ? state.signInState.failure!.errorMessage : "",
                    onChanged: (value) => context.read<SignInBloc>().add(UserNameChange(username: value)),
                    textInputType: TextInputType.name,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextField(
                    labelText: 'Password',
                    controller: passwordController,
                    obscureText: true,
                    errorText: state.signInState.message == AppConstants.errorKey.password ? state.signInState.failure!.errorMessage : "",
                    onChanged: (value) => context.read<SignInBloc>().add(PasswordChange(password: value)),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomButton(
                    buttonText: "Masuk",
                    onTap: () => context.read<SignInBloc>().add(
                          SignIn(
                            authRequestEntity: AuthRequestEntity(username: usernameController.text, password: passwordController.text),
                          ),
                        ),
                  ),
                  SizedBox(
                    height: 43.h,
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Belum punya akun ? ',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorName.textLightGrey,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Daftar',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: ColorName.textBlack,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () => toSignUp(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 84.h,
                  )
                ],
              ));
        },
      ),
    );
  }
}
