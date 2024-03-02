import 'package:bloc/bloc.dart';
import 'package:easacc_task/screens/login/cubit/social_signin_callback.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../utils/logger.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

part 'login_state.dart';

List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: scopes,
  );

  bool isFacebookLoginInProgress = false;
  bool isGoogleLoginInProgress = false;

  Future<void> facebookLogin(
    SocialSignInCallback socialSignInCallback,
    BuildContext context,
  ) async {
    try {
      isFacebookLoginInProgress = true;
      emit(FacebookLoginInProgress());

      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        isFacebookLoginInProgress = false;
        final AccessToken? accessToken = result.accessToken;
        logger.i('Access Token: ${accessToken?.token}');
        Future.delayed(Duration.zero, () {
          socialSignInCallback.onSocialSignInSuccess(
            result.message ?? '',
            context: context,
          );
        });
        emit(FacebookLoginSuccess());
      } else {
        isFacebookLoginInProgress = false;
        logger.e('Facebook login failed');
        Future.delayed(Duration.zero, () {
          socialSignInCallback.onSocialSignInFailure(
            result.message ?? '',
            context: context,
          );
        });

        emit(FacebookLoginFailure('Facebook login failed'));
      }
    } catch (e, s) {
      isFacebookLoginInProgress = false;
      logger
        ..e(e.toString())
        ..e(s.toString());
      Future.delayed(Duration.zero, () {
        socialSignInCallback.onSocialSignInFailure(
          e.toString(),
          context: context,
        );
      });
      emit(FacebookLoginFailure(e.toString()));
    }
  }

  Future<void> googleLogin(
    SocialSignInCallback socialSignInCallback,
    BuildContext context,
  ) async {
    try {
      isGoogleLoginInProgress = true;
      emit(GoogleLoginInProgress());
      googleSignIn.signIn().then((value) {
        isGoogleLoginInProgress = false;

        logger.i('Google login success ${value?.email}');
        socialSignInCallback.onSocialSignInSuccess(
          'Hello ${value?.displayName}',
          context: context,
          email: value?.email,
          name: value?.displayName,
          imageUrl: value?.photoUrl,
        );
        emit(GoogleLoginSuccess());
      }).catchError((e) {
        isGoogleLoginInProgress = false;
        logger.e('Google login failed');
        socialSignInCallback.onSocialSignInFailure(
          e.toString(),
          context: context,
        );
        emit(GoogleLoginFailure('Google login failed ${e.toString()}'));
      });
    } catch (e, s) {
      logger
        ..e(e.toString())
        ..e(s.toString());
      socialSignInCallback.onSocialSignInFailure(
        e.toString(),
        context: context,
      );
      emit(GoogleLoginFailure(e.toString()));
    }
  }
}
