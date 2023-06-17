// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storage_repository/storage_repository.dart';

import '../../models/user_model.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnBoardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final DatabaseRepository _databaseRepository;
  final StorageRepository _storageRepository;
  OnBoardingBloc({
    required DatabaseRepository databaseRepository,
    required StorageRepository storageRepository,
  })  : _databaseRepository = databaseRepository,
        _storageRepository = storageRepository,
        super(OnBoardingLoading()) {
    void _onStartOnBoarding(
        StartOnboarding event, Emitter<OnboardingState> emit) async {
      User user =
          User(id: '', name: '', age: 0, profileImageUrl: '', interests: []);

      //String documentId = await _databaseRepository.createUser(user);
      //emit(OnBoardingLoaded(user: user.copyWith(id: documentId)));
    }

    void _onUpdateUser(UpdateUser event, Emitter<OnboardingState> emit) {}

    void _onUpdateUserImages(
        UpdateUserImages event, Emitter<OnboardingState> emit) {}

    on<StartOnboarding>(_onStartOnBoarding);
    on<UpdateUser>(_onUpdateUser);
    on<UpdateUserImages>(_onUpdateUserImages);
  }
}
