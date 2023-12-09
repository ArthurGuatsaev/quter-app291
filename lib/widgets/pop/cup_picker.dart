import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quotex291/widgets/close_button.dart';

showSheet(BuildContext context) {
  return showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return Material(
        child: Container(
          color: const Color(0xFF282C3A),
          height: 400,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 12, top: 20, right: 12, bottom: 40),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Difficulty selection',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                  VCloseButton()
                ],
              ),
              const SizedBox(height: 25),
              SheetItem(title: 'Easy', time: '30:00', func: () {}),
              const SizedBox(height: 10),
              SheetItem(title: 'Average', time: '15:00', func: () {}),
              const SizedBox(height: 10),
              SheetItem(title: 'Difficult', time: '10:00', func: () {}),
              const SizedBox(height: 10),
              SheetItem(title: 'Custom', time: '', func: () {}),
            ]),
          ),
        ),
      );
    },
  );
}

class SheetItem extends StatelessWidget {
  final String title;
  final String time;
  final Function() func;
  const SheetItem({
    super.key,
    required this.title,
    required this.time,
    required this.func,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: Colors.transparent,
      child: InkWell(
        onTap: func,
        child: SizedBox(
          height: 52,
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white.withOpacity(0.15)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(children: [
                Expanded(
                    child: Text(title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16))),
                Text(time,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14)),
                const SizedBox(width: 10),
                Icon(
                  Icons.navigate_next,
                  color: Colors.white.withOpacity(0.4),
                  size: 30,
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
