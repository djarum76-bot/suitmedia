import 'dart:io';

import 'package:suitmedia/model/user_model.dart';
import 'package:suitmedia/service/internet_service.dart';
import 'package:dio/dio.dart';
import 'package:suitmedia/util/constants.dart';

class UserRepository{
  Future<List<UserModel>> getAllUser(int page)async{
    try{
      final response = await InternetService.dio.get("/api/users?page=$page",
        options: Options(
          headers: {
            HttpHeaders.acceptHeader : Constants.appJson
          }
        )
      );

      if(response.statusCode == 200){
        final datas = response.data[Constants.data] as List;
        final list = datas.map((data) => UserModel.fromJson(data)).toList();
        return list;
      }else{
        throw Exception();
      }
    }catch(e){
      throw Exception(e);
    }
  }
}