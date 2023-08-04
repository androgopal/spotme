import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotme/HttpServices/HttpService.dart';
import 'package:spotme/Screens/MobileLogin/Bloc/authState.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? verificationId;

  AuthCubit() : super(AuthInitialState()) {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      emit(AuthLoggedInState(currentUser));
    } else {
      emit(AuthErrorState("session expired"));
    }
  }

  void sendOTP(String phoneNumber) async {
    if (phoneNumber.trim().length == 0 ){
      emit(AuthErrorState("Please enter mobile number"));
    }
    else if (phoneNumber.length > 0 && phoneNumber.length <  10){
      emit(AuthErrorState("Please enter valid mobile number"));

    }
    else {
      emit(AuthLoadingState());
      await _auth.verifyPhoneNumber(
          phoneNumber: "+91${phoneNumber}",
          codeSent: (verificationId, forceResendingToken) {
            print("Code sent");
            this.verificationId = verificationId;
            emit(AuthCodeSentState());
          },
          verificationCompleted: (phoneAuthCredential) {
            print("verificationCompleted");
            signInWithCredential(phoneAuthCredential as UserCredential);
          },
          verificationFailed: (error) {
            print("verificationFailed {$error}");
            emit(AuthErrorState(error.message.toString()));
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            print("codeAutoRetrievalTimeout");

            this.verificationId = verificationId;
          });
    }
  }

  void verifyOTP(String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId ?? "", smsCode: otp);
    signinWithPhoneNumber(credential);
  }

  void signinWithPhoneNumber(PhoneAuthCredential credential) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      signInWithCredential(userCredential);
      if (userCredential.user != null) {
        emit(AuthLoggedInState(userCredential?.user));
        ApiService.shared.readUserData(userCredential.user?.phoneNumber);
      }
    } on FirebaseAuthException catch (ex) {
      emit(AuthErrorState(ex.message.toString()));
    }
  }

  void signInWithCredential(UserCredential credential) async {

  }

  void logut() async{
    _auth.signOut();
    emit(AuthLogOutState());
  }
  void currentUser() async{
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      print(currentUser?.phoneNumber);
      print(currentUser?.displayName);
      print(currentUser?.email);
      print(currentUser?.photoURL);
      print(currentUser?.uid);
    } else {
      emit(AuthErrorState("session expired"));
    }
  }
}
