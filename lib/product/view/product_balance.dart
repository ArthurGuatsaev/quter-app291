import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotex291/product/domain/bloc/prod_bloc.dart';

class ProductBalance extends StatelessWidget {
  const ProductBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProdBloc, ProdState>(
      buildWhen: (previous, current) => previous.changeBal != current.changeBal,
      builder: (context, state) {
        return Text(
          '${state.changeBal}',
          style: const TextStyle(
              fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white),
        );
      },
    );
  }
}

class PercentBalance extends StatelessWidget {
  const PercentBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProdBloc, ProdState>(
      buildWhen: (previous, current) =>
          previous.percentBal != current.percentBal,
      builder: (context, state) {
        final color = state.percentBal >= 0 ? Colors.green : Colors.red;
        return Text(
          '${state.percentBal}',
          style: TextStyle(
              color: color, fontSize: 22, fontWeight: FontWeight.w700),
        );
      },
    );
  }
}
