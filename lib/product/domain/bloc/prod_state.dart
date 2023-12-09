// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'prod_bloc.dart';

class ProdState {
  final List<ProductModel> products;
  final List<ValuteViewModel> valutePair;
  final List<ValuteViewModel> allValutePair;
  final XFile? image;
  final FileImage? profileImage;
  final List<String> valute;
  final int balance;
  final bool bull;
  const ProdState(
      {this.products = const [],
      this.valutePair = const [],
      this.allValutePair = const [],
      this.valute = const [],
      this.bull = true,
      this.profileImage,
      this.image,
      this.balance = 1});

  ProdState copyWith(
      {List<ProductModel>? products,
      List<String>? valute,
      XFile? image,
      List<ValuteViewModel>? valutePair,
      FileImage? profileImage,
      List<ValuteViewModel>? allValutePair,
      bool? bull,
      int? balance}) {
    return ProdState(
        products: products ?? this.products,
        bull: bull ?? this.bull,
        valute: valute ?? this.valute,
        profileImage: profileImage ?? this.profileImage,
        allValutePair: allValutePair ?? this.allValutePair,
        image: image ?? this.image,
        valutePair: valutePair ?? this.valutePair,
        balance: balance ?? this.balance);
  }

  int get changeBal {
    if (products.isEmpty) return 0;
    return products
        .map((e) => e.totalPrice.toInt())
        .toList()
        .reduce((value, element) => value + element);
  }

  int get percentBal {
    if (products.isEmpty) return 0;
    return products
        .map((e) => e.changePrice)
        .toList()
        .reduce((value, element) => value + element);
  }

  List<ProductModel> get favoriteList {
    return products.where((e) => e.isFavorite!).toList();
  }

  List<ProductModel> get archiveList {
    return products.where((e) => e.isArchive!).toList();
  }
}

class ValuteViewModel {
  final String pairValute;
  final double changePrice;
  final double price;
  const ValuteViewModel({
    this.pairValute = '',
    this.changePrice = 0,
    this.price = 0,
  });

  ValuteViewModel copyWith({
    String? pairValute,
    double? changePrice,
    double? price,
  }) {
    return ValuteViewModel(
      pairValute: pairValute ?? this.pairValute,
      changePrice: changePrice ?? this.changePrice,
      price: price ?? this.price,
    );
  }
}
