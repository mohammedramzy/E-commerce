import 'package:commerce/model/categoryResponse.dart';
import 'package:commerce/network/ServiceApi.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Categories extends StatefulWidget {
  const Categories({Key key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Future<CategoryResponse> _categoryResponseFuture;
  @override
  void initState(){
    super.initState();
    _categoryResponseFuture=ServiceApi.instance.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: _categoryResponseFuture,
          builder: (context,AsyncSnapshot<CategoryResponse>snapshot){
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: Center(child: CircularProgressIndicator()));
            else if (snapshot.connectionState == ConnectionState.done &&
                !snapshot.hasData)
              return Center(child: Text('No Data Found'));
            else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasError)
              return Center(child: Text('Error:${snapshot.error}'));
            return categoryGridView(snapshot.data);
          },
        ),
      ),
    );
  }
  Widget categoryGridView(CategoryResponse data){
    return Column(
      children: [
        Padding(padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Categories',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent),
          ),
        ),
        Expanded(child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: data.categories.length,
            itemBuilder: (context,index){
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400])
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.fill,
                      color: Colors.green,
                      colorBlendMode: BlendMode.darken,
                      imageUrl: data.categories[index].avatar,
                      placeholder: (context,url)=>Container(),
                      errorWidget: (context,url,error)=>Icon(Icons.error),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        data.categories[index].name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          child: Text(data.categories[index].id.toString(),
                            style:TextStyle(color: Colors.white) ,),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blueAccent,
                          ),
                          padding: const EdgeInsets.all(8.0),
                        ),
                      ),

                    )
                  ],
                ),
              );
            }
        ))
      ],
    );
  }
}
