import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:quotex291/const/color.dart';
import 'package:quotex291/history/domain/bloc/history_bloc.dart';
import 'package:quotex291/history/domain/model/history_model.dart';
import 'package:quotex291/nav_manager.dart';
import 'package:quotex291/product/domain/bloc/prod_bloc.dart';
import 'package:quotex291/product/domain/model/product_model.dart';
import 'package:quotex291/widgets/calc_button.dart';
import 'package:quotex291/widgets/text_field.dart';

Future showModalSheetTransactionAdd({
  required BuildContext context,
  required TextEditingController descrController,
  required TextEditingController priceController,
  required TextEditingController amountController,
  required int index,
}) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Material(
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9), color: bgSecondColor),
            child: Padding(
              padding: const EdgeInsets.only(right: 12, left: 12, bottom: 40),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Center(child: Image.asset('assets/images/tire.png')),
                    const SizedBox(height: 10),
                    const Center(
                        child: Text(
                      'New Item',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    )),
                    const SizedBox(height: 20),
                    BlocBuilder<ProdBloc, ProdState>(
                      buildWhen: (previous, current) =>
                          previous.bull != current.bull,
                      builder: (context, state) {
                        return Row(
                          children: [
                            Expanded(
                                child: CalcButton(
                                    function: () => context
                                        .read<ProdBloc>()
                                        .add(const ChangeBullEvent(bull: true)),
                                    text: 'Purchase',
                                    color: !state.bull
                                        ? Colors.white.withOpacity(0.7)
                                        : null,
                                    gradic: state.bull
                                        ? gradientButton
                                        : gradientButtonOff)),
                            const SizedBox(width: 10),
                            Expanded(
                                child: CalcButton(
                                    text: 'Sale',
                                    function: () => context
                                        .read<ProdBloc>()
                                        .add(
                                            const ChangeBullEvent(bull: false)),
                                    color: state.bull
                                        ? Colors.white.withOpacity(0.7)
                                        : null,
                                    gradic: !state.bull
                                        ? gradientButton
                                        : gradientButtonOff)),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Price',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    VTextField(
                      controller: priceController,
                      hint: '1000.00',
                      key: const ValueKey('price'),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Amount',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    VTextField(controller: amountController, hint: '100'),
                    const SizedBox(height: 10),
                    const Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    VTextField(
                        controller: descrController,
                        hight: 250,
                        hint: 'Enter',
                        maxLines: 10),
                    const SizedBox(height: 20),
                    BlocBuilder<ProdBloc, ProdState>(
                      buildWhen: (previous, current) =>
                          previous.bull != current.bull,
                      builder: (context, state) {
                        return CalcButton(
                          function: () {
                            final tr = TransactionsHistory(
                              amount: int.tryParse(amountController.text),
                              date: DateTime.now(),
                              bull: state.bull,
                              description: descrController.text,
                              price: double.tryParse(priceController.text),
                            );
                            if (!state.bull &&
                                state.products[index].amount! - tr.amount! <
                                    0) {
                              return;
                            }
                            context.read<HistoryBloc>().add(SaveHistoryEvent(
                                hist: HistoryModel()
                                  ..date = DateTime.now()
                                  ..title = state.bull
                                      ? 'Item purchased - ${state.products[index].name}'
                                      : '${state.products[index].name} - Sold ${tr.amount} pieces'));
                            context.read<ProdBloc>().add(
                                SaveTransactionEvent(tr: tr, index: index));
                            MyNavigatorManager.instance.simulatorPop();
                          },
                          text: 'Add',
                          gradic: gradientButton,
                        );
                      },
                    )
                  ]),
            ),
          ),
        ),
      ),
    ),
  );
}
