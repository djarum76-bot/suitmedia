import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:suitmedia/bloc/user_bloc.dart';
import 'package:suitmedia/component/app_button.dart';
import 'package:suitmedia/util/app_theme.dart';
import 'package:suitmedia/util/routes.dart';

class SecondScreen extends StatelessWidget{
  const SecondScreen({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _secondAppBar(context),
      body: _secondBody(context),
    );
  }

  AppBar _secondAppBar(BuildContext context){
    return AppBar(
      backgroundColor: AppTheme.scaffoldColor,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back_ios, color: AppTheme.textColor,),
      ),
      title: Text(
        "Second Screen",
        style: GoogleFonts.poppins(color: AppTheme.textColor, fontWeight: FontWeight.w600, fontSize: 18.sp),
      ),
      centerTitle: true,
    );
  }

  Widget _secondBody(BuildContext context){
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(1.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _secondData(),
          _secondButton(context)
        ],
      ),
    );
  }

  Widget _secondData(){
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome",
            style: GoogleFonts.poppins(color: AppTheme.textColor, fontWeight: FontWeight.w400, fontSize: 15.5.sp),
          ),
          Text(
            name,
            style: GoogleFonts.poppins(color: AppTheme.textColor, fontWeight: FontWeight.w600, fontSize: 18.sp),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Selected User Name",
                    style: GoogleFonts.poppins(color: AppTheme.textColor, fontWeight: FontWeight.w500, fontSize: 21.sp),
                  ),
                  _secondSelectedUser()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _secondSelectedUser(){
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state){
        if(state.user == null){
          return const SizedBox();
        }else{
          return Text(
            "${state.user!.firstName} ${state.user!.lastName}",
            style: GoogleFonts.poppins(color: AppTheme.textColor, fontWeight: FontWeight.w500, fontSize: 21.sp),
          );
        }
      },
    );
  }

  Widget _secondButton(BuildContext context){
    return AppButton(onPressed: () => Navigator.pushNamed(context, Routes.thirdScreen), text: "Choose a User");
  }
}