import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitorproduct/model/user_model.dart';
import 'package:monitorproduct/utility/app_controller.dart';
import 'package:monitorproduct/utility/app_service.dart';
import 'package:monitorproduct/utility/app_snackbar.dart';
import 'package:monitorproduct/widget/widget_button.dart';
import 'package:monitorproduct/widget/widget_form.dart';
import 'package:monitorproduct/widget/widget_text.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({super.key});

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  AppController appController = Get.put(AppController());

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AppService().readAllTypeUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const WidgetText(data: 'Create New Account'),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          children: [
            makeCenter(
                widget: WidgetForm(
              hint: 'Display Name :',
              textEditingController: nameController,
            )),
            makeCenter(widget: Obx(() {
              return appController.typeUserModels.isEmpty
                  ? const SizedBox()
                  : DropdownButton(
                      items: appController.typeUserModels
                          .map(
                            (element) => DropdownMenuItem(
                              child: WidgetText(data: element.typeuser),
                              value: element.typeuser,
                            ),
                          )
                          .toList(),
                      isExpanded: true,
                      hint: const WidgetText(data: 'Please Choose Type User'),
                      value: appController.chooseTypeUsers.last,
                      onChanged: (value) {
                        appController.chooseTypeUsers.add(value);
                      },
                    );
            })),
            makeCenter(
                widget: WidgetForm(
              hint: 'Email :',
              textEditingController: emailController,
            )),
            makeCenter(
                widget: WidgetForm(
              hint: 'Password :',
              textEditingController: passwordController,
            )),
            makeCenter(
                widget: WidgetButton(
              label: 'Create New Account',
              pressFunc: () {
                if ((nameController.text.isEmpty) ||
                    (emailController.text.isEmpty) ||
                    (passwordController.text.isEmpty)) {
                  AppSnackBar(
                          title: 'Have Space ?',
                          message: 'Please Fill Every Blank')
                      .errorSnackbar();
                } else if (appController.chooseTypeUsers.last == null) {
                  AppSnackBar(
                          title: 'Type User ?',
                          message: 'Please Choose Type User')
                      .errorSnackbar();
                } else {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text)
                      .then((value) async {
                    String uid = value.user!.uid;
                    print('uid ที่ได้จากการ Create new Account ---> $uid');

                    UserModel userModel = UserModel(
                        email: emailController.text,
                        name: nameController.text,
                        password: passwordController.text,
                        typeuser: appController.chooseTypeUsers.last!,
                        uid: uid);

                    await FirebaseFirestore.instance
                        .collection('user')
                        .doc(uid)
                        .set(userModel.toMap())
                        .then((value) {
                      Get.back();
                      AppSnackBar(
                              title: 'Create New User Success',
                              message: 'Please Login')
                          .normalSnackbar();
                    });
                  }).catchError((onError) {
                    AppSnackBar(title: onError.code, message: onError.message)
                        .errorSnackbar();
                  });
                }
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
}
