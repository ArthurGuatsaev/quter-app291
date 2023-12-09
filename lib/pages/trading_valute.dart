import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotex291/const/color.dart';
import 'package:quotex291/product/domain/bloc/prod_bloc.dart';
import 'package:quotex291/widgets/trading_view.dart';

class TradingValute extends StatelessWidget {
  static const String routeName = '/valute';
  static Route route(int index) {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => TradingValute(
              index: index,
            ));
  }

  final int index;
  const TradingValute({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Container(
              height: 142,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: bgSecondColor),
              child: BlocBuilder<ProdBloc, ProdState>(
                buildWhen: (previous, current) =>
                    previous.valutePair[index].pairValute !=
                    current.valutePair[index].pairValute,
                builder: (context, state) {
                  final pair = state.valutePair[index].pairValute;
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 12, right: 12, bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(child: Image.asset('assets/images/tire.png')),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              pair,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '\$0',
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '+0',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.green),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        color: bgSecondColor),
                    child: BlocBuilder<ProdBloc, ProdState>(
                      buildWhen: (previous, current) =>
                          previous.valutePair[index].pairValute !=
                          current.valutePair[index].pairValute,
                      builder: (context, state) {
                        final symbol =
                            state.valutePair[index].pairValute.toSymbol;
                        return ChartsWidget(
                          symbol: symbol,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      width: 5,
                      height: MediaQuery.of(context).size.height,
                      color: bgSecondColor,
                      padding: const EdgeInsets.all(5),
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      width: 5,
                      height: MediaQuery.of(context).size.height,
                      color: bgSecondColor,
                      padding: const EdgeInsets.all(5),
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 5,
                      color: Colors.black,
                      padding: const EdgeInsets.all(5),
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 17,
                      color: bgSecondColor,
                      padding: const EdgeInsets.all(5),
                      child: Container(color: Colors.transparent),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: bgSecondColor,
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}

extension ValuteEdit on String {
  String get toSymbol {
    final before = substring(0, 3);
    final after = substring(4);
    return '$before$after';
  }
}
