import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/models/category.dart';
import 'package:furniture_app/models/product.dart';
import 'package:furniture_app/services/services.dart';
import 'package:furniture_app/widgets/product_cart.dart';

import 'detail_page.dart';

class ProductsScreen extends StatefulWidget {
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int selectedIndex = 0;
  List<Product> products = [];
  List<Categories> categories = [];
  @override
  void initState() {
    super.initState();
    fetch();
  }

  fetch() async {
    products = await fetchProducts();
    categories = await fetchCategories();
    return;
  }

  fetchCatProd(String category) async {
    products = await fetchCategoryProducts(category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: false,
        title: Text('Dashboard'),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset("assets/icons/notification.svg"),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: kPrimaryColor,
      body: FutureBuilder(
          future: fetchProducts(),
          builder: (context, snapshot) => snapshot.hasData
              ? SafeArea(
                  bottom: false,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(kDefaultPadding),
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                          vertical: kDefaultPadding / 4, // 5 top and bottom
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          onChanged: (val) {},
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            icon: SvgPicture.asset("assets/icons/search.svg"),
                            hintText: 'Search',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                        height: 30,
                        child: FutureBuilder(
                            future: fetchCategories(),
                            builder: (context, snapshot) => ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categories.length,
                                  itemBuilder: (context, index) => snapshot
                                          .hasData
                                      ? GestureDetector(
                                          onTap: () async {
                                            selectedIndex = index;
                                            if (categories[index].title ==
                                                "All") {
                                              await fetch();
                                            } else {
                                              await fetchCatProd(
                                                  categories[index].title);
                                            }
                                            setState(() {});
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(
                                              left: kDefaultPadding,
                                              // At end item it add extra 20 right  padding
                                              right:
                                                  index == categories.length - 1
                                                      ? kDefaultPadding
                                                      : 0,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: kDefaultPadding),
                                            decoration: BoxDecoration(
                                              color: index == selectedIndex
                                                  ? Colors.white
                                                      .withOpacity(0.4)
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              categories[index].title,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      : CircularProgressIndicator(
                                          color: Colors.red,
                                        ),
                                )),
                      ),
                      SizedBox(height: kDefaultPadding / 2),
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            // Our background
                            Container(
                              margin: EdgeInsets.only(top: 70),
                              decoration: BoxDecoration(
                                color: kBackgroundColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                ),
                              ),
                            ),
                            products.length == 0
                                ? Center(
                                    child: Text(
                                    "No Products found",
                                    style: TextStyle(fontSize: 20),
                                  ))
                                : ListView.builder(
                                    itemCount: products.length,
                                    itemBuilder: (context, index) =>
                                        ProductCard(
                                      itemIndex: index,
                                      product: products[index],
                                      press: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailsScreen(
                                              product: products[index],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: const CircularProgressIndicator(
                      backgroundColor: kPrimaryColor),
                )),
    );
  }
}
