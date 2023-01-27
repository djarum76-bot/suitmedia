import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:suitmedia/bloc/user_bloc.dart';
import 'package:suitmedia/model/user_model.dart';
import 'package:suitmedia/util/app_theme.dart';
import 'package:line_icons/line_icons.dart';

class ThirdScreen extends StatelessWidget{
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<UserBloc>(context)..add(UserFetched(1)),
      child: Scaffold(
        appBar: _thirdAppBar(context),
        body: _thirdBody(context),
      ),
    );
  }

  AppBar _thirdAppBar(BuildContext context){
    return AppBar(
      backgroundColor: AppTheme.scaffoldColor,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back_ios, color: AppTheme.textColor,),
      ),
      title: Text(
        "Third Screen",
        style: GoogleFonts.poppins(color: AppTheme.textColor, fontWeight: FontWeight.w600, fontSize: 18.sp),
      ),
      centerTitle: true,
    );
  }

  Widget _thirdBody(BuildContext context){
    return BlocListener<UserBloc, UserState>(
      listener: (context, state){
        if(state.status == UserStatus.loading){
          EasyLoading.show(status: "Loading...");
        }
        if(state.status == UserStatus.error){
          EasyLoading.showError(state.message ?? "Error");
        }
        if(state.status == UserStatus.fetched){
          EasyLoading.dismiss();
        }
        if(state.status == UserStatus.selected){
          EasyLoading.dismiss();
          Navigator.pop(context);
        }
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(0, 1.5.h, 0, 0),
        child: Column(
          children: [
            _thirdUserData(context),
            _thirdPagination(context)
          ],
        ),
      ),
    );
  }

  Widget _thirdUserData(BuildContext context){
    return Expanded(
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state){
          if(state.status != UserStatus.fetched){
            return const SizedBox();
          }else{
            if(state.users.isEmpty){
              return Center(
                child: Lottie.asset("asset/no-data.json"),
              );
            }else{
              return RefreshIndicator(
                onRefresh: ()async{
                  return Future.delayed(const Duration(seconds: 2), (){
                    BlocProvider.of<UserBloc>(context).add(UserRefresh());
                  });
                },
                child: ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index){
                    return _thirdUserTile(context, state.users[index]);
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }

  Widget _thirdUserTile(BuildContext context, UserModel user){
    return ListTile(
      onTap: () => BlocProvider.of<UserBloc>(context).add(UserSelected(user)),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.avatar),
      ),
      title: Text(
        "${user.firstName} ${user.lastName}",
        style: GoogleFonts.poppins(color: AppTheme.textColor, fontWeight: FontWeight.w500, fontSize: 17.sp),
      ),
      subtitle: Text(
        user.email,
        style: GoogleFonts.poppins(color: AppTheme.textColor, fontWeight: FontWeight.w500, fontSize: 15.sp),
      ),
    );
  }

  Widget _thirdPagination(BuildContext context){
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state){
        return Container(
          width: double.infinity,
          height: 8.h,
          padding: EdgeInsets.fromLTRB(1.5.h, 0, 1.5.h, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              state.page == 1 ? const SizedBox() : GestureDetector(
                onTap: () => BlocProvider.of<UserBloc>(context).add(UserFetched(state.page - 1)),
                child: CircleAvatar(
                  radius: 3.h,
                  child: const Icon(LineIcons.arrowLeft),
                ),
              ),
              state.page == 3 ? const SizedBox() : GestureDetector(
                onTap: () => BlocProvider.of<UserBloc>(context).add(UserFetched(state.page + 1)),
                child: CircleAvatar(
                  radius: 3.h,
                  child: const Icon(LineIcons.arrowRight),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}