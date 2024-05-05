import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/core/utils/utils.dart';
import 'package:ics321/modules/home/presentation/provider/providers.dart';
import 'package:ics321/modules/home/presentation/widget/bottom_bar.dart';
import 'package:ics321/modules/home/presentation/widget/flight_card.dart';
import 'package:ics321/modules/home/presentation/widget/profile_setting.dart';
import 'package:ics321/shared/custom_text.dart';

class HomeScreen extends ConsumerWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final bottomBarIndex=ref.watch(bottomBarProvider);
    return Scaffold(
     appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
            actions: [
              TextButton(onPressed: (){
                FirebaseAuth.instance.signOut();
                Utils.user=null;
                
              }, child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText("logOut".tr(),
                    color: Colors.white,),
                  ),
                  const Icon(Icons.logout,
                  color: Colors.white,),
                ],
              )),
              Spacer(),
              TextButton(onPressed: (){
                if (Utils.appOnAr){
                  context.setLocale(const Locale("en","US"));
                  Utils.appOnAr=false;
                }
                else {
                  context.setLocale(const Locale("ar","SA"));
                  Utils.appOnAr=true;
                }
                
              }, child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText("lang".tr(),
                    color: Colors.white,),
                  ),
                  const Icon(Icons.language,
                  color: Colors.white,),
                ],
              )),

              
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
      body: Builder(
        builder: (context) {
          if (bottomBarIndex==0){
            return Center(child: FlightCard());

          }
          else if (bottomBarIndex ==1 ){
            return Text("data");
          }
          else {
            return Center(child: ProfileCard());
          }
        }
      ),
      bottomNavigationBar:  ButtomBar(),
    );
  }

}