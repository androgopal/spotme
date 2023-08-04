
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotme/Screens/UserProfile/models/profile_model.dart';

abstract class ProfileState{}

class ProfileInitialState extends ProfileState{}
class ProfileLoadingState extends ProfileState{}
class ProfileDetails extends ProfileState{
  final ProfileModel? userDetails;
  ProfileDetails(this.userDetails);
}
class ProfileErrorState extends ProfileState{
  final String message;
  ProfileErrorState(this.message);
}
class ProfileUpdatedState extends ProfileState{}
class ProfileDeleteProfileState extends ProfileState{}
