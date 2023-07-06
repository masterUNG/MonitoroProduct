// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:monitorproduct/widget/widget_image.dart';
import 'package:monitorproduct/widget/widget_text.dart';
import 'package:monitorproduct/widget/widget_text_button.dart';

class AppDialog {
  final BuildContext context;
  AppDialog({
    required this.context,
  });

  void normalDialog({
    required String title,
    Widget? firstAction,
    bool? showCancel,
  }) {
    bool cancel = showCancel ?? true;
    Get.dialog(
      AlertDialog(
        icon: const WidgetImage(
          size: 100,
        ),
        title: WidgetText(data: title),
        actions: [
          firstAction ?? const SizedBox(),
          cancel ? WidgetTextButton(
            label: 'Cancel',
            pressFunc: () => Get.back(),
          ) : const SizedBox(),
        ],
      ),
    );
  }
}
