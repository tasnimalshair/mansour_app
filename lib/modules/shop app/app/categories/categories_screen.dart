import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_/modules/shop%20app/cubit/cubit.dart';
import 'package:mansour_/modules/shop%20app/cubit/states.dart';
import 'package:mansour_/modules/shop%20app/models/categories_model.dart';
import 'package:mansour_/shared/components/copmonents.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildCatItem(
                ShopCubit.get(context).categoryModel!.data.data[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopCubit.get(context).categoryModel!.data.data.length);
      },
    );
  }

  Widget buildCatItem(Data2 model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image),
              fit: BoxFit.cover,
              height: 80,
              width: 80,
            ),
            SizedBox(width: 20),
            Text(
              model.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}
