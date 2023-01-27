import 'package:flutter_bloc/flutter_bloc.dart';

class PalindromeCubit extends Cubit<bool?>{
  PalindromeCubit() : super(null);

  void isPalindrome(String original){
    if(original == ""){
      emit(null);
    }else{
      String reverse = original.split('').reversed.join('');

      if(original == reverse){
        emit(true);
      }else{
        emit(false);
      }
    }
  }
}