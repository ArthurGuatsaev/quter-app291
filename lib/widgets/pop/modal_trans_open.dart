import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:quotex291/const/color.dart';
import 'package:quotex291/product/domain/model/product_model.dart';

Future showModalSheetTransactiontOpen({
  required BuildContext context,
  required TransactionsHistory tr,
}) async {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text(
                  tr.bull!
                      ? 'Purchased ${tr.amount} items'
                      : 'Sold ${tr.amount} pieces',
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  tr.dateString,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.7)),
                ),
                const SizedBox(height: 20),
                Text(
                  '${!tr.bull! ? '-' : '+'}${tr.price!}',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: !tr.bull! ? Colors.red : Colors.green),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      tr.description!,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    )),
                  ],
                )
              ],
            )),
      ),
    ),
  );
}

const _color = Color(0xFF576AD0);
