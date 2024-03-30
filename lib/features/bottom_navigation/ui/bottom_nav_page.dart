import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/bottom_navigation/bloc/my_bottom_navigation_bloc.dart';
import 'package:news_app/features/home/ui/pages/home_page.dart';

class MyBottomNavigationPage extends StatefulWidget {
  final int index;
  const MyBottomNavigationPage({super.key, required this.index});

  @override
  State<MyBottomNavigationPage> createState() => _MyBottomNavigationPageState();
}

class _MyBottomNavigationPageState extends State<MyBottomNavigationPage> {
  final myNavigationBloc = MyBottomNavigationBloc();
  final List<Widget> _pages = const [
    HomePage(),
    HomePage(), // Category Page
    HomePage(), // Fav Page
  ];
  @override
  void initState() {
    if (widget.index >= 3 && widget.index < 0) {
      return;
    }
    myNavigationBloc.add(NavigationTabChangeEvent(index: widget.index));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBottomNavigationBloc, MyBottomNavigationState>(
      bloc: myNavigationBloc,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavigationBar(
            iconSize: 22,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.blueGrey.shade300,
            onTap: (value) {
              myNavigationBloc.add(NavigationTabChangeEvent(index: value));
            },
            currentIndex: state.index,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category_rounded),
                label: "Category",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.heart),
                label: "Favourites",
              ),
            ],
          ),
          body: _pages[state.index],
        );
      },
    );
  }
}
