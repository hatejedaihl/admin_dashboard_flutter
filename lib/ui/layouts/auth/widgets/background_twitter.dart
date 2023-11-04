import 'package:flutter/material.dart';

class BackgroundTwitter extends StatelessWidget {
  const BackgroundTwitter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildBoxDecoration(),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 60),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: const Image(
                image: AssetImage('twitter-white-logo.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }


  BoxDecoration buildBoxDecoration() {
    return const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('twitter-bg.png'),
          fit: BoxFit.cover,
        )
      );
  }
}