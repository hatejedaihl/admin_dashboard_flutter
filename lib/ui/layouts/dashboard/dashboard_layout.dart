import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/ui/shared/navbar.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/shared/sidebar.dart';

class DashboarLayout extends StatefulWidget {
  final Widget child;

  const DashboarLayout({
    super.key,
    required this.child,
  });

  @override
  State<DashboarLayout> createState() => _DashboarLayoutState();
}

class _DashboarLayoutState extends State<DashboarLayout> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SideMenuProvider.menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300)
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffedf1f2),
      body: Stack(
        children: [
          Row(
            children: [
              if (size.width >= 700) ...[
                const Sidebar(),
              ],
              Expanded(
                child: Column(
                  children: [
                    // Navbar
                    const Navbar(),

                    // View
                    Expanded(
                      child: Container(
                      // child: Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: widget.child,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (size.width < 700) ...[
            AnimatedBuilder(
              animation: SideMenuProvider.menuController,
              builder: (context, _) => Stack(
                children: [
                  // TODO: Background
                  if(SideMenuProvider.isOpen) ...[
                    AnimatedOpacity(
                      opacity: SideMenuProvider.opacity.value,
                      duration: const Duration(milliseconds: 100),
                      child: GestureDetector(
                        onTap: () => SideMenuProvider.closeMenu(),
                        child: Container(
                          width: size.width,
                          height: size.height,
                          color: Colors.black26,
                        ),
                      ),
                    )
                  ],
                  Transform.translate(
                    offset: Offset(SideMenuProvider.movement.value, 0),
                    child: const Sidebar(),
                  )
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }
}
