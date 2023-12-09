import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:quotex291/loading/view/bloc/load_bloc.dart';
import 'package:quotex291/loading/view/ui/onboard/widgets/base_onb.dart';
import 'package:quotex291/nav_manager.dart';

class VUnWorkOnb extends StatefulWidget {
  static const String routeName = '/work';

  static Route route() {
    return CupertinoPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          return const VUnWorkOnb();
        });
  }

  const VUnWorkOnb({super.key});

  @override
  State<VUnWorkOnb> createState() => _VUnWorkOnbState();
}

class _VUnWorkOnbState extends State<VUnWorkOnb> {
  get finArt => null;

  final InAppReview inAppReview = InAppReview.instance;

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoadBloc, LoadState>(
      listenWhen: (previous, current) =>
          previous.onboardIndex != current.onboardIndex,
      listener: (context, state) {
        if (state.onboardIndex == 0) {
          controller.animateToPage(0,
              duration: const Duration(milliseconds: 250),
              curve: Curves.linear);
        }
        if (state.onboardIndex == 1) {
          controller.animateToPage(1,
              duration: const Duration(milliseconds: 250),
              curve: Curves.linear);
        }
        if (state.onboardIndex == 2) {
          controller.animateToPage(2,
              duration: const Duration(milliseconds: 250),
              curve: Curves.linear);
        }
        if (state.onboardIndex == 3) {
          MyNavigatorManager.instance.simulatorPop();
        }
      },
      child: PageView(
        padEnds: false,
        pageSnapping: false,
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          VBaseBoard(
            entity: 3,
            boardParam: VBoardParam(
              image: 'assets/images/unwork_1.png',
              title: 'Your values',
              body: 'Keep a record of your investments in valuable items',
              buttonText: 'Continue',
              function: () => context.read<LoadBloc>().add(
                    const ChangeOnbIndicatorEvent(index: 1),
                  ),
            ),
          ),
          VBaseBoard(
            entity: 3,
            boardParam: VBoardParam(
              image: 'assets/images/unwork_2.png',
              title: "It's all here",
              body: 'Your portfolio in one place',
              buttonText: 'Continue',
              function: () => context.read<LoadBloc>().add(
                    const ChangeOnbIndicatorEvent(index: 2),
                  ),
            ),
          ),
          VBaseBoard(
            entity: 3,
            boardParam: VBoardParam(
              image: 'assets/images/unwork_3.png',
              title: 'Study',
              body: 'Analyze and study our current videos',
              buttonText: 'Continue',
              function: () => context.read<LoadBloc>().add(
                    const ChangeOnbIndicatorEvent(index: 3),
                  ),
            ),
          )
        ],
      ),
    );
  }
}
