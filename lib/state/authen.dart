import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitorproduct/state/create_new_account.dart';
import 'package:monitorproduct/widget/widget_button.dart';
import 'package:monitorproduct/widget/widget_form.dart';
import 'package:monitorproduct/widget/widget_image.dart';
import 'package:monitorproduct/widget/widget_text.dart';
import 'package:monitorproduct/widget/widget_text_button.dart';

class Authen extends StatelessWidget {
  const Authen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          children: [
            displayHead(context),
            makeCenter(
                widget: WidgetForm(
              hint: 'Email :',
              suffixWidget: Icon(Icons.contact_mail_outlined),
            )),
            makeCenter(
                widget: WidgetForm(
              hint: 'Password :',
              suffixWidget: Icon(Icons.lock_outline),
            )),
            makeCenter(
                widget: WidgetButton(
              label: 'Login',
              pressFunc: () {},
            )),
            makeCenter(
                widget: WidgetTextButton(
              label: 'Create New Account',
              pressFunc: () {
                Get.to(const CreateNewAccount());
              },
            ))
          ],
        ),
      ),
    );
  }

  Row makeCenter({required Widget widget}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          width: 250,
          child: widget,
        ),
      ],
    );
  }

  Row displayHead(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 80, bottom: 16),
          width: 250,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: const WidgetImage(
                  size: 50,
                ),
              ),
              WidgetText(
                data: 'Monitor\nProduct',
                textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: const Color.fromARGB(255, 101, 17, 196),
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    );
  }
}
