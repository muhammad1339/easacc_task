import 'package:flutter/cupertino.dart';

abstract class SocialSignInCallback {
  void onSocialSignInSuccess(
    String message, {
    required BuildContext context,
    String? email,
    String? name,
    String? imageUrl,
  });

  void onSocialSignInFailure(
    String message, {
    required BuildContext context,
  });
}
