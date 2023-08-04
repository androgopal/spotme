import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotme/HttpServices/HttpService.dart';
import 'package:spotme/Screens/UserProfile/Bloc/profile_state.dart';
import 'package:spotme/Screens/UserProfile/models/profile_model.dart';

class ProfileBloc extends Cubit<ProfileState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ApiService _userRepository;
  String? name;
  String? gender;
  bool? discoverme;
  String? instagramUrl;
  String? facebookUrl;
  String? interest;
  // File? profileImage;
  // File? coverImage;


  ProfileBloc(this._userRepository) : super(ProfileInitialState());

  void fetchProfileDetails(String? phone) async {
    emit(ProfileLoadingState());
    User? currentUser = _auth.currentUser;
      print(currentUser);
    if (currentUser != null) {
      ProfileModel? profileModel = await ApiService.shared.readUserData(phone ?? currentUser.phoneNumber);
      emit(ProfileDetails(profileModel));
      print("ProfileDetails");
    } else {
      emit(ProfileErrorState("User is not found"));
      print("User is not found");

    }
  }

  void fetchUpdateDetails() async {

  }

  void fetchDeleteProfileDetails() async {}


}

