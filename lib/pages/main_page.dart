import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotex291/const/color.dart';
import 'package:quotex291/pages/trading_valute.dart';
import 'package:quotex291/product/domain/bloc/prod_bloc.dart';
import 'package:quotex291/product/view/product_balance.dart';
import 'package:quotex291/widgets/calc_button.dart';
import 'package:quotex291/widgets/pop/modal_valute_chart.dart';
import 'package:quotex291/widgets/pop/modal_valute_edit.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: bgSecondColor),
            child: Padding(
              padding: const EdgeInsets.only(top: 90, left: 12, right: 12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Main',
                      style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    SizedBox(
                        height: 20, width: MediaQuery.of(context).size.width),
                    Text(
                      'Total portfolio value',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white.withOpacity(0.7)),
                    ),
                    const SizedBox(height: 10),
                    const ProductBalance(),
                    const SizedBox(height: 20),
                  ]),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: bgSecondColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cost change',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.7)),
                    ),
                    const SizedBox(height: 10),
                    const PercentBalance()
                  ],
                ),
              )),
              const SizedBox(width: 10),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: bgSecondColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total investment',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.7)),
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<ProdBloc, ProdState>(
                      buildWhen: (previous, current) =>
                          previous.products.length != current.products.length,
                      builder: (context, state) {
                        return Text(
                          '${state.products.length}',
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        );
                      },
                    ),
                  ],
                ),
              ))
            ],
          ),
          const SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: bgSecondColor),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 12, bottom: 12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Share percentage',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.7)),
                    ),
                    SizedBox(
                        height: 20, width: MediaQuery.of(context).size.width),
                    BlocBuilder<ProdBloc, ProdState>(
                      buildWhen: (previous, current) {
                        return previous.products != current.products;
                      },
                      builder: (context, state) {
                        final last = state.products.isEmpty
                            ? '-'
                            : state.products.last.name!;
                        final persent = state.products.isEmpty
                            ? '-'
                            : '${100 / state.products.length}%';
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                last,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                            Text(
                              persent,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )
                          ],
                        );
                      },
                    ),
                  ]),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: bgSecondColor),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 12, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Quotes',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white.withOpacity(1)),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        height: 28,
                        child: CalcButton(
                          function: () => showModalSheetValuteEdit(context),
                          gradic: gradientButton,
                          text: 'Choose',
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                      height: 20, width: MediaQuery.of(context).size.width),
                  SizedBox(
                    height: 85,
                    child: BlocBuilder<ProdBloc, ProdState>(
                      buildWhen: (previous, current) =>
                          previous.valutePair.length !=
                          current.valutePair.length,
                      builder: (context, state) {
                        return ListView.builder(
                            itemExtent: 140,
                            itemCount: state.valutePair.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(0.12)))),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () =>
                                          showModalSheet(context, index),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                  'assets/images/${state.valutePair[index].pairValute.toSymbol}.png'),
                                              const SizedBox(width: 3),
                                              Text(
                                                state.valutePair[index]
                                                    .pairValute,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            '\$${state.valutePair[index].price}',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            '${state.valutePair[index].changePrice > 0 ? '+' : ''}${state.valutePair[index].changePrice}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: state.valutePair[index]
                                                            .changePrice >
                                                        0
                                                    ? Colors.green
                                                    : Colors.red),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
