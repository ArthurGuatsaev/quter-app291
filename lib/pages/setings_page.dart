import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:quotex291/const/color.dart';
import 'package:quotex291/const/strings.dart';
import 'package:quotex291/widgets/pop/pop_up_ios_delete.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final InAppReview inAppReview = InAppReview.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
                color: bgSecondColor,
              ),
              child: const Padding(
                padding: EdgeInsets.only(bottom: 10, left: 12),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Settings',
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: bgSecondColor),
              child: Column(children: [
                SettingItem(
                  func: () => inAppReview.requestReview(),
                  title: 'Rate our app',
                  image: 'assets/images/docs.png',
                ),
                SettingItem(
                  func: () {
                    shareApp(
                        context: context,
                        text:
                            'https://apps.apple.com/us/app/quater-fx/id6474067897');
                  },
                  title: 'Share our app',
                  image: 'assets/images/share_app.png',
                ),
                SettingItem(
                  func: () {
                    launchPolicy();
                  },
                  title: 'Usage policy',
                  image: 'assets/images/star_blue.png',
                  isD: false,
                )
              ]),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: bgSecondColor),
              height: 64,
              child: SettingItem(
                func: () {
                  showMyIosResetDataPop(context);
                },
                title: 'Reset progress',
                image: 'assets/images/reset.png',
                isD: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final String title;
  final Function() func;
  final bool? isD;
  final String image;
  const SettingItem({
    Key? key,
    this.isD,
    required this.image,
    required this.title,
    required this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: SizedBox(
          height: 52,
          child: DecoratedBox(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: isD != null
                            ? Colors.transparent
                            : Colors.white.withOpacity(0.12)))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Row(
                    children: [
                      Image.asset(
                        image,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Text(
                        title,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      )),
                      Icon(
                        Icons.navigate_next,
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void shareApp({required BuildContext context, required String text}) async {
  final box = context.findRenderObject() as RenderBox;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  IosDeviceInfo info = await deviceInfo.iosInfo;
  if (info.model.toLowerCase().contains("ipad")) {
    Share.share(text,
        subject: appName,
        sharePositionOrigin:
            box.localToGlobal(Offset.zero) & const Size(100, 100));
  } else {
    Share.share(text, subject: appName);
  }
}

void launchPolicy() async {
  final uri = Uri.parse(
      'https://docs.google.com/document/d/1qoUBGnv98BNvUIHcLkzHI--tXLg1E6q12ao6_GVIZxU/edit');
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
