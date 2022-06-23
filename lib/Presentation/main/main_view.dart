import 'package:flutter/material.dart';
import 'package:flutter_mvvm_app/Presentation/main/main_pages/home/home_view/home_page.dart';
import 'package:flutter_mvvm_app/Presentation/main/main_pages/notification_view/notifications_page.dart';
import 'package:flutter_mvvm_app/Presentation/main/main_pages/search/searach_view/search_page.dart';
import 'package:flutter_mvvm_app/Presentation/main/main_pages/settings/setting_view/settings_page.dart';
import 'package:flutter_mvvm_app/Presentation/resources/color_manager.dart';
import 'package:flutter_mvvm_app/Presentation/resources/strings_manager.dart';
import 'package:flutter_mvvm_app/Presentation/resources/values_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  
  List<String> titles = [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notifications,
    AppStrings.settings
  ];

  List<Widget> pages = [
    HomePage(),
    SearchPage(),
    NotificationPage(),
    SettingPage()
  ]; 

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titles[currentIndex],style: (Theme.of(context).textTheme.bodyMedium),)),
      body: pages[currentIndex],
      bottomNavigationBar: Container(decoration: BoxDecoration(
        boxShadow: [BoxShadow(spreadRadius: AppSize.s1_5,color: ColorManager.primary)]
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: ColorManager.primary,
        unselectedItemColor: ColorManager.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: AppStrings.search,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: AppStrings.notifications
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: AppStrings.settings,
          ),
        ],
        onTap: _onTap,
        ),
      ),
    );

  }

  _onTap(int index){
    setState(() {
      currentIndex = index;
    });
  }
}
