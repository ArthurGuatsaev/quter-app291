import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotex291/const/color.dart';
import 'package:quotex291/product/domain/bloc/prod_bloc.dart';
import 'package:quotex291/product/domain/model/product_model.dart';
import 'package:quotex291/widgets/calc_button.dart';
import 'package:quotex291/widgets/text_field.dart';

class TransactionAdd extends StatefulWidget {
  static const String routeName = '/tr_add';
  static Route route(int index) {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => TransactionAdd(
              index: index,
            ));
  }

  const TransactionAdd({super.key, required this.index});
  final int index;

  @override
  State<TransactionAdd> createState() => _TransactionAddState();
}

class _TransactionAddState extends State<TransactionAdd> {
  late final TextEditingController priceController = TextEditingController();
  late final TextEditingController amountController = TextEditingController();
  late final TextEditingController descrController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
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
                            context.read<ProdBloc>().add(SaveTransactionEvent(
                                tr: tr, index: widget.index));
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
    );
  }
}
