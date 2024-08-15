import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/dimentions.dart';
import 'package:note_app/core/route_utils/route_utils.dart';
import 'package:note_app/core/validate_utils.dart';
import 'package:note_app/features/login/cubit.dart';
import 'package:note_app/features/login/state.dart';
import 'package:note_app/features/sign_up/view.dart';
import 'package:note_app/widget/app/app_aapbar.dart';
import 'package:note_app/widget/app/app_button.dart';
import 'package:note_app/widget/app/app_colors.dart';
import 'package:note_app/widget/app/app_text.dart';
import 'package:note_app/widget/app/app_text_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        appBar: const AppAppBar(
          title: 'Note App',
        ),
        body: Builder(builder: (context) {
          final cubit = BlocProvider.of<LoginCubit>(context);
          return Form(
            key: cubit.formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                SizedBox(
                  height: 32.height,
                ),
                const AppText(
                  title: 'Note App',
                  textAlign: TextAlign.center,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: 48.height,
                ),
                const AppText(
                  title: 'Login',
                  textAlign: TextAlign.center,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 64.height,
                ),
                AppTextField(
                  hint: 'Email',
                  onSaved: (v) => cubit.email = v,
                  validator: ValidateUtils.email,
                ),
                const Divider(
                  height: 20,
                  color: AppColors.gray,
                ),
                AppTextField(
                  hint: 'Password',
                  onSaved: (v) => cubit.password = v,
                  validator: ValidateUtils.password,
                ),
                SizedBox(
                  height: 64.height,
                ),
                BlocBuilder<LoginCubit, LoginStates>(
                  builder: (context, state) {
                    return AppButton(
                      title: 'Login',
                      isLoading: state is LoginLoading,
                      onTap: cubit.login,
                    );
                  },
                ),
                SizedBox(
                  height: 48.height,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppText(
                      title: 'Do not have an account!',
                      color: AppColors.gray,
                    ),
                    SizedBox(
                      width: 4.width,
                    ),
                    AppText(
                      title: 'Sign up!',
                      textDecoration: TextDecoration.underline,
                      onTap: () => RouteUtils.push(
                        const SignUpView(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
