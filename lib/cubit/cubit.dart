import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app_cubit_from_todoapp/app_states.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/mdoules/busniss_screen.dart';
import 'package:news_app/mdoules/science_screen.dart';
import 'package:news_app/mdoules/search_screen.dart';
import 'package:news_app/mdoules/sports_screen.dart';
import 'package:news_app/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStats>
{
  NewsCubit() : super(NewsInitialState());

    static NewsCubit get(context) => BlocProvider.of(context);

    int currentIndex =0;

    List<BottomNavigationBarItem> bottomItems =[
      BottomNavigationBarItem(icon: Icon(Icons.business,),label: 'Business' ),
      BottomNavigationBarItem(icon: Icon(Icons.sports),label: 'Sports' ),
      BottomNavigationBarItem(icon: Icon(Icons.science) ,label: 'Science'),

    ];

    List <Widget> screens =[
      BusinessScreen(),
      SportsScreen(),
      ScienceScreen(),

    ];

    void changBottomNavbar (int index)
    {
      currentIndex =index;
      if(index == 1) getSports();
      else if(index == 2) getScience();

      emit(NewsButtonNavState());
    }

    List<dynamic> business =[];
    void getBusiness()
    {
      emit(NewsLoadingGetBusinessState());
      DioHelper.getData(url: 'v2/top-headlines', query: {'country':'eg',
        'category':'business',
        'apiKey':'52dc0613548e44f8883fcc738817e295'}).then((value)
      {
       // print(value.data['totalResults']);
        business =value.data['articles'];
        print(business[0]['title']);
        emit(NewsGetBusinessSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    }

  List<dynamic> sports =[];
    void getSports()
    {

      emit(NewsLoadingGetSportsState());
      if(sports.length == 0)
      {
        DioHelper.getData(url: 'v2/top-headlines', query: {'country':'eg',
          'category':'sports',
          'apiKey':'52dc0613548e44f8883fcc738817e295'}).then((value)
        {
          // print(value.data['totalResults']);
          sports =value.data['articles'];
          print(sports[0]['title']);
          emit(NewsGetSportsSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(NewsGetSportsErrorState(error.toString()));
        });
      }else
        {
          emit(NewsGetSportsSuccessState());
        }

    }

  List<dynamic> science =[];
  void getScience()
  {
    emit(NewsLoadingGetSciencesState());

    if(science.length ==0)
    {
      DioHelper.getData(url: 'v2/top-headlines', query: {'country':'eg',
        'category':'science',
        'apiKey':'52dc0613548e44f8883fcc738817e295'}).then((value)
      {
        // print(value.data['totalResults']);
        science =value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetSciencesSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSciencesErrorState(error.toString()));
      });
    }else
      {
        emit(NewsGetSciencesSuccessState());
      }

  }

  List<dynamic> search =[];
  void getSearch(String value)
  {
    emit(NewsLoadingGetSearchState());

   DioHelper.getData(url: 'v2/everything',
       query: {
     'q':'$value',
     'apiKey':'52dc0613548e44f8883fcc738817e295'}).then((value)
   {
     // print(value.data['totalResults']);
     search =value.data['articles'];
     print(search[0]['title']);
     emit(NewsGetSearchSuccessState());
   }).catchError((error){
     print(error.toString());
     emit(NewsGetSearchErrorState(error.toString()));
   });
  }

}