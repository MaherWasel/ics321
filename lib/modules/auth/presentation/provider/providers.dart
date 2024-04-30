import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ics321/core/utils/utils.dart';
import 'package:ics321/modules/auth/data/repository.dart';

abstract class AuthStates{}
class AuthIntial extends AuthStates{}
class AuthLoading extends AuthStates{}
class AuthSmSVerification extends AuthStates{}
class AuthFailure extends AuthStates{}
class AuthSucess extends AuthStates{}

class AuthStateNotifier extends StateNotifier<AuthStates> {
  AuthStateNotifier(): super(AuthIntial());
  AuthRepository authRepo=AuthRepository();
  String? verficationId="";
  String phoneNum="";
  final smsInput=["","","","","",""];
  Future<void> sendOtp()async{
    try{
      state = AuthLoading();


      final response=await authRepo.sendOtp(phoneNum: phoneNum);

      verficationId=response;
      state=AuthSmSVerification();
      
    
    }on FirebaseAuthException {
      state=AuthFailure();
    }

    
  }
  void modifySmS({required int index,required String smsValue}){
    smsInput[index]=smsValue;
  }
  Future<void> confirmSmS()async {
    String sms="";
    for (int i=0;i<smsInput.length;i++){
      sms+=smsInput[i];
    }
    try{
      state = AuthLoading();
      final userInf=await authRepo.verifySmS( otp: sms);
      Utils.userId=userInf?.user?.uid??"";
      state=AuthSucess();
    }
    on FirebaseAuthException {
      state=AuthFailure();
    }
  }
  Stream<User?> getAuthUserState()=>authRepo.getAuthState();
}
final authStateProvider = StateNotifierProvider<AuthStateNotifier,AuthStates>((ref) {
  return AuthStateNotifier();
});