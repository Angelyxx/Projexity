import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:projexity/blocs/auth/auth_bloc.dart';
import 'package:projexity/models/user_model.dart';

import '../../repositories/databases/database_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  //final AuthBloc _authBloc;
  final DatabaseRepository _databaseRepository;
  StreamSubscription? _authSubscription;

  ProfileBloc({
    //required AuthBloc authBloc,
    required DatabaseRepository databaseRepository,
  })   //: _authBloc = authBloc,
  : _databaseRepository = databaseRepository,
        super(ProfileLoading()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);

    LoadProfile(userId: auth.FirebaseAuth.instance.currentUser!.uid);
    // _authSubscription = _authBloc.stream.listen((state) {
    //   if (state.user is AuthUserChanged) {
    //     if (state.user != null) {
    //       add(LoadProfile(userId: state.user!.uid));
    //     }
    //   }
    // });
    //LoadProfile(userId: state.user!.uid);
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    var doc = await userCollection.doc(event.userId).get();

    if (doc.exists) {
      User user = _databaseRepository.getUserStreamRhys(event.userId) as User;
      add(UpdateProfile(user: user));
    } else {
      print('userId does not exist in the firebase');
      print('tried' + event.userId);
    }
  }

  void _onUpdateProfile(
    UpdateProfile event,
    Emitter<ProfileState> emit,
  ) {
    emit(ProfileLoaded(user: event.user));
  }

  @override
  Future<void> close() async {
    _authSubscription?.cancel();
    super.close();
  }
}
