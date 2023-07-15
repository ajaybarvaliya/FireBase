import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class verifyotpscreens extends StatefulWidget {
  const verifyotpscreens(
      {Key? key, required this.id, required this.number, required this.token})
      : super(key: key);
  final String id;
  final String number;
  final int token;

  @override
  State<verifyotpscreens> createState() => _verifyotpscreensState();
}

class _verifyotpscreensState extends State<verifyotpscreens> {
  bool isvisible = true;

  int second = 30;

  Timer? timer;

  void time() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(() {});
        second--;
        if (second == 0) {
          timer.cancel();
        }
      },
    );
  }

  initState() {
    super.initState();
    time();
  }

  OtpFieldController otpController = OtpFieldController();
  String otp = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${widget.number}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          OTPTextField(
              controller: otpController,
              length: 6,
              width: MediaQuery.of(context).size.width,
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldWidth: 45,
              fieldStyle: FieldStyle.box,
              outlineBorderRadius: 15,
              style: TextStyle(fontSize: 17),
              onChanged: (pin) {
                print("Changed: " + pin);
                otp = pin;
                setState(() {});
              },
              onCompleted: (pin) {
                timer!.cancel();
                print("Completed: " + pin);
              }),
          SizedBox(
            height: 30,
          ),
          second == 0
              ? InkResponse(
                  onTap: () {
                    auth.verifyPhoneNumber(
                        phoneNumber: '${widget.number}',
                        verificationCompleted:
                            (PhoneAuthCredential phoneAuthCredential) {
                          print('DONE');
                        },
                        codeSent:
                            (String verificationId, int? forceResendingToken) {
                          second = 30;
                          setState(() {});
                          time();
                        },
                        verificationFailed: (FirebaseAuthException error) {
                          print('FAILD');
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {
                          print('TIMEOUT');
                        },
                        forceResendingToken: widget.token);
                  },
                  child: Text(
                    "Resend otp",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              : Text(
                  "Resend otp in${second}",
                  style: TextStyle(fontFamily: "Poppins", color: Colors.black),
                ),
          SizedBox(
            height: 30,
          ),
          Visibility(
            visible: second == 0 ? !isvisible : isvisible,
            child: ElevatedButton(
              onPressed: () async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: widget.id, smsCode: otp);

                UserCredential credentials =
                    await auth.signInWithCredential(credential);

                print("${credentials.user!.uid}");
                print("${credentials.user!.phoneNumber}");

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Center(
                      child: Text("Done"),
                    ),
                  ),
                );
              },
              child: Text("Verify otp"),
            ),
          ),
        ],
      ),
    );
  }
}
