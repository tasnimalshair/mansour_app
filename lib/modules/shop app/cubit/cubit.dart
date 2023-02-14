import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour_/modules/news/network/remote/dio_helper.dart';
import 'package:mansour_/modules/news/settings/settings_screen.dart';
import 'package:mansour_/modules/shop%20app/Dio/dio_helper.dart';
import 'package:mansour_/modules/shop%20app/app/categories/categories_screen.dart';
import 'package:mansour_/modules/shop%20app/app/favorites/favorites_screen.dart';
import 'package:mansour_/modules/shop%20app/app/products/products_screen.dart';
import 'package:mansour_/modules/shop%20app/cubit/states.dart';
import 'package:mansour_/modules/shop%20app/login/end_points.dart';
import 'package:mansour_/modules/shop%20app/models/categories_model.dart';
import 'package:mansour_/modules/shop%20app/models/favorite_model.dart';
import 'package:mansour_/modules/shop%20app/models/favorites_model.dart';
import 'package:mansour_/modules/shop%20app/models/home%20model/home_model.dart';
import 'package:mansour_/modules/shop%20app/models/login_model.dart';
import 'package:mansour_/modules/shop%20app/sharedPreferences.dart/cash_helper.dart';
import 'package:mansour_/shared/components/constans.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    // FavoritesScreen(),
    SettingScreen()
  ];
  void changeBottom(index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  CategoryModel? categoryModel;

  Map<int, bool> favorites = {};
  FavoritesModel? favoritesModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelperShop.getData(
        url: HOME,
        onSuccess: (response) {
          homeModel = HomeModel.fromJson(response.data);
          homeModel!.data!.products!.forEach((element) {
            favorites.addAll({element.id: element.inFavorites!});
          });
          emit(ShopSuccessHomeDataState());
        },
        onFailed: (myError) {
          emit(ShopErrorHomeDataState(myError.toString()));
        });
  }

  void getCategories() {
    DioHelperShop.getData(
        url: GET_CATEGORIES,
        onSuccess: (response) {
          categoryModel = CategoryModel.fromJson(response.data);
          emit(ShopSuccessCategoriesState());
        },
        onFailed: (myError) {
          print(myError.toString());
          emit(ShopErrorCategoriesState(myError.toString()));
        });
  }

  void changeFavorite(int productId) {
    DioHelperShop.postData(
        token: token,
        url: FAVORITES,
        data: {'product_id': productId},
        onSuccess: (response) {
          favorites[productId] = !favorites[productId]!;
          emit(ShopChangeFavoritesState());

          favoritesModel = FavoritesModel.fromJson(response.data);
          if (!favoritesModel!.status!) {
            favorites[productId] = !favorites[productId]!;
          } else {
            getFavorites();
          }
          emit(ShopSuccessChangeFavoritesState(favoritesModel!));
        },
        onFailed: (myError) {
          favorites[productId] = !favorites[productId]!;
          print(myError.toString());
          emit(ShopErrorChangeFavoritesState(myError.toString()));
        });
  }

  FavoriteModel? favoriteModel;

  void getFavorites() {
    DioHelperShop.getData(
      url: FAVORITES,
      onSuccess: (response) {
        emit(ShopLoadingGetFavoritesState());
        favoriteModel = FavoriteModel.fromJson(response.data);
        emit(ShopSuccessGetFavoritesState());
      },
      onFailed: (myError) {
        emit(ShopErrorGetFavoritesState(myError.toString()));
      },
    );
  }

  ShopLoginModel? userModel;

  void getUserData() {
    DioHelperShop.getData(
      url: PROFILE,
      onSuccess: (response) {
        emit(ShopLoadingUserDataState());
        userModel = ShopLoginModel.fromJson(response.data);
        emit(ShopSuccessUserDataState(userModel!));
      },
      onFailed: (myError) {
        emit(ShopErrorUserDataState(myError.toString()));
      },
    );
  }

  // ShopLoginModel? userModel;

  void updateUserData({
    required String name,
    required String email,
    required String password,
  }) {
    DioHelperShop.putData(
      url: UPDATE_PROFILE,
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
      onSuccess: (response) {
        emit(ShopLoadingUpdateUserState());
        userModel = ShopLoginModel.fromJson(response.data);
        emit(ShopSuccessUpdateUserState(userModel!));
      },
      onFailed: (myError) {
        emit(ShopErrorUpdateUserState(myError.toString()));
      },
    );
  }
}
