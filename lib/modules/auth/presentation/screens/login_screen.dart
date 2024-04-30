import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/core/utils/utils.dart';
import 'package:ics321/modules/auth/presentation/provider/providers.dart';
import 'package:ics321/modules/auth/presentation/widgets/froasted_glass.dart';
import 'package:ics321/modules/auth/presentation/widgets/login_container.dart';
import 'package:ics321/modules/auth/presentation/widgets/verify_sms_container.dart';
import 'package:ics321/shared/custom_text.dart';

class LoginScreen extends ConsumerWidget{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final sizes = MediaQuery.of(context).size;
    final authState= ref.watch(authStateProvider);
    return StreamBuilder<User?>(
      stream: ref.read(authStateProvider.notifier).getAuthUserState(),
      builder: (context, snapshot) {
        if (snapshot.hasData){
          Utils.userId=snapshot.data?.uid??"";
          // would be changed when we do the home page
          return  Scaffold(
            body: Center(child: 
            ElevatedButton(onPressed: (){
              FirebaseAuth.instance.signOut();
            }, child: const Text("logout")),));
        }
        
        return Scaffold(
          appBar: AppBar(
            actions: [
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
                    child: CustomText("lang".tr()),
                  ),
                  const Icon(Icons.language),
                ],
              ))
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          body:  Builder(
            builder: (context) {
              if (authState is AuthSmSVerification || authState is AuthLoading){
                return const VerifySmSContainer();

              }
              else {
                return const LoginContainer();
              }
            }
          ),
        );
      }
    );
  }
}