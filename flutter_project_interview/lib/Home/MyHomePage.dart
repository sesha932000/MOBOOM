import 'package:flutter/material.dart';
import 'package:flutter_project_interview/API/apiclint.dart';
import 'package:flutter_project_interview/Model/cartModel.dart';
import '../Widgets/Appbar.dart';

import 'package:number_paginator/number_paginator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

String? valueChoose;
List listItem = [];

class _MyHomePageState extends State<MyHomePage> {
  List<Product> products = [];
  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    products = (await ApiClient.getProdcts()).products;
    listItem = (await ApiClient.categories());
    setState(() {});
  }

  final TextEditingController _textEditingController = TextEditingController();
  final NumberPaginatorController _Paginatorcontroller =
      NumberPaginatorController();

  @override
  Widget build(BuildContext context) {
    print(products.length);
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),

              /////// Search box //////
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  suffixIcon: _textEditingController.text == ''
                      ? Icon(Icons.search)
                      : IconButton(
                          onPressed: () async {
                            _textEditingController.text = '';
                            valueChoose = null;
                            products = (await ApiClient.getProdcts()).products;
                            setState(() {});
                          },
                          icon: Icon(Icons.close),
                        ),
                  hintText: 'What do you want to buy today?',
                  contentPadding: EdgeInsetsDirectional.symmetric(
                      vertical: 10, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              /////////// Text Widget /////////
              Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Select category',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton(
                          menuMaxHeight: 300,
                          elevation: 5,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 26,
                          hint: Text(
                            'Select Items:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          dropdownColor: Colors.white,
                          value: valueChoose,
                          style: TextStyle(color: Colors.black),
                          onChanged: (newValue) async {
                            _textEditingController.text = newValue.toString();
                            products = (await ApiClient.getProdecsbycategories(
                                    newValue.toString()))
                                .products;
                            print(newValue);
                            setState(() {
                              valueChoose = newValue as String?;
                            });
                          },
                          items: listItem.map(
                            (valueItem) {
                              return DropdownMenuItem(
                                  value: valueItem, child: Text(valueItem));
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //////// Title Card //////////
              Card(
                shadowColor: Colors.red,
                elevation: 5,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                child: Container(
                  height: 100,
                  width: 350,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.redAccent, Colors.black54],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomLeft)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title Text',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text.rich(
                        TextSpan(
                          style: TextStyle(fontSize: 16),
                          children: [
                            TextSpan(
                                text:
                                    'Slash Sales begins in April.Get up 80% \n Discount on all products',
                                style: TextStyle(color: Colors.grey)),
                            TextSpan(
                              text: ' Read More',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              products.isEmpty
                  ? Text(
                      'No Data',
                      style:
                          TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
                    )
                  :
                  /////////////       Gride View //////////////////
                  Container(
                      padding: EdgeInsets.all(8.0),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 300,
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            shadowColor: Colors.black,
                            elevation: 5,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: SizedBox(
                                  height: 250,
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        height: 100,
                                        products[index].images.last,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        products[index].title,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        products[index].description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        // textDirection: TextDirection.rtl,
                                        // textAlign: TextAlign.justify,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '\$' + products[index].price.toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 2,
                                        child: RatingBar(
                                          itemSize: 15,
                                          initialRating: products[index].rating,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          ratingWidget: RatingWidget(
                                            full: Icon(
                                              color: Colors.yellow,
                                              Icons.star,
                                              size: 5,
                                            ),
                                            half: Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                              size: 5,
                                            ),
                                            empty: Icon(
                                              Icons.star_border,
                                              size: 5,
                                            ),
                                          ),
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          );
                        },
                      )),

              /////////////// Paginator //////////////
              NumberPaginator(
                numberPages: 10,
                onPageChange: (int index) {
                  setState(() {});
                },
                initialPage: 0,
                config: NumberPaginatorUIConfig(
                  contentPadding: EdgeInsets.all(2),
                  height: 44,
                  buttonShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  buttonSelectedForegroundColor: Colors.yellow,
                  buttonUnselectedForegroundColor: Colors.white,
                  buttonUnselectedBackgroundColor: Colors.grey,
                  buttonSelectedBackgroundColor: Colors.blueGrey,
                ),
              ),
              SizedBox(
                height: 20,
              ),

              ////////////////  Footer ////////////
              Container(
                padding: EdgeInsets.all(30),
                height: 500,
                color: Colors.grey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'social'.toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            child: Text(
                              'platforms'.toUpperCase(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.facebook,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            FontAwesomeIcons.twitter,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            FontAwesomeIcons.instagram,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            FontAwesomeIcons.tiktok,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            FontAwesomeIcons.snapchat,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.android,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.appStore,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Text(
                          'sign up'.toUpperCase(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Your email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(350, 40),
                          padding: EdgeInsets.all(20),
                          onPrimary: Colors.white,
                          primary: Colors.black,
                          alignment: Alignment.center,
                        ),
                        child: Text(
                          'subcribe'.toUpperCase(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text.rich(
                          TextSpan(style: TextStyle(fontSize: 15), children: [
                        TextSpan(
                            text:
                                "By clicking the SUBSCRIBE button, you are agreeing to our"),
                        TextSpan(
                          text: 'Privacy & Cookie Policy',
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        )
                      ])),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        '© 2010-2022 All Rights Reserved',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            'Privacy center',
                            style: TextStyle(
                              fontSize: 10,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('|'),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Privacy & Cookie Policy',
                            style: TextStyle(
                              fontSize: 10,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text('|'),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Manage Cookies',
                            style: TextStyle(
                              fontSize: 10,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text('|'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Terms & Conditions',
                            style: TextStyle(
                              fontSize: 10,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text('|'),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Copyright Notice',
                            style: TextStyle(
                              fontSize: 10,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text('|'),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Imprint',
                            style: TextStyle(
                              fontSize: 10,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
