// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quotex291/product/data/valute_api.dart';
import 'package:quotex291/product/domain/bloc/prod_bloc.dart';
import 'package:quotex291/product/domain/model/valute_price.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quotex291/product/domain/model/product_model.dart';

class ProductRepository with ProductAditional, MyPickerImage {
  ProductRepository({required this.isar, required this.errorController});
  final StreamController<String> errorController;
  final Isar isar;
  Future<void> saveProduct({required ProductModel product}) async {
    await isar.writeTxn(() async {
      await isar.productModels.put(product);
    });
  }

  Future<List<ProductModel>> getProducts() async {
    return await isar.productModels.where().findAll();
  }

  Future<void> removeProduct({required ProductModel product}) async {
    await isar.writeTxn(() async {
      await isar.productModels.delete(product.id!);
    });
  }

  Future<void> resete({required List<String> productsImage}) async {
    await isar.writeTxn(() async {
      await isar.productModels.clear();
    });
    await resetBalance();
    await resetValute();
    await resetImage(productsImage: productsImage);
  }
}

mixin ProductAditional {
  FileImage? myImage;
  final String imagePathKey = 'images_path';
  final String valute = 'valute';
  final String balance = 'balance';
  Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();

  Future<ValutePriceModel> getValutePrice({required String symbol}) async {
    return await ApiClentTrade.getCourse(valute: symbol);
  }

  Future<List<String>> getValuteTitle() async {
    return (await prefs).getStringList(valute) ??
        ['EUR/USD', 'USD/JPY', 'AUD/USD'];
  }

  Future<List<Future<ValuteViewModel>>> getValute(
      List<String> valuteName) async {
    try {
      final result = valuteName.map((e) async {
        final model = await getValutePrice(symbol: e);
        return ValuteViewModel(
            pairValute: e,
            changePrice: model.change ?? 0,
            price: model.price ?? 0);
      }).toList();
      return result;
    } catch (e) {
      return [];
    }
  }

  Future<void> saveValute(List<String> newVal) async {
    (await prefs).setStringList(valute, newVal);
  }

  Future<void> resetValute() async {
    (await prefs).remove(valute);
  }

  Future<void> saveBalance(int summ, int bal) async {
    (await prefs).setInt(balance, summ + bal);
  }

  Future<int> getBalance() async {
    return (await prefs).getInt(balance) ?? 0;
  }

  Future<void> resetBalance() async {
    (await prefs).remove(balance);
  }
}

class ImagePathExc implements Exception {
  final String message;
  ImagePathExc({
    required this.message,
  });
}

mixin MyPickerImage {
  FileImage? myImage;
  Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();

  Future<XFile?> getNewImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      return image;
    } catch (_) {
      return null;
    }
  }

  Future<void> saveImage({required XFile image, required String key}) async {
    (await prefs).remove(key);
    final path = await getApplicationDocumentsDirectory();
    final String imgpath = path.path;
    final date = DateTime.now();
    await image.saveTo('$imgpath/${date.millisecond}.jpeg');
    (await prefs).setString(key, '/${date.millisecond}.jpeg');
    final newImage = await getImage(key: key);
    myImage = newImage;
  }

  Future<FileImage?> getImage({required String key}) async {
    try {
      final localPath = (await prefs).getString(key);
      if (localPath == null) {
        return null;
      }
      final path = await getApplicationDocumentsDirectory();
      return FileImage(File(path.path + localPath));
    } catch (e) {
      throw ImagePathExc(message: 'image get exeption');
    }
  }

  Future<void> resetImage({required List<String> productsImage}) async {
    try {
      final path = await getApplicationDocumentsDirectory();
      for (var i in productsImage) {
        final localPath = (await prefs).getString(i);
        if (localPath == null) return;
        (await prefs).remove(i);
        await File(path.path + localPath).delete(recursive: true);
      }
    } catch (_) {}
  }
}
