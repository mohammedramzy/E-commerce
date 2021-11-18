import 'package:commerce/model/product.dart';
import 'package:commerce/model/productResponse.dart';
import 'package:commerce/network/ServiceApi.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  final String token;
  const Home({this.token,Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<ProductResponse> _productResponse;

  @override
  void initState() {
    super.initState();
    _productResponse = ServiceApi.instance.getProducts();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Icons.filter_alt_outlined, color: Colors.pink[300], size: 30,),
          )
        ],
        title: Text("Home", style: TextStyle(color: Colors.pink[300]),),
        centerTitle: true,
        backgroundColor: Colors.green[200],
      ),
      body: FutureBuilder(
        future: _productResponse,
        builder: (context, AsyncSnapshot<ProductResponse> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: Center(child: CircularProgressIndicator()));
          else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data == null)
            return Center(child: Text('No Data Found'));
          else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasError)
            return Center(child: Text('Error:${snapshot.error}'));
          return productsGridView(snapshot.data);
        },
      ),
    );
  }

  Widget productsGridView(ProductResponse data) =>
      GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2 / 3),
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.fromLTRB(5, 15, 5, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 4,
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: data.products[index].avatar,
                    placeholder: (context, url) => Container(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(height: 5),
                Padding(padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(
                    data.products[index].title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(
                    data.products[index].name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                Expanded(child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => addToCart(product: data.products[index]),
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(color: Colors.pink[200]),
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                      Text('${data.products[index].price} ${data
                          .products[index].currency}',
                          style: TextStyle(
                              color: Colors.pink[200], fontSize: 18)),
                    ],
                  ),
                ),
                ),
              ],
            ),
          );
        },
        itemCount: data.products.length,
      );

  addToCart({Product product}) async {
    String res = await ServiceApi.instance.addToCart(
        token:widget.token,
        productId: product.id.toString(),
        amount: 1);

    if (ServiceApi.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Added Successfully", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "${ServiceApi.statusCode},$res", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
    }
  }
}
