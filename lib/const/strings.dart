import 'package:flutter/material.dart';

const String appName = 'Quater FX';
const apiDomain = 'hortwewq.space';
const apiToken = '2808d78b-71ef-4066-84e6-b632e5bb5348';
const zaglushka = 'hortwewq.space/app/qu4t4r5x';

const List<String> valuteList = ['EUR', 'USD', 'GBP', 'AUD', 'USD'];
const List<String> valutePairList = [
  'EUR/USD',
  'USD/JPY',
  'AUD/USD',
  'USD/CAD',
  'USD/CHF',
  'NZD/USD',
  'EUR/JPY',
  'GBP/JPY',
  'EUR/GBP',
  'AUD/JPY',
  'EUR/AUD',
  'EUR/CHF',
  'AUD/NZD',
];
final Map<String, Widget> flags = {
  'EURUSD': Image.asset(
    'assets/images/EURUSD.png',
    width: 50,
    height: 50,
  ),
  'USDJPY': Image.asset(
    'assets/images/JPNUSD.png',
    width: 50,
  ),
  'GBPUSD': Image.asset(
    'assets/images/GBRUSD.png',
    width: 50,
  ),
  'AUDUSD': Image.asset(
    'assets/images/AUSUSD.png',
    width: 50,
  ),
  'USDCAD': Image.asset(
    'assets/images/CNDUSD.png',
    width: 50,
  )
};
