import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotex291/history/domain/bloc/history_bloc.dart';
import 'package:quotex291/nav_manager.dart';
import 'package:quotex291/posts/view/bloc/post_bloc.dart';
import 'package:quotex291/product/domain/bloc/prod_bloc.dart';

Future<void> showMyIosResetDataPop(BuildContext context) {
  return showCupertinoDialog(
    context: context,
    useRootNavigator: false,
    builder: (context) {
      return Theme(
        // Wrap the Cupertino dialog with a Material theme
        data: Theme.of(context).copyWith(
          platform: TargetPlatform.iOS,
        ),
        child: CupertinoAlertDialog(
          content: const Column(children: [
            Text(
              'Reset all progress',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 5),
            Text(
              'Are you sure you want to reset your progress? It will be permanently deleted',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ]),
          actions: [
            CupertinoDialogAction(
                onPressed: () => MyNavigatorManager.instance.simulatorPop(),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                )),
            CupertinoDialogAction(
                onPressed: () {
                  context.read<HistoryBloc>().add(ReseteHistoryEvent());
                  context.read<ProdBloc>().add(ResetProductEvent());
                  context.read<PostBloc>().add(ResetNoteEvent());
                  MyNavigatorManager.instance.simulatorPop();
                },
                child: const Text(
                  'Reset',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                )),
          ],
        ),
      );
    },
  );
}

Future<void> showErrorPop(
  BuildContext context,
  String message,
) {
  return showCupertinoDialog(
    context: context,
    useRootNavigator: false,
    builder: (context) {
      return Theme(
        // Wrap the Cupertino dialog with a Material theme
        data: Theme.of(context).copyWith(
          platform: TargetPlatform.iOS,
        ),
        child: CupertinoAlertDialog(
          content: Column(children: [
            const Text(
              "Couldn't get in",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            Text(
              message,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ]),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => MyNavigatorManager.instance.simulatorPop(),
            )
          ],
        ),
      );
    },
  );
}

Future<void> showPopAllStudied(BuildContext context, String category) {
  return showCupertinoDialog(
    context: context,
    builder: (context) {
      return Theme(
        data: Theme.of(context).copyWith(
          platform: TargetPlatform.iOS,
        ),
        child: CupertinoAlertDialog(
          content: const Text(
            "All terms have been studied",
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Restart'),
              onPressed: () {
                MyNavigatorManager.instance.simulatorPop();
              },
            )
          ],
        ),
      );
    },
  );
}
