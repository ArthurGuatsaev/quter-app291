import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotex291/const/color.dart';
import 'package:quotex291/home/domain/bloc/home_bloc.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            previous.homeIndex != current.homeIndex,
        builder: (context, state) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (value) => context
                .read<HomeBloc>()
                .add(ChangeHomeIndexEvent(homeIndex: value)),
            currentIndex: state.homeIndex,
            backgroundColor: bgSecondColor,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(0.5),
            selectedLabelStyle: const TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
            unselectedLabelStyle: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 10,
                fontWeight: FontWeight.w500),
            items: [
              BottomNavigationBarItem(
                icon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset('assets/images/home.png',
                        color: Colors.white.withOpacity(0.5))),
                label: 'Main',
                activeIcon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      'assets/images/home.png',
                    )),
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset('assets/images/profile.png',
                        color: Colors.white.withOpacity(0.5))),
                label: 'Profile',
                activeIcon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      'assets/images/profile.png',
                    )),
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset('assets/images/history.png',
                        color: Colors.white.withOpacity(0.5))),
                label: 'History',
                activeIcon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      'assets/images/history.png',
                    )),
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset('assets/images/video.png',
                        color: Colors.white.withOpacity(0.5))),
                label: 'Video',
                activeIcon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      'assets/images/video.png',
                    )),
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset('assets/images/settings.png',
                        color: Colors.white.withOpacity(0.5))),
                label: 'Settings',
                activeIcon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      'assets/images/settings.png',
                    )),
              ),
            ],
          );
        },
      ),
    );
  }
}
