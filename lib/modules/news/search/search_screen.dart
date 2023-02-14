import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_/layout/news_app/cubit/cubit.dart';
import 'package:mansour_/layout/news_app/cubit/states.dart';
import 'package:mansour_/shared/components/copmonents.dart';

class SearchScreen extends StatelessWidget {
  // const SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultField(
                    onChanged: (value) {
                      NewsCubit.get(context).getSearch(value);
                    },
                    controller: searchController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'search must not be empty';
                      }
                      return null;
                    },
                    label: 'Search',
                    prefix: Icon(Icons.search)),
              ),
              Expanded(child: articleBuilder(list, context, isSearch: true))
            ],
          ),
        );
      },
    );
  }
}
