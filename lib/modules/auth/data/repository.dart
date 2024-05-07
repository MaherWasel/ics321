import 'package:firebase_auth/firebase_auth.dart';
import 'package:ics321/core/utils/utils.dart';
import 'package:ics321/modules/auth/data/auth_backend.dart';
import 'package:ics321/shared/models/user.dart';

class AuthRepository {
  String? verficationId;
  FirebaseAuth authInstance=FirebaseAuth.instance;
  AuthBackEnd authBackEnd = AuthBackEnd();
  Stream<User?> getAuthState()=>authInstance.authStateChanges();
  

   Future<String?> sendOtp({required String phoneNum}) async  {
      String verficationId="";
    await authInstance.verifyPhoneNumber(
      phoneNumber: phoneNum,
      verificationCompleted: (info)async {
        await authInstance.signInWithCredential(info);

      }, 
      verificationFailed: (e){

        throw FirebaseAuthException(
          code: e.toString(),
        );
      }, 
      codeSent: (verificationID,v)async{

        this.verficationId=  verificationID;

        return;
      }, 
      codeAutoRetrievalTimeout: (e){

      });
      return verficationId;
  }
  Future<UserModel?> verifySmS({required String otp, String? phoneNum})async{

    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verficationId??"", smsCode: otp);
     final response=await authInstance.signInWithCredential(credential);
    final backendResponse = await authBackEnd.authenticateUser(id: response.user?.uid??"",phoneNumber: phoneNum);
    Utils.userId=response.user?.uid??"";
     return backendResponse;

  }
}
