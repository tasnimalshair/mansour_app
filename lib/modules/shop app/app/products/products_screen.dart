import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_/modules/shop%20app/cubit/cubit.dart';
import 'package:mansour_/modules/shop%20app/cubit/states.dart';
import 'package:mansour_/modules/shop%20app/models/categories_model.dart';
import 'package:mansour_/modules/shop%20app/models/home%20model/home_model.dart';
import 'package:mansour_/shared/components/constans.dart';
import 'package:mansour_/shared/components/copmonents.dart';
// import 'dart:js';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state)
    {
      if(state is ShopSuccessChangeFavoritesState){
          if(!state.model.status!){
            // showToast(message: state.model.message!, state: ToastStates.ERROR);
          }
      }

    },
      builder: (context, state) {
        // ShopCubit.get(context).getHomeData();
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoryModel != null,
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => widgetBuilder(ShopCubit.get(context).homeModel,
              ShopCubit.get(context).categoryModel, context),
        );
      },
    );
  }

  Widget widgetBuilder(
          HomeModel? homeModel, CategoryModel? categoryModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: homeModel!.data!.banners!
                    .map(
                      (e) => Image(
                          image: NetworkImage('${e.image}'),
                          fit: BoxFit.cover,
                          width: double.infinity),
                    )
                    .toList(),
                options: CarouselOptions(
                    viewportFraction: 1,
                    height: 250,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal)),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Categories',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                  SizedBox(height: 10),
                  Container(
                    height: 100,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            buildCategoryItem(categoryModel!.data.data[index]),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                        itemCount: categoryModel!.data.data.length),
                  ),
                  SizedBox(height: 20),
                  Text('New Products',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            Container(
              // color: Colors.red,
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 1,
                crossAxisSpacing: 10,
                childAspectRatio: 1 / 1.57, //    width / height
                crossAxisCount: 2,
                children: List.generate(
                    homeModel.data!.products!.length,
                    (index) => buildGridProduct(
                        homeModel.data!.products![index], context)),
              ),
            )
          ],
        ),
      );

  Widget buildGridProduct(Products model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  image: NetworkImage(
                    '${model.image}',
                  ),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.discount != 0)
                  Container(
                    width: 55,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    alignment: AlignmentDirectional.bottomStart,
                    color: Colors.red,
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 8, color: Colors.white),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    style: TextStyle(fontSize: 14, height: 1.3),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(
                            fontSize: 12, height: 1.3, color: defaultColor),
                        maxLines: 2,
                      ),
                      SizedBox(width: 5),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          style: TextStyle(
                              fontSize: 10,
                              height: 1.3,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                          maxLines: 2,
                        ),
                      Spacer(),
                      CircleAvatar(
                        backgroundColor:
                            // ShopCubit.get(context).favorites[model.id]!
                            //     ? defaultColor
                            Colors.grey,
                        radius: 15,
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              ShopCubit.get(context).changeFavorite(model.id);
                            },
                            icon: IconButton(
                              onPressed: () {
                                print(ShopCubit.get(context).favorites);
                              },
                              icon: Icon(Icons.favorite_border,
                                  size: 14, color: Colors.white),
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(Data2 model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Container(
              width: 100,
              color: Colors.black.withOpacity(0.6),
              child: Text(
                model.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ))
        ],
      );
}
