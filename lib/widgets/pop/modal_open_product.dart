import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:quotex291/const/color.dart';
import 'package:quotex291/product/domain/bloc/prod_bloc.dart';
import 'package:quotex291/product/domain/model/product_model.dart';
import 'package:quotex291/widgets/pop/modal_trans_open.dart';
import 'package:quotex291/widgets/pop/model_transaction_add.dart';

Future showModalSheetProductOpen(
    {required BuildContext context,
    int? index,
    required ProductModel product,
    ValuteViewModel? updateVal}) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
          color: bgSecondColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Center(child: Image.asset('assets/images/tire.png')),
                        const SizedBox(height: 10),
                        Container(
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          child: FutureBuilder(
                              future: product.productImage,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData ||
                                    snapshot.data == null) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(9),
                                        color: Colors.white),
                                  );
                                } else {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(9),
                                      child: Image(
                                        image: snapshot.data!,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  );
                                }
                              }),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                              color: _color,
                              borderRadius: BorderRadius.circular(9)),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              product.tag!,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                product.name!,
                                style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '\$${product.price!}',
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        Divider(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Purchase currency',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white.withOpacity(0.7)),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    product.valute!,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Quantity',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white.withOpacity(0.7)),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${product.amount!}',
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Divider(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                product.description!,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Divider(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        const SizedBox(height: 10),
                        BlocBuilder<ProdBloc, ProdState>(
                          buildWhen: (previous, current) =>
                              previous.products[index!].transactionsHistory !=
                              current.products[index].transactionsHistory,
                          builder: (context, state) {
                            if (state.products[index!].transactionsHistory ==
                                    null ||
                                state.products[index].transactionsHistory!
                                    .isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return const Text(
                              'History',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<ProdBloc, ProdState>(
                    buildWhen: (previous, current) =>
                        previous.products[index!].transactionsHistory !=
                        current.products[index].transactionsHistory,
                    builder: (context, state) {
                      return SliverList.builder(
                        itemCount: state.products[index!].transactionsHistory ==
                                null
                            ? 0
                            : state.products[index].transactionsHistory!.length,
                        itemBuilder: (context, ind) {
                          final tr =
                              state.products[index].transactionsHistory![ind];
                          return Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            height: 70,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color:
                                            Colors.white.withOpacity(0.12)))),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => showModalSheetTransactiontOpen(
                                    context: context, tr: tr),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            tr.dateString,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white
                                                    .withOpacity(0.7)),
                                          ),
                                          const Spacer(),
                                          Text(
                                            tr.bull!
                                                ? 'Purchased ${tr.amount} items'
                                                : 'Sold ${tr.amount} pieces',
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '${!tr.bull! ? '-' : '+'}${tr.price!}',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: !tr.bull!
                                              ? Colors.red
                                              : Colors.green),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
              Positioned(
                bottom: 60,
                right: 10,
                child: FloatingActionButton(
                  backgroundColor: const Color(0xFFBC1749),
                  onPressed: () {
                    showModalSheetTransactionAdd(
                        amountController: TextEditingController(),
                        context: context,
                        descrController: TextEditingController(),
                        index: index!,
                        priceController: TextEditingController());
                  },
                  child: Image.asset('assets/images/plus.png'),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

const _color = Color(0xFF576AD0);
