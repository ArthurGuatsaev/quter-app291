import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:quotex291/const/color.dart';
import 'package:quotex291/product/domain/bloc/prod_bloc.dart';
import 'package:quotex291/product/view/product_item.dart';
import 'package:quotex291/widgets/pop/modal_open_product.dart';

Future showModalSheetFavorite({
  required BuildContext context,
}) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Material(
        color: Colors.transparent,
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
                  'Favorites',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                )),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<ProdBloc, ProdState>(
                    buildWhen: (previous, current) =>
                        previous.favoriteList.length !=
                            current.favoriteList.length ||
                        previous.products != current.products,
                    builder: (context, state) {
                      if (state.favoriteList.isEmpty) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Image.asset('assets/images/star_favor.png'),
                            const SizedBox(height: 20),
                            const Text(
                              'Empty',
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'You have no items added to your favorites',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white.withOpacity(0.7)),
                            ),
                          ],
                        );
                      }
                      return ListView.builder(
                        itemCount: state.favoriteList.length,
                        itemBuilder: (context, index) {
                          final pr = state.favoriteList[index];
                          final i = state.products.indexOf(pr);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SizedBox(
                              height: 100,
                              child: GestureDetector(
                                onTap: () => showModalSheetProductOpen(
                                    context: context, product: pr, index: i),
                                child: ProductItem(
                                  productModel: pr,
                                  points: true,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
