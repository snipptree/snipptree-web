import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:snippet/common/app_constants.dart';
import 'package:snippet/domain/models/user.dart';
import 'package:snippet/domain/usecases/home_usecase.dart';
import 'package:snippet/ui/home/home_controller.dart';

class GoogleSignInButton extends StatefulWidget {
  final HomeController controller;

  const GoogleSignInButton({super.key, required this.controller});

  @override
  GoogleSignInButtonState createState() => GoogleSignInButtonState();
}

class GoogleSignInButtonState extends State<GoogleSignInButton> {
  @override
  void initState() {
    super.initState();
    widget.controller.googleSignIn.value = GoogleSignIn(
      clientId: AppConstants.googleSignInOAuthClientId,
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
  }

  Future<void> signInWithGoogle() async {
    HomeUseCase useCase = HomeUseCase();
    //widget.controller.googleSignIn.value?.signInSilently()
    widget.controller.gUser.value = await widget.controller.googleSignIn.value?.signIn();
    if (widget.controller.gUser.value?.email.isNotEmpty == true) {
      User user = useCase.getUserData(widget.controller.gUser.value);
      widget.controller.authenticateUser(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 12)),
      ),
      onPressed: signInWithGoogle,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 16),
            Image.asset(
              'assets/images/google_logo.png', // Add a Google logo in your assets
              height: 24,
            ),
            const SizedBox(width: 10),
            const Text(
              'Sign in with Google',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
