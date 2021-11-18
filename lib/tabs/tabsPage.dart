import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'cart.dart';
import 'category.dart';
import 'home.dart';
import 'more.dart';

class TabsPage extends StatefulWidget {
  final String token;
  const TabsPage({this.token,Key key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _index=0;
  List<BottomNavigationBarItem> _items=[
    BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.category),label: 'Category'),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'My Cart'),
    BottomNavigationBarItem(icon: Icon(Icons.menu),label: 'menu'),
  ];
  PageController _pageController = PageController();
  List<Widget>pages;
 @override
  void initState() {
    super.initState();
    pages =[
      Home(token: widget.token,),
      Categories(),
      Cart(token: widget.token,),
      More(),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller:_pageController ,
        onPageChanged:(value) {
          value=_index;
          setState(() {

          });
        } ,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _items,
        currentIndex: _index,
        onTap: (value){
          setState(() {
            _index=value;
            _pageController.jumpToPage(value);
            setState(() {

            });
          });
        },
      ),
    );
  }
}


