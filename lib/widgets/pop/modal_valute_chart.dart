import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:quotex291/const/color.dart';
import 'package:quotex291/product/domain/bloc/prod_bloc.dart';

Future showModalSheet(BuildContext context, int index) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Material(
        color: Colors.transparent,
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
                  final pair = state.valutePair[index];
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
                              pair.pairValute,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${pair.price}',
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${pair.changePrice}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: pair.changePrice < 0
                                  ? Colors.red
                                  : Colors.green),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
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
                    return Container(
                      padding: const EdgeInsets.only(bottom: 30),
                      color: bgSecondColor,
                      child: Image.asset('assets/images/chart.png'),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
