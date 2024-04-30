import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  String? verficationId;
  FirebaseAuth authInstance=FirebaseAuth.instance;
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
  Future<UserCredential?> verifySmS({required String otp})async{

    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verficationId??"", smsCode: otp);
     final userCredential=await authInstance.signInWithCredential(credential);
     return userCredential;

  }
}
void main(){

}