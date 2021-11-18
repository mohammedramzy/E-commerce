import 'package:commerce/model/cartResponse.dart';
import 'package:commerce/network/ServiceApi.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  final String token;
  const Cart({this.token,Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  Future<CartResponse> _cartResponseFuture;
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();

    _cartResponseFuture = ServiceApi.instance.getCart(widget.token);
  }
  @override
  Widget build(BuildContext context) {
    _cartResponseFuture = ServiceApi.instance.getCart(widget.token);
    totalPrice = 0.0;
    return Scaffold(
        body: SafeArea(
          child: FutureBuilder(
            future: _cartResponseFuture,
            builder: (context,AsyncSnapshot<CartResponse> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: Center(child: CircularProgressIndicator()));
              else if (snapshot.connectionState == ConnectionState.done &&
                  !snapshot.hasData)
                return Center(child: Text('No Data Found'));
              else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasError)
                return Center(child: Text('Error:${snapshot.error}'));
              return cartList(cartResponse : snapshot.data);
            },
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          toolbarHeight: 40,
        )
    );

  }

  Widget cartList({CartResponse cartResponse}) {
    cartResponse.products.forEach((element) {
      totalPrice+=element.total;
    });
    return Column(
      children: [
        Expanded(child:ListView.separated(
            separatorBuilder: (context,index)=>Divider(),
            itemCount: cartResponse.products.length,
            itemBuilder: (context,index){
              return ListTile(
                title: Text(cartResponse.products[index].product.title),
                leading: Image.network(cartResponse.products[index].product.avatar),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment:CrossAxisAlignment.start ,
                  children: [
                    Text('Occasions'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex: 2,child:Text('${cartResponse.products[index].totalText}')
                        ),
                        Expanded(child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius:BorderRadius.only(
                                      topLeft: Radius.circular(5)
                                  ),
                                ),
                                child: InkWell(onTap:() {
                                  if(cartResponse.products[index].amount>1){
                                    int newAmount = cartResponse.products[index].amount-1;
                                    ServiceApi.instance.addToCart(productId:cartResponse.products[index].product.id.toString(),amount:newAmount,token:widget.token);

                                    setState(() {

                                    });
                                  }else{
                                    ServiceApi.instance.addToCart(productId:cartResponse.products[index].product.id.toString(),amount:0,token:widget.token);

                                    setState(() {
                                    });

                                  }
                                } ,
                                  child: Icon(
                                      Icons.remove
                                  ),
                                ),
                              )),
                              Expanded(
                                  child: Container(
                                    child: Center(
                                      child: Text("${cartResponse.products[index].amount}"),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                    ),
                                  )),
                              Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(5),
                                            bottomRight: Radius.circular(5)
                                        )
                                    ),
                                    child: InkWell(onTap:() {
                                      int newAmount = cartResponse.products[index].amount+1;
                                       ServiceApi.instance.addToCart(productId:cartResponse.products[index].product.id.toString(),amount:newAmount,token:widget.token);
                                       setState(() {

                                    });
                                    } ,
                                      child: Icon(
                                          Icons.add
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ))
                      ],
                    )
                  ],
                ),
              );
            }
        )
        ),
        Column(
          children: [
            Container(
                color: Colors.grey[100],
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Total: '),
                    Text('$totalPrice EGP'),
                  ],
                )),

          ],
        )
      ],
    );
  }
}
