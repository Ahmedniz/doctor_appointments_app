import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.phoneNumber}) : super(key: key);
  final String phoneNumber;
  @override
  // ignore: library_private_types_in_public_api
  _OtpScreenState createState() => _OtpScreenState();

  @override
  String toStringShort() => 'Rounded Filled';
}

class _OtpScreenState extends State<OtpScreen> {
  final pinCode = TextEditingController();
  final focusNode = FocusNode();

  String _verficationCode = '';
  int? _resendVerficationCode;

  FirebaseAuth auth = FirebaseAuth.instance;

  int secondsRemaining = 60;
  bool enableResend = false;
  Timer? timer;

  @override
  void dispose() {
    pinCode.dispose();
    focusNode.dispose();
    timer!.cancel();
    super.dispose();
  }

  bool showError = false;

  @override
  Widget build(BuildContext context) {
    const length = 6;
    const borderColor = Color.fromRGBO(114, 178, 238, 1);
    const errorColor = Color.fromRGBO(255, 234, 238, 1);
    const fillColor = Color.fromRGBO(222, 231, 240, .57);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: GoogleFonts.poppins(
        fontSize: 22,
        color: const Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Phone'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Verification code is sent to ${widget.phoneNumber}',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: SizedBox(
              height: 68,
              child: Pinput(
                length: length,
                controller: pinCode,
                focusNode: focusNode,
                defaultPinTheme: defaultPinTheme,
                androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
                onCompleted: (pin) {
                  setState(() => showError = pin != '5555');
                },
                onSubmitted: (pin) async {
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(
                      PhoneAuthProvider.credential(verificationId: _verficationCode, smsCode: pin),
                    )
                        .then((value) {
                      final userName = FirebaseAuth.instance.currentUser!.displayName == null;

                      if (value.user != null) {
                        if (userName) {
                          Navigator.pushNamed(context, '/');
                        } else {
                          Navigator.pushReplacementNamed(context, '/phoneAuthPage');
                        }
                      }
                    });
                  } on Exception {
                    FocusScope.of(context).unfocus();
                  }
                },
                focusedPinTheme: defaultPinTheme.copyWith(
                  height: 68,
                  width: 64,
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: borderColor),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyWith(
                  decoration: BoxDecoration(
                    color: errorColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: [
                !enableResend
                    ? const TextSpan(text: 'Resend code ')
                    : TextSpan(
                        text: 'Resend code',
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _verifyPhone();
                            setState(() {
                              enableResend = false;
                              secondsRemaining = 60;
                            });
                          },
                      ),
                if (!enableResend) TextSpan(text: 'in $secondsRemaining seconds')
              ],
            ),
          ),
          // const Text(
          //   'Did not recive verifcation code? Resend again.',
          //   style: TextStyle(
          //     fontSize: 20,
          //   ),
          // ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance
                          .signInWithCredential(PhoneAuthProvider.credential(verificationId: _verficationCode, smsCode: pinCode.text))
                          .then((value) {
                        final userName = FirebaseAuth.instance.currentUser!.displayName == null;

                        if (value.user != null) {
                          if (userName) {
                            Navigator.pushNamed(context, '/');
                          } else {
                            Navigator.pushReplacementNamed(context, '/phoneAuthPage');
                          }
                        }
                      });
                    } on Exception {
                      FocusScope.of(context).unfocus();
                    }
                  },
                  child: const Text('Verify'),
                ),
              )),
            ],
          )
        ],
      ),
    );
  }

  _verifyPhone() async {
    await auth.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) {
            final userName = FirebaseAuth.instance.currentUser!.displayName == null;

            if (value.user != null) {
              if (userName) {
                Navigator.pushNamed(context, '/');
              } else {
                Navigator.pushReplacementNamed(context, '/phoneAuthPage');
              }
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verficationCode = verificationId;
            _resendVerficationCode = resendToken;
          });
        },
        codeAutoRetrievalTimeout: (String verficationId) {
          setState(() {
            _verficationCode = verficationId;
          });
        },
        timeout: const Duration(seconds: 60),
        forceResendingToken: _resendVerficationCode);
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
    _verifyPhone();
  }
}
