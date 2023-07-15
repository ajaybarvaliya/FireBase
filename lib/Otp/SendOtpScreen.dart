import 'package:firebase/Otp/VerifyOtpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Sendotpscreen extends StatefulWidget {
  const Sendotpscreen({Key? key}) : super(key: key);

  @override
  State<Sendotpscreen> createState() => _SendotpscreenState();
}

class _SendotpscreenState extends State<Sendotpscreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  String number = '';
  String code = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IntlPhoneField(
              decoration: InputDecoration(
                constraints: BoxConstraints(maxWidth: 350),
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              onChanged: (phone) {
                setState(() {
                  number = phone.number;
                  print('Country changed to: ' + phone.number);
                });
              },
              onCountryChanged: (country) {
                setState(() {
                  code = country.dialCode;
                });
                print('Country changed to: ' + country.code);
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                auth.verifyPhoneNumber(
                  phoneNumber: '+$code $number',
                  verificationCompleted:
                      (PhoneAuthCredential phoneAuthCredential) {
                    print('DONE');
                  },
                  codeSent: (String verificationId, int? forceResendingToken) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => verifyotpscreens(
                          id: verificationId,
                          number: '+$code $number',
                          token: forceResendingToken!,
                        ),
                      ),
                    );
                  },
                  verificationFailed: (FirebaseAuthException error) {
                    print('FAILD');
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {
                    print('TIMEOUT');
                  },
                );
              },
              child: Text("Send Otp"),
            )
          ],
        ),
      ),
    );
  }
}
