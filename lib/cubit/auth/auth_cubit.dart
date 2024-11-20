import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales/cubit/auth/auth_state.dart';
import 'package:sales/repositories/auth/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  AuthCubit({required this.authRepository}) : super(AuthInitialState());

// login cubit
  login(Map<String, dynamic> params, bool rememberMe) async {
    emit(AuthLoadingState());
    try {
      var result = await authRepository.login(params, rememberMe);
      result.fold(
        (failure) {
          emit(AuthErrorState(failure.message));
        },
        ((response) {
          return emit(LoginSuccessState(response));
        }),
      );
    } catch (err) {
      emit(AuthErrorState(err.toString()));
    }
  }
}
