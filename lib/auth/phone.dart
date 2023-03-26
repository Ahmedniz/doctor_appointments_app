// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

import '../data/countires.dart';
import 'otp.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({Key? key}) : super(key: key);

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController phoneNumberCtrl = TextEditingController();
  String initialCode = '+92';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Row(
                  children: [
                    DecoratedBox(
                      decoration: const ShapeDecoration(
                        shape: const RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          borderRadius: BorderRadius.circular(5),
                          value: initialCode,
                          items: countriesItem,
                          onChanged: (String? newValue) {
                            setState(() {
                              initialCode = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter phone number';
                          } else if (initialCode == '+92' && value.length != 10) {
                            return 'Invalid phone number';
                          } else if (initialCode == '+91' && value.length != 10) {
                            return 'Invalid phone number';
                          } else if (initialCode == '+880' && value.length != 10) {
                            return 'Invalid phone numberr';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: '3021234567',
                          label: Text('Phone'),
                        ),
                        controller: phoneNumberCtrl,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: ElevatedButton(
                        onPressed: () {
                          _otpSend();
                        },
                        child: const Text('Get OTP')),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _otpSend() {
    final isValidForm = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if (isValidForm == true) {
      _formKey.currentState!.save();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(
            phoneNumber: '$initialCode${phoneNumberCtrl.text}',
          ),
        ),
      );
    }
  }
}
