import 'package:flutter/material.dart';
import 'package:app_postsalud/widgets/reusable_popup_menu_item_app_bar.dart';

class ReusableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String userName;
  final List<Widget> actions;
  final List<ReusablePopupMenuItem> popupMenuItems;

  const ReusableAppBar({
    Key? key,
    required this.title,
    required this.userName,
    this.actions = const [],
    required this.popupMenuItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color.fromRGBO(40, 157, 137, 1),
      title: Row(
        children: [
          SizedBox(
            width: 20,
            child: MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                showMenu(
                  menuPadding: EdgeInsets.symmetric(horizontal: 0),
                  color: Color.fromRGBO(40, 157, 137, 1),
                  context: context,
                  position: const RelativeRect.fromLTRB(0, 110, 0, 50),
                  items: popupMenuItems,
                );
              },
              child: const Icon(Icons.menu, size: 20),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'Hola, ',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
