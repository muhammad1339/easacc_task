import 'package:easacc_task/screens/settings/cubit/settings_cubit.dart';
import 'package:easacc_task/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit()..listMulticastDevices(),
      child: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = context.read<SettingsCubit>();
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Settings',
                  style: KAppTextStyle.regularTextStyle.copyWith(
                    fontSize: 20.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              body: ListView(
                padding: EdgeInsets.all(16.r),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText: 'url',
                            hintText: 'Enter url',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                          controller: cubit.urlController,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cubit.goToWebView(
                            context,
                            onErrorMessage: (message) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    message,
                                    style: KAppTextStyle.regularTextStyle.copyWith(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                      ),
                    ],
                  ),
                ],
              ));
        },
      ),
    );
  }
}
