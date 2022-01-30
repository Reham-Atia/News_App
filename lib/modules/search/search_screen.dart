import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state){},
      builder: (context, state){
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: primaryColor,
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20.0,
                  right: 20.0,
                  left: 20.0,
                ),
                child: defaultTextFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  label: 'Search',
                  prefix: Icons.search,
                  validate: (String value)
                  {
                    if(value.isEmpty)
                    {
                      return 'Search must not be empty ';
                    }
                    return null;
                  },
                  onChange: (value)
                  {
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              Expanded(
                child: articleBuilder(list, context, isSearch: true,),
              ),
            ],
          ),
        );
      },
    );
  }
}
