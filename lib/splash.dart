import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotex291/loading/domain/model/loading_model.dart';
import 'package:quotex291/loading/view/bloc/load_bloc.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const SplashPage());
  }

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double loadProgress = 0;
  late final double width;
  late double pading;
  @override
  void didChangeDependencies() {
    pading = MediaQuery.of(context).size.width / 3.5;
    width = MediaQuery.of(context).size.width - pading * 2;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:
                Image.asset('assets/images/lounch.png', fit: BoxFit.fitWidth),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 215),
                child: Image.asset(
                  'assets/images/logoz.png',
                  width: 180,
                  height: 170,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: pading),
                child: SizedBox(
                  height: 8,
                  width: width,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _loadingBackColor),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: BlocBuilder<LoadBloc, LoadState>(
                        buildWhen: (previous, current) =>
                            previous.loadingList != current.loadingList,
                        builder: (context, state) {
                          loadProgress =
                              (width / (VLoading.values.length - 13)) *
                                  (state.loadingList.length + 0.8);
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: loadProgress,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: _loadingColor),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

const _loadingColor = Colors.white;
final _loadingBackColor = Colors.white.withOpacity(0.12);
