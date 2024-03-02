import 'package:easacc_task/core/extension/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/app_text_styles.dart';

class WebviewScreen extends StatelessWidget {
  WebviewScreen({super.key});

  final WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.

        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {

          return NavigationDecision.navigate;
        },
      ),
    );

  @override
  Widget build(BuildContext context) {
    final args = context.getArgs() as String?;
    controller.loadRequest(Uri.parse(args ?? 'https://www.google.com'));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Webview',
          style: KAppTextStyle.regularTextStyle.copyWith(
            fontSize: 20.sp,
            color: Colors.black,
          ),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
