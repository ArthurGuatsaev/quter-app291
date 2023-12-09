import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotex291/const/color.dart';
import 'package:quotex291/product/domain/bloc/prod_bloc.dart';
import 'package:quotex291/product/view/product_item.dart';
import 'package:quotex291/widgets/calc_button.dart';
import 'package:quotex291/widgets/pop/modal_archive.dart';
import 'package:quotex291/widgets/pop/modal_favorite.dart';
import 'package:quotex291/widgets/pop/modal_open_product.dart';
import 'package:quotex291/widgets/pop/model_product_add.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController valuteController = TextEditingController();
  late final TextEditingController descrController = TextEditingController();
  late final TextEditingController tagsController = TextEditingController();
  late final TextEditingController priceController = TextEditingController();
  late final TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 257,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                color: bgSecondColor),
            child: Stack(children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    BlocBuilder<ProdBloc, ProdState>(
                      buildWhen: (previous, current) =>
                          previous.profileImage != current.profileImage,
                      builder: (context, state) {
                        return CircleAvatar(
                          radius: 50,
                          backgroundImage: state.profileImage != null
                              ? Image(
                                  image: state.profileImage!,
                                ).image
                              : null,
                          backgroundColor: const Color(0xFFBC1749),
                          child: state.profileImage != null
                              ? const SizedBox.shrink()
                              : Image.asset('assets/images/account.png'),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 28,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white.withOpacity(0.06)),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            context
                                .read<ProdBloc>()
                                .add(SaveProfileImageEvent());
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 10),
                            child: Center(
                                child: Text(
                              'Edit',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white.withOpacity(0.7)),
                            )),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                right: 10,
                top: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () => showModalSheetArchive(context: context),
                        child: Image.asset('assets/images/tray.png')),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () => showModalSheetFavorite(context: context),
                      child: Image.asset('assets/images/star.png'),
                    ),
                  ],
                ),
              )
            ]),
          ),
          const SizedBox(height: 15),
          Expanded(
              child: BlocBuilder<ProdBloc, ProdState>(
            buildWhen: (previous, current) =>
                previous.products != current.products,
            builder: (context, state) {
              return Container(
                  decoration: const BoxDecoration(
                      color: bgSecondColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Builder(builder: (context) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 48,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Row(children: [
                                const Text(
                                  'My items',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 80,
                                  height: 28,
                                  child: CalcButton(
                                    function: () => showModalSheetProductAdd(
                                        context: context,
                                        nameController: nameController,
                                        valuteController: valuteController,
                                        descrController: descrController,
                                        tagsController: tagsController,
                                        priceController: priceController,
                                        amountController: amountController),
                                    text: 'Add',
                                    gradic: gradientButton,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ]),
                            ),
                          ),
                          Builder(builder: (context) {
                            if (state.products.isEmpty) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 70),
                                  Image.asset('assets/images/box.png'),
                                  const SizedBox(height: 15),
                                  const Text(
                                    'Empty',
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Text(
                                        "You don't have any items added yet",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Colors.white.withOpacity(0.7)),
                                      )),
                                    ],
                                  )
                                ],
                              );
                            }
                            return Expanded(
                              child: ListView.builder(
                                itemCount: state.products.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: SizedBox(
                                    height: 100,
                                    child: GestureDetector(
                                      onTap: () => showModalSheetProductOpen(
                                          context: context,
                                          product: state.products[index],
                                          index: index),
                                      child: ProductItem(
                                          productModel: state.products[index]),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      );
                    }),
                  ));
            },
          ))
        ],
      ),
    );
  }
}
