import 'package:dio/dio.dart';

class DioHelperSocial {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
    print('dio created successfully');
  }

  static getData(
      {required String url,
      Map<String, dynamic>? query,
      String lang = 'ar',
      String? token,
        required Function(Response response) onSuccess,
        required Function(MyError myError) onFailed}) async {
    print(url);
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? ''
    };
    try{
     Response response= await dio.get(url, queryParameters: query);
      onSuccess(response);
    } on DioError catch(error) {
      onFailed(MyError(error.response, error.toString()));
    }catch(error){
      onFailed(MyError(null, error.toString()));
    }

  }

  static void postData(
      {required String url,
      required Map<String, dynamic> data,
      Map<String, dynamic>? query,
      String lang = 'ar',
      String? token,
      required Function(Response response) onSuccess,
      required Function(MyError myError) onFailed}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? ''
    };
    try {
      Response response =
          await dio.post(url, queryParameters: query, data: data);
      onSuccess(response);
    } on DioError catch (error) {
      onFailed(MyError(error.response, error.toString()));
    } catch (error) {
      onFailed(MyError(null, error.toString()));
    }
  }


    static void putData(
      {required String url,
      required Map<String, dynamic> data,
      Map<String, dynamic>? query,
      String lang = 'ar',
      String? token,
      required Function(Response response) onSuccess,
      required Function(MyError myError) onFailed}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? ''
    };
    try {
      Response response =
          await dio.put(url, queryParameters: query, data: data);
      onSuccess(response);
    } on DioError catch (error) {
      onFailed(MyError(error.response, error.toString()));
    } catch (error) {
      onFailed(MyError(null, error.toString()));
    }
  }
}

class MyError {
  Response? response;
  late String message;

  MyError(this.response, this.message);

  @override
  String toString() {
    // TODO: implement toString
    if (response != null) {
      return response!.data['msg'];
    } else {
      return message;
    }
  }
}
