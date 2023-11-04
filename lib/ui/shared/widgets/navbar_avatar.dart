import 'package:flutter/material.dart';


class NavbarAvatar extends StatelessWidget {
  const NavbarAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        child: Image.asset('pictore_profile.jpeg'),
        width: 30,
        height: 30,
      ),
    );
  }
}