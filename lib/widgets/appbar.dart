import 'package:flutter/material.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title; // Changed from String to Widget
  final IconData? leadingIcon;
  final List<Widget>? actions;

  const Appbar({
    super.key,
    required this.title, // Now expects a Widget
    this.leadingIcon,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: AppBar(
        title: title, // Use the provided title widget directly
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 2,
        leading: leadingIcon != null
            ? Container(
                margin: const EdgeInsets.all(10),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.red,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(leadingIcon, color: Colors.blue),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              )
            : null,
        actions: actions ??
            [
              Container(
                margin: const EdgeInsets.all(10),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.red,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Badge(
                      alignment: Alignment.topRight,
                      label: const Center(
                        child: Text(
                          '3',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      child: IconButton(
                        icon:
                            const Icon(Icons.notifications, color: Colors.blue),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          Navigator.pushNamed(context, '/notifications');
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
      ),
    );
  }
}
