import 'package:easacc_task/core/extension/context_extensions.dart';
import 'package:easacc_task/core/res/assets.dart';
import 'package:easacc_task/core/res/colors.dart';
import 'package:easacc_task/core/widgets/customs/loading_widget.dart';
import 'package:easacc_task/screens/login/cubit/social_signin_callback.dart';
import 'package:easacc_task/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/routing/k_routes.dart';
import '../../../core/widgets/customs/zero_height_appbar.dart';
import '../cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget implements SocialSignInCallback {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          // if (state is FacebookLoginFailure) {
          //   showToast(context: context, message: state.message);
          // }
        },
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();
          return Scaffold(
            appBar: const ZeroHeightAppBar(),
            body: Center(
              child: cubit.isFacebookLoginInProgress || cubit.isGoogleLoginInProgress
                  ? const LoadingWidget()
                  : ListView(
                      padding: EdgeInsets.all(64.r),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        SvgPicture.asset(
                          KAppSvgs.logo,
                          height: 200.h,
                        ),
                        24.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                'Welcome to EASACC Task',
                                style: KAppTextStyle.boldTextStyle.copyWith(
                                  color: KAppColors.primaryColor,
                                  fontSize: 22.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        24.verticalSpace,
                        IconButton.outlined(
                          onPressed: () {
                            context.navNamedTo(KAppRoutes.settingsScreen);
                          },
                          icon: SvgPicture.asset(
                            KAppSvgs.settings,
                            height: 64.h,
                          ),
                        ),
                        64.verticalSpace,
                        SocialLoginButton(
                          text: 'Facebook Login',
                          svgIcon: KAppSvgs.facebookIcon,
                          onPressed: () async {
                            await context.read<LoginCubit>().facebookLogin(this, context);
                          },
                        ),
                        24.verticalSpace,
                        SocialLoginButton(
                          text: 'Google Login',
                          svgIcon: KAppSvgs.googleIcon,
                          onPressed: () {
                            context.read<LoginCubit>().googleLogin(this, context);
                          },
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  @override
  void onSocialSignInFailure(
    String message, {
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: KAppTextStyle.boldTextStyle.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  void onSocialSignInSuccess(
    String message, {
    required BuildContext context,
    String? email,
    String? name,
    String? imageUrl,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: KAppTextStyle.boldTextStyle.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.text,
    required this.svgIcon,
    required this.onPressed,
  });

  final String text;
  final String svgIcon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          16.horizontalSpace,
          Text(
            text,
            style: KAppTextStyle.boldTextStyle,
          ),
          16.horizontalSpace,
          SvgPicture.asset(
            svgIcon,
            height: 24.h,
          ),
          16.horizontalSpace,
        ],
      ),
    );
  }
}
