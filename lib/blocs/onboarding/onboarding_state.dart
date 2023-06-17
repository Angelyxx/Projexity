part of 'onboarding_bloc.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnBoardingLoading extends OnboardingState {}

class OnBoardingLoaded extends OnboardingState {
  final User user;

  OnBoardingLoaded({required this.user});

  @override
  List<Object> get props => [user];
}
