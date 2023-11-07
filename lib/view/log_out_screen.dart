import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LogOutScreen extends StatelessWidget {
  const LogOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              onTap: (){},
              decoration: InputDecoration(
                //suffixText: suffixText,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.green, width: 1),
                ),
                hintText: "Ahmed",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFFD7D9E0),
                suffixIcon: Icon(Icons.abc_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
