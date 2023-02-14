// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_/modules/shop%20app/cubit/cubit.dart';
import 'package:mansour_/modules/shop%20app/cubit/states.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Text('favorite');
        // return ConditionalBuilder(
        //   condition: state is !ShopLoadingGetFavoritesState,
        //   fallback: (context) => Center(child: CircularProgressIndicator()),
        //   builder: (context) => ListView.separated(
        //       itemBuilder: (context, index) => buildFavItem(
        //           ShopCubit.get(context).favoriteModel!.data!.data![index],context),
        //       separatorBuilder: (context, index) => myDivider(),
        //       itemCount: ShopCubit.get(context).favoriteModel!.data!.data!.length),,
        //
        // );
      },
    );

  }

  // Widget buildFavItem(Data data ,context) => Padding(
  //   padding: const EdgeInsets.all(20.0),
  //   child: Container(
  //     height: 120,
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Stack(
  //           alignment: Alignment.bottomLeft,
  //           children: [
  //             Image(
  //               image: NetworkImage(
  //                 '${model.product.image }',
  //               ),
  //               fit: BoxFit.cover,
  //               width: double.infinity,
  //               height: 200,
  //             ),
  //             if (model.product.discount != 0)
  //               Container(
  //                 width: 55,
  //                 padding: EdgeInsets.symmetric(horizontal: 5),
  //                 alignment: AlignmentDirectional.bottomStart,
  //                 color: Colors.red,
  //                 child: Text(
  //                   'DISCOUNT',
  //                   style: TextStyle(fontSize: 8, color: Colors.white),
  //                 ),
  //               ),
  //           ],
  //         ),
  //         SizedBox(width: 20,),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 model.product.name!,
  //                 style: TextStyle(fontSize: 14, height: 1.3),
  //                 maxLines: 2,
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //               Spacer(),
  //               Row(
  //                 children: [
  //                   Text(
  //                     '${model.product.price.round()}',
  //                     style: TextStyle(
  //                         fontSize: 12, height: 1.3, color: defaultColor),
  //                     maxLines: 2,
  //                   ),
  //                   SizedBox(width: 5),
  //                   if (model.product.discount != 0)
  //                     Text(
  //                       '${model.product.oldPrice.round()}',
  //                       style: TextStyle(
  //                           fontSize: 10,
  //                           height: 1.3,
  //                           color: Colors.grey,
  //                           decoration: TextDecoration.lineThrough),
  //                       maxLines: 2,
  //                     ),
  //                   Spacer(),
  //                   CircleAvatar(
  //                     backgroundColor:
  //                     // ShopCubit.get(context).favorites[model.product.id]!
  //                     //     ? defaultColor :
  //                     Colors.grey,
  //                     radius: 15,
  //                     child: IconButton(
  //                         padding: EdgeInsets.zero,
  //                         onPressed: () {
  //                           ShopCubit.get(context).changeFavorite(model.product.id);
  //                         },
  //                         icon: IconButton(
  //                           onPressed: () {
  //                             print(ShopCubit.get(context).favorites);
  //                           },
  //                           icon: Icon(Icons.favorite_border,
  //                               size: 14, color: Colors.white),
  //                         )),
  //                   )
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   ),
  // );
}
