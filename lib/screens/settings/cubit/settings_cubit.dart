
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easacc_task/config/routing/k_routes.dart';
import 'package:easacc_task/core/extension/context_extensions.dart';
import 'package:easacc_task/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial()) {
    urlController.text = 'https://www.';
  }

  final urlController = TextEditingController();

  void goToWebView(
    BuildContext context, {
    required Function(String) onErrorMessage,
  }) async {
    logger.i('goToWebView ${urlController.text}');
    if (urlController.text.isNotEmpty) {
      // bool isLaunched = await launchUrl(
      //   Uri.parse(urlController.text),
      // );
      // if (!isLaunched) {
      //   onErrorMessage('Please enter a valid url');
      // }
      context.navNamedTo(KAppRoutes.webView,args: urlController.text);
      emit(CanGoToWeb());
    } else {
      onErrorMessage('Please enter a valid url');
    }
  }

  Future<void> listMulticastDevices() async {
    await (NetworkInfo().getWifiIP()).then(
          (ip) async {
        final String subnet = ip!.substring(0, ip.lastIndexOf('.'));
        const port = 22;
        for (var i = 0; i < 256; i++) {
          String ip = '$subnet.$i';
          print(ip);
          await Socket.connect(ip, port, timeout: Duration(milliseconds: 100))
              .then((socket) async {
            await InternetAddress(socket.address.address)
                .reverse()
                .then((value) {
              print(value.host);
              print(socket.address.address);
            }).catchError((error) {
              print(socket.address.address);
              print('Error: $error');
            });
            socket.destroy();
          }).catchError((error) => null);
        }
      },
    );
    print('Done');
  }
}
