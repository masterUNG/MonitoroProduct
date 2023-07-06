import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitorproduct/model/user_model.dart';
import 'package:monitorproduct/state/create_new_account.dart';
import 'package:monitorproduct/utility/app_snackbar.dart';
import 'package:monitorproduct/widget/widget_button.dart';
import 'package:monitorproduct/widget/widget_form.dart';
import 'package:monitorproduct/widget/widget_image.dart';
import 'package:monitorproduct/widget/widget_text.dart';
import 'package:monitorproduct/widget/widget_text_button.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
              suffixWidget: const Icon(Icons.contact_mail_outlined),
              textEditingController: emailController,
            )),
            makeCenter(
                widget: WidgetForm(
              hint: 'Password :',
              suffixWidget: const Icon(Icons.lock_outline),
              textEditingController: passwordController,
            )),
            makeCenter(
                widget: WidgetButton(
              label: 'Login',
              pressFunc: () async {
                if ((emailController.text.isEmpty) ||
                    (passwordController.text.isEmpty)) {
                  AppSnackBar(
                          title: 'Have Space ?',
                          message: 'Please Fill Every Blank')
                      .errorSnackbar();
                } else {
                  await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text)
                      .then((value) async {
                    await FirebaseFirestore.instance
                        .collection('user')
                        .doc(value.user!.uid)
                        .get()
                        .then((value) {
                      UserModel userModel = UserModel.fromMap(value.data()!);

                      print('## typeUser --->/${userModel.typeuser}');

                      Get.offAllNamed('/${userModel.typeuser}');
                      AppSnackBar(
                              title: 'Welcome ${userModel.name}',
                              message: 'Have a Good Day')
                          .normalSnackbar();
                    });
                  }).catchError((onError) {
                    AppSnackBar(title: onError.code, message: onError.message)
                        .errorSnackbar();
                  });
                }
              },
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
