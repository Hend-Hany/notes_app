import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/caching_utils.dart';
import 'package:note_app/core/network_utils.dart';
import 'package:note_app/core/route_utils/route_utils.dart';
import 'package:note_app/features/home/veiw.dart';
import 'package:note_app/features/login/state.dart';
import 'package:note_app/widget/app/snack_bar.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInit());

  final formKey = GlobalKey<FormState>();
  String? email, password;

  Future<void> login() async {
    formKey.currentState!.save();
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(LoginLoading());
    try {
      final response = await NetworkUtils.post('auth/login', data: {
        "email": email,
        'password': password,
      });
      await CachingUtils.cacheUser(response.data);
      RouteUtils.pushAndPopAll(HomeView());
    } on DioException catch (e) {
      showSnackBar(
        e.response?.data['message'] ?? '',
        error: true,
      );
    }
    emit(LoginInit());
  }
}
