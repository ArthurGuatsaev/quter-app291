import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quotex291/const/strings.dart';
import 'package:quotex291/product/domain/model/product_model.dart';
import 'package:quotex291/product/domain/repository/product_repository.dart';

part 'prod_event.dart';
part 'prod_state.dart';

class ProdBloc extends Bloc<ProdEvent, ProdState> {
  final ProductRepository repository;
  ProdBloc({required this.repository}) : super(const ProdState()) {
    on<GetProductEvent>(getProducts);
    on<SaveProductEvent>(saveProducts);
    on<DeleteProductEvent>(deleteProduct);
    on<ResetProductEvent>(reseteProduct);
    on<SaveProductImageEvent>(saveProductimage);
    on<SaveTransactionEvent>(saveTransaction);
    on<ChangeBullEvent>(changeBull);
    on<GetValutePriceEvent>(getValutePrice);
    on<GetAllValutePriceEvent>(getAllValutePrice);
    on<UpdateAndSaveValutePairEvent>(updateAndSaveValutePair);
    on<AddAndSaveValutePairEvent>(addAndSaveValutePair);
    on<DeleteAndSaveValutePairEvent>(deleteAndSaveValutePair);
    on<SaveProfileImageEvent>(saveProfileimage);
    on<InitLocalDataEvent>(initLocalData);
    on<AddFavoriteProduct>(addFavoriteProduct);
  }
  getProducts(GetProductEvent event, Emitter<ProdState> emit) async {
    final prod = await repository.getProducts();
    final balance = await repository.getBalance();
    emit(state.copyWith(products: prod, balance: balance));
  }

  initLocalData(InitLocalDataEvent event, Emitter<ProdState> emit) async {
    const valute = valuteList;
    final profileImage = await repository.getImage(key: 'profile_image');
    final balance = await repository.getBalance();
    emit(state.copyWith(
        valute: valute, profileImage: profileImage, balance: balance));
    add(GetValutePriceEvent());
  }

  getAllValutePrice(
      GetAllValutePriceEvent event, Emitter<ProdState> emit) async {
    final pare = await Future.wait(await repository.getValute(valutePairList));
    emit(state.copyWith(allValutePair: pare));
  }

  addAndSaveValutePair(
      AddAndSaveValutePairEvent event, Emitter<ProdState> emit) async {
    final pair = [...state.valutePair, event.pair];
    await repository.saveValute(pair.map((e) => e.pairValute).toList());
    emit(state.copyWith(valutePair: pair));
  }

  updateAndSaveValutePair(
      UpdateAndSaveValutePairEvent event, Emitter<ProdState> emit) async {
    final pair = [...state.valutePair];
    pair.remove(event.pair);
    pair.insert(event.index, event.newPair);
    await repository.saveValute(pair.map((e) => e.pairValute).toList());
    emit(state.copyWith(valutePair: pair));
  }

  deleteAndSaveValutePair(
      DeleteAndSaveValutePairEvent event, Emitter<ProdState> emit) async {
    final pair = [...state.valutePair];
    pair.remove(event.pair);
    await repository.saveValute(pair.map((e) => e.pairValute).toList());
    emit(state.copyWith(valutePair: pair));
  }

  getValutePrice(GetValutePriceEvent event, Emitter<ProdState> emit) async {
    final valutePair = await repository.getValuteTitle();
    final pare = await Future.wait(await repository.getValute(valutePair));
    emit(state.copyWith(valutePair: pare));
  }

  saveProducts(SaveProductEvent event, Emitter<ProdState> emit) async {
    if (state.image != null) {
      await repository.saveImage(
          image: state.image!, key: '${event.product.name}');
    }
    await repository.saveProduct(
        product: event.product.copyWith(initialPrice: event.product.price));
    await repository.saveBalance(
        (event.product.price! * event.product.amount!).toInt(), state.balance);
    add(GetProductEvent());
  }

  deleteProduct(DeleteProductEvent event, Emitter<ProdState> emit) async {
    await repository.removeProduct(product: event.product);
    add(GetProductEvent());
  }

  reseteProduct(ResetProductEvent event, Emitter<ProdState> emit) async {
    await repository.resete(
        productsImage: state.products.map((e) => e.name!).toList());
    add(GetProductEvent());
    add(InitLocalDataEvent());
  }

  saveProductimage(SaveProductImageEvent event, Emitter<ProdState> emit) async {
    final image = await repository.getNewImage();
    emit(state.copyWith(image: image));
  }

  saveProfileimage(SaveProfileImageEvent event, Emitter<ProdState> emit) async {
    final image = await repository.getNewImage();
    if (image != null) {
      await repository.saveImage(image: image, key: 'profile_image');
      final profileImage = repository.myImage;
      emit(state.copyWith(profileImage: profileImage));
    }
  }

  saveTransaction(SaveTransactionEvent event, Emitter<ProdState> emit) async {
    final s = state.products[event.index].transactionsHistory ?? [];
    final tr = [...s];
    tr.add(event.tr);
    await repository.saveBalance(
        (event.tr.price! * event.tr.amount!).toInt(), state.balance);
    await repository.saveProduct(
        product: state.products[event.index].copyWith(
            transactionsHistory: tr,
            price: tr.last.price,
            amount: tr.last.bull!
                ? state.products[event.index].amount! + tr.last.amount!
                : state.products[event.index].amount! - tr.last.amount!));
    add(GetProductEvent());
  }

  changeBull(ChangeBullEvent event, Emitter<ProdState> emit) {
    emit(state.copyWith(bull: event.bull));
  }

  addFavoriteProduct(AddFavoriteProduct event, Emitter<ProdState> emit) {
    add(SaveProductEvent(product: event.product));
    add(GetProductEvent());
  }
}
