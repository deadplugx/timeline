import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeMenuBar extends StatelessWidget {
  const HomeMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor, width: 1),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 10,
            top: 8,
            width: 48,
            height: 48,
            child: IconButton(
              tooltip: 'Menu',
              padding: EdgeInsets.zero,
              icon: Image.asset(
                'assets/icons/iconHamburger.png',
                fit: BoxFit.contain,
              ),
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "pososi",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: const Color(0xFF3B2121),
                  textColor: const Color(0xFFE9DFDF),
                  fontSize: 16.0,
                );
              },
            ),
          ),
          Positioned(
            right: 32,
            top: 8,
            width: 48,
            height: 48,
            child: IconButton(
              tooltip: 'Inbox',
              padding: EdgeInsets.zero,
              icon: Image.asset(
                'assets/icons/iconInbox.png',
                width: 32,
                height: 24,
                fit: BoxFit.contain,
              ),
              onPressed: () {
                Fluttertoast.showToast(
                  msg: 'null',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
