import 'package:cdp_app/Company/ui/screens/VerifyEmailScreen/widgets/cancel_verification_button.dart';
import 'package:cdp_app/Company/ui/screens/VerifyEmailScreen/widgets/resend_email_button.dart';
import 'package:cdp_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: const CancelVerificationButton(),
      ),
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Center(
          child: Column(
            children: [
              const Text(
                "¡Bienvenido a CDPApp!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: defaultPadding / 2),
              Text(
                "Verifica el correo electronico que enviamos a ${auth.currentUser!.email!} para continuar.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: defaultPadding / 2),
              const Text(
                " Al verificar tu direccion de correo electronico esta pantalla se actualizara automaticamente.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: defaultPadding * 2),
              const ResendEmailButton(),
            ],
          ),
        ),
      ),
    );
  }
}
