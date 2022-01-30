import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';

class NewsLayoutScreen extends StatelessWidget {
  const NewsLayoutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state){
        var cubit = NewsCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              'News App',
              style: TextStyle(
                color: Color(0xffFF2F71),
              ),
            ),
            actions: [
              IconButton(
                onPressed: (){
                  navigateTo(context, SearchScreen());
                },
                icon: Icon(
                  Icons.search,
                  color: Color(0xffFF2F71),
                ),
              ),
              IconButton(
                onPressed: (){
                  AppCubit.get(context).changeAppMode();
                },
                icon: Icon(
                  Icons.brightness_3,
                  color: Color(0xffFF2F71),
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,
            selectedItemColor: Color(0xffFF2F71),
          ),
        );
      },
    );
  }
}
