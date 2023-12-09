// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'prod_bloc.dart';

abstract class ProdEvent extends Equatable {
  const ProdEvent();

  @override
  List<Object> get props => [];
}

class SaveProductEvent extends ProdEvent {
  final ProductModel product;
  const SaveProductEvent({
    required this.product,
  });
}

class AddAndSaveValutePairEvent extends ProdEvent {
  final ValuteViewModel pair;
  const AddAndSaveValutePairEvent({
    required this.pair,
  });
}

class UpdateAndSaveValutePairEvent extends ProdEvent {
  final ValuteViewModel pair;
  final ValuteViewModel newPair;
  final int index;
  const UpdateAndSaveValutePairEvent(
      {required this.pair, required this.newPair, required this.index});
}

class DeleteAndSaveValutePairEvent extends ProdEvent {
  final ValuteViewModel pair;
  const DeleteAndSaveValutePairEvent({required this.pair});
}

class GetProductEvent extends ProdEvent {}

class GetValutePriceEvent extends ProdEvent {}

class SaveProfileImageEvent extends ProdEvent {}

class GetAllValutePriceEvent extends ProdEvent {}

class InitLocalDataEvent extends ProdEvent {}

class ResetProductEvent extends ProdEvent {}

class SaveProductImageEvent extends ProdEvent {}

class SaveTransactionEvent extends ProdEvent {
  final int index;
  final TransactionsHistory tr;
  const SaveTransactionEvent({
    required this.index,
    required this.tr,
  });
}

class DeleteProductEvent extends ProdEvent {
  final ProductModel product;
  const DeleteProductEvent({
    required this.product,
  });
}

class AddFavoriteProduct extends ProdEvent {
  final ProductModel product;
  const AddFavoriteProduct({
    required this.product,
  });
}

class ChangeBullEvent extends ProdEvent {
  final bool bull;
  const ChangeBullEvent({
    required this.bull,
  });
}
