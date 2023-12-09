import 'package:flutter/cupertino.dart';
import 'package:quotex291/home/view/home.dart';
import 'package:quotex291/loading/view/ui/onboard/unwork_onb.dart';
import 'package:quotex291/loading/view/ui/onboard/widgets/base_onb.dart';
import 'package:quotex291/loading/view/ui/onboard/widgets/teleg_board.dart';
import 'package:quotex291/loading/view/ui/onboard/work_onb.dart';
import 'package:quotex291/pages/finic.dart';
import 'package:quotex291/pages/trading_valute.dart';
import 'package:quotex291/splash.dart';
import 'package:quotex291/widgets/pop/pop_up_ios_delete.dart';

class MyNavigatorManager {
  MyNavigatorManager._();
  static MyNavigatorManager instance = MyNavigatorManager._();
  final key = GlobalKey<NavigatorState>();
  late NavigatorState postState;
  NavigatorState? get nav => key.currentState;

  Future<void> postPop() async {
    postState.pop();
  }

  Future<void> simulatorPop() async {
    nav!.pop();
  }

  Future<void> errorPop(String message) async {
    showErrorPop(nav!.context, message);
  }

  Future<void> simulatorPush() async {
    nav!.pushNamed('/simulator');
  }

  Future<void> testPush() async {
    nav!.pushNamedAndRemoveUntil('/test', ModalRoute.withName('/home'));
  }

  Future<void> homePush() async {
    nav!.pushReplacementNamed('/home');
  }

  Future<void> finPush(String url) async {
    nav!.pushReplacementNamed('/fin', arguments: url);
  }

  Future<void> unworkBPush() async {
    nav!.pushNamed('/unwork');
  }

  Future<void> workBPush(String tg) async {
    nav!.pushNamed('/work', arguments: tg);
  }

  Future<void> telegaPush(VBoardParam param) async {
    nav!.pushNamed('/tg', arguments: param);
  }

  Future<void> valutePush(int index) async {
    nav!.pushNamed('/valute', arguments: index);
  }

  Future<void> winPush() async {
    nav!.pushReplacementNamed('/win');
  }

  Future<void> ansPush() async {
    nav!.pushNamed('/ans');
  }

  Future<void> losePush() async {
    nav!.pushReplacementNamed('/lose');
  }

  Future<void> lessonPush() async {
    nav!.pushNamed('/lesson');
  }

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return SplashPage.route();
      case '/unwork':
        return VUnWorkOnb.route();
      case '/work':
        final tg = settings.arguments as String;
        return VWorkOnb.route(tg);
      case '/tg':
        final tg = settings.arguments as VBoardParam;
        return VBoardTelega.route(tg);
      case '/fin':
        final url = settings.arguments as String;
        return FinicPage.route(url);
      case '/valute':
        final index = settings.arguments as int;
        return TradingValute.route(index);
      case '/home':
        return HomePage.route();
      default:
        return HomePage.route();
    }
  }
}
