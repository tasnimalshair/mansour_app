import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mansour_/layout/news_app/cubit/cubit.dart';
import 'package:mansour_/modules/bmi/bmi_screen.dart';
import 'package:mansour_/modules/home/home_screen.dart';
import 'package:mansour_/modules/login/login_screen.dart';
import 'package:mansour_/modules/news/layout/news_layout.dart';
import 'package:mansour_/modules/news/network/local/cash_helper.dart';
import 'package:mansour_/modules/news/network/remote/dio_helper.dart';
import 'package:mansour_/modules/shop%20app/Dio/dio_helper.dart';
import 'package:mansour_/modules/shop%20app/cubit/cubit.dart';
import 'package:mansour_/modules/shop%20app/login/shop_login_screen.dart';
import 'package:mansour_/modules/shop%20app/on%20boarding/on_boarding_screen.dart';
import 'package:mansour_/modules/shop%20app/shop%20layout/shop_layout.dart';
import 'package:mansour_/modules/social%20app/socialLogin/social_login_screen.dart';
import 'package:mansour_/modules/tasks/home.dart';
import 'package:mansour_/shared/components/constans.dart';
import 'package:mansour_/shared/cubit/cubit.dart';
import 'package:mansour_/shared/cubit/states.dart';
import 'package:mansour_/styles/themes/themes.dart';
import 'modules/shop app/sharedPreferences.dart/cash_helper.dart';
import 'shared/bloc_observer.dart';

void main() async {
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  DioHelperShop.init();
  await CashHelper.init();
  await CashHelperShop.init();
  bool? isDark = CashHelper.getData(key: 'isDark');
  bool onBoarding = CashHelperShop.getData(key: 'onBoarding');
  token = CashHelperShop.getData(key: 'token');
  Widget widget;

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayoutScreen();
    else
      widget = ShopLoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  print('onBoarding $onBoarding');
  print('Token $token');

  runApp(MyApp(isDark!, widget));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp(this.isDark, this.startWidget);
  // const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusieness()
            ..getSports()
            ..getSiences(),
        ),
        BlocProvider(
          create: (context) => AppCubit()..changeMode(fromShared: isDark),
        ),
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites()
              ..getUserData()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SocialLoginScreen(),
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }
}

//  SOCIAL APP
// MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => NewsCubit()
//             ..getBusieness()
//             ..getSports()
//             ..getSiences(),
//         ),
//         BlocProvider(
//           create: (context) => AppCubit()..changeMode(fromShared: isDark),
//         ),
//         BlocProvider(create: (context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData()),
//       ],
//       child: BlocConsumer<AppCubit, AppStates>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             home: startWidget,
//             theme: lightTheme,
//             darkTheme: darkTheme,
//             themeMode:
//                 AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
//           );
//         },
//       ),
//     )
