import 'package:flutter/material.dart';
import 'package:forms_validators/UI/inputs_decorations.dart';
import 'package:forms_validators/providers/login_form_provider.dart';
import 'package:forms_validators/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text("Login", style: Theme.of(context).textTheme.headline4),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: _LogginForm(),
                    ),
                    // const _LogginForm()
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                "Crear nueva cuenta",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogginForm extends StatelessWidget {
  const _LogginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    void ingresar() async {
      FocusScope.of(context).unfocus();
      if (loginForm.isValidForm() == false) return;
      // valid if login is correct
      loginForm.isLoading = true;
      await Future.delayed(const Duration(seconds: 2));
      loginForm.isLoading = false;
      Navigator.pushReplacementNamed(context, 'homeScreen');
    }

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputsDecorations.authInputDecoration(
                hintText: "ejemplo@email.com",
                labelText: "Email",
                prefixIcon: Icons.alternate_email_rounded,
              ),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
                bool isCorrect = regExp.hasMatch(value ?? '');
                return isCorrect ? null : "email is not correct";
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputsDecorations.authInputDecoration(
                labelText: "Pass",
                hintText: "pass123",
                prefixIcon: Icons.password,
              ),
              onChanged: (value) => loginForm.pass = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : "pass should must be more than 6 characters";
              },
            ),
            const SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              color: Colors.deepPurple,
              elevation: 0,
              onPressed: loginForm.isLoading
                  ? null
                  : () {
                      ingresar();
                    },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 15,
                ),
                child: Text(
                  loginForm.isLoading ? "Espere..." : "Ingresar",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
