import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super (NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar (int index){
    currentIndex = index;
    emit(NewsBottomNavStates());
  }

  void getBusiness(){
    emit(NewsGetBusinessLoadingStates());
    DioHelper.getData(
      url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'f5656f9693f24356a74f2563c48f54d5',
        },
    ).then((value){
      business = value.data['articles'];
      print(business[0]['title']);

      emit(NewsGetBusinessSuccessStates());
    }).catchError((error){
      print(error.toString());

      emit(NewsGetBusinessErrorStates(error));
    });
  }

  void getSports(){
    emit(NewsGetSportsLoadingStates());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'sports',
        'apiKey':'f5656f9693f24356a74f2563c48f54d5',
      },
    ).then((value){
      sports = value.data['articles'];
      print(sports[0]['title']);

      emit(NewsGetSportsSuccessStates());
    }).catchError((error){
      print(error.toString());

      emit(NewsGetSportsErrorStates(error));
    });
  }

  void getScience(){
    emit(NewsGetScienceLoadingStates());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'science',
        'apiKey':'f5656f9693f24356a74f2563c48f54d5',
      },
    ).then((value){
      science = value.data['articles'];
      print(science[0]['title']);

      emit(NewsGetScienceSuccessStates());
    }).catchError((error){
      print(error.toString());

      emit(NewsGetScienceErrorStates(error));
    });
  }

  void getSearch(String value){
    emit(NewsGetSearchLoadingStates());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q' : '$value',
        'apiKey':'f5656f9693f24356a74f2563c48f54d5',
      },
    ).then((value){
      search = value.data['articles'];
      print(search[0]['title']);

      emit(NewsGetSearchSuccessStates());
    }).catchError((error){
      print(error.toString());

      emit(NewsGetSearchErrorStates(error));
    });
  }
}