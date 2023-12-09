import 'package:flutter/material.dart';
import 'package:quotex291/product/domain/model/product_model.dart';
import 'package:quotex291/widgets/pop/bottom_sheet.dart';

class ProductItem extends StatelessWidget {
  final ProductModel productModel;
  final bool? points;
  const ProductItem({super.key, required this.productModel, this.points});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(9)),
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            AspectRatio(
              aspectRatio: 1,
              child: FutureBuilder(
                  future: productModel.productImage,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
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
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      );
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 12,
                top: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.name!,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '\$${productModel.totalPrice}',
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: _color,
                            borderRadius: BorderRadius.circular(9)),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            productModel.tag!,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${productModel.amount}',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.7)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  points != null
                      ? const SizedBox(height: 5)
                      : GestureDetector(
                          onTap: () {
                            showCupertinoBottomSheet(
                                context: context, product: productModel);
                          },
                          child: const SizedBox(
                            height: 25,
                            width: 25,
                            child: Material(
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 3,
                                    backgroundColor: Colors.white,
                                  ),
                                  SizedBox(width: 3),
                                  CircleAvatar(
                                    radius: 3,
                                    backgroundColor: Colors.white,
                                  ),
                                  SizedBox(width: 3),
                                  CircleAvatar(
                                    radius: 3,
                                    backgroundColor: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                  const Spacer(),
                  Text(
                    productModel.dateString,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

const _color = Color(0xFF576AD0);
