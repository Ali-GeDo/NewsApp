import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/network/local/chache__helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'app_cubit_from_todoapp/app_cubit.dart';
import 'app_cubit_from_todoapp/app_states.dart';
import 'bloc_bserver/bloc_observer.dart';
import 'cubit/cubit.dart';
import 'layout/news_layout.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark =CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp( isDark));

}

class MyApp extends StatelessWidget {
  final bool? isDark;
   MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
         BlocProvider(create: (context)=>NewsCubit()..getBusiness(),),
        BlocProvider( create: (BuildContext context) =>AppCubit()..changeAppMode(fromShared: isDark),)
      ],
      child: BlocConsumer<AppCubit ,AppState>(
        listener:(context ,state){} ,
        builder:(context ,state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch:Colors.deepOrange,
              backgroundColor: Colors.white,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                  iconTheme: IconThemeData(
                    color: Colors.black,

                  ),
                  elevation: 0,
                  color: Colors.white,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.grey[500],
                  )),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Colors.deepOrange,
                type: BottomNavigationBarType.fixed,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch:Colors.deepOrange,
              backgroundColor: HexColor('#333739'),
              scaffoldBackgroundColor: HexColor('#333739'),
              appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  iconTheme: IconThemeData(
                    color:Colors.white,
                  ),
                  elevation: 0,
                  color: HexColor('#333739'),
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.grey[500],
                  )),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Colors.deepOrange,
                backgroundColor: HexColor('#333740'),
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,

            home: NewsHomeScreen(),
          );
        } ,
      ),
    );
  }
}
