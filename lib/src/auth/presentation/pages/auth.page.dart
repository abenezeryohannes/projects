import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rnginfra/src/core/widgets/big.text.button.dart';
import 'package:rnginfra/src/core/widgets/custom.shimmer.dart';
import 'package:rnginfra/src/core/widgets/loading.bar.dart';
import 'package:rnginfra/src/flavors.dart';
import 'package:rnginfra/src/guards/guard.main.page.dart';
import 'package:rnginfra/src/residents/visitors/presentation/residents.main.page.dart';

import '../../../../main/injectable/getit.dart';
import '../../domain/entities/country.entity.dart';
import '../bloc/auth.state.bloc.dart';
import 'slides/confirm.slide.dart';
import 'slides/signup.slide.dart';
import 'slides/landing.slide.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key, required this.onAuthentication}) : super(key: key);
  final Function onAuthentication;
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  double _height = 0;

  ///CONTROLLERS VARIABLES

  PageController pageController = PageController(initialPage: 0);

  AuthStateBloc authBloc = getIt<AuthStateBloc>();

  void updateHeight() {
    _height = (pageController.page ?? 0) < 1
        ? MediaQuery.of(context).size.height * (4 / 12)
        : MediaQuery.of(context).size.height * (10 / 12);
  }

  void minimizeHeight() {
    _height = MediaQuery.of(context).size.height * (4 / 12) + 30;
  }

  void maximizeHeight() {
    _height = MediaQuery.of(context).size.height * (10 / 12) + 30;
  }

  void fillHeight() {
    _height = MediaQuery.of(context).size.height;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (authBloc.state.runtimeType == VerifiyingAuthState ||
            authBloc.state.runtimeType == VerificationFailedAuthState ||
            authBloc.state.runtimeType == NotVerifiedAuthState) {
          authBloc.add(OnAuthInitialEvent());
        } else if (authBloc.state.runtimeType == CodeSentAuthState ||
            authBloc.state.runtimeType == VerifiedAuthState ||
            authBloc.state.runtimeType == ConfirmingAuthState ||
            authBloc.state.runtimeType == ConfirmationFailedAuthState) {
          authBloc.add(OnNotVerifiedEvent(isNewUser: authBloc.isNewUser));
        } else {
          return true;
        }
        return false;
      },
      child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Stack(
            children: [
              Image.asset(
                  'assets/img/${FFF.appFlavor == Flavor.guards ? "guards" : "visitors"}_landing.jpg',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * (8 / 12),
                  fit: BoxFit.cover),
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedSize(
                    curve: Curves.fastEaseInToSlowEaseOut,
                    duration: const Duration(milliseconds: 1000),
                    child: Container(
                        height: _height == 0
                            ? MediaQuery.of(context).size.height * (4 / 12)
                            : _height,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: SingleChildScrollView(child: _body())),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget _body() {
    return BlocProvider(
      create: (_) => authBloc,
      child:
          BlocBuilder<AuthStateBloc, AuthStateState>(builder: (context, state) {
        // print("state: ${state.toString()}");
        switch (state.runtimeType) {
          case AuthStateInitial:
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                minimizeHeight();
              });
            });
            return slide(0, state);
          case VerifiyingAuthState:
          case VerificationFailedAuthState:
          case NotVerifiedAuthState:
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                maximizeHeight();
              });
            });
            return slide(1, state);
          case CodeSentAuthState:
          case VerifiedAuthState:
          case ConfirmingAuthState:
          case ConfirmationFailedAuthState:
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                maximizeHeight();
              });
            });
            return slide(2, state);
          case ConfirmedAuthState:
            if (_height != MediaQuery.of(context).size.height) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  fillHeight();
                });
              });
            }
            return slide(3, state);
          case GettingTokenAuthState:
          case GettingTokenFailureAuthState:
          case GettingTokenSuccessAuthState:
            return slide(3, state);
        }
        return slide(0, state);
      }),
    );
  }

  Widget slide(int index, AuthStateState state) {
    return Column(
      children: [
        if (state.runtimeType == ConfirmingAuthState ||
            state.runtimeType == VerifiyingAuthState)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.0),
            child: LoadingBar(
              color: Color(0xFF395873),
              backColor: Colors.white,
            ),
          ),
        // _appBar(),
        SizedBox(
            //TODO height: index == 0 ?  : 720,
            child: index == 0
                ? landingSlide(state)
                : index == 1
                    ? signUpSlide(state)
                    : index == 2
                        ? confirmSlide(state)
                        : index == 3
                            ? formSlide(state)
                            : landingSlide(state))
      ],
    );
  }

  Widget landingSlide(AuthStateState state) {
    return LandingSlide(
      onGetStarted: () {
        setState(() {
          maximizeHeight();
        });
        authBloc.add(const OnNotVerifiedEvent(isNewUser: true));
      },
      onHaveAccount: () {
        setState(() {
          maximizeHeight();
        });
        authBloc.add(const OnNotVerifiedEvent(isNewUser: false));
      },
    );
  }

  void openMainPage() {
    Future.delayed(const Duration(milliseconds: 100), () {
      Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  (FFF.appFlavor == Flavor.residents)
                      ? const ResidentMainPage()
                      : const GuardMainPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                final offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              }),
          (route) => false);
    });
  }

  Widget signUpSlide(AuthStateState state) {
    return SignupSlide(
      hint: '0000000000',
      onChanged: (String val) {
        authBloc.phoneNumber = val;
      },
      value: authBloc.phoneNumber,
      onCountryChange: (MyCountry? country) {
        authBloc.country = country;
      },
      countries: authBloc.countries,
      country: authBloc.country,
      error: state.runtimeType == VerificationFailedAuthState
          ? (state as VerificationFailedAuthState).failure.message
          : null,
      onNext: () {
        authBloc.add(OnVerifyEvent(phoneNumber: authBloc.phoneNumber));
      },
      onBack: () {
        authBloc.add(OnAuthInitialEvent());
      },
      loading: state.runtimeType == VerifiyingAuthState,
    );
  }

  Widget confirmSlide(AuthStateState state) {
    return ConfirmSlide(
      onResendCode: () {
        authBloc.add(
            OnResendConfirmationCodeEvent(resendToken: authBloc.resendToken));
      },
      error: state.runtimeType == ConfirmationFailedAuthState
          ? (state as ConfirmationFailedAuthState).failure.message
          : null,
      onCodeChange: (val) {
        if (val.trim().length > 6) {
          authBloc.confirmationCode = val.trim().substring(0, 6);
        } else {
          authBloc.confirmationCode = val;
        }
      },
      phoneNumber: authBloc.phoneNumber,
      code: authBloc.confirmationCode,
      onConfirm: () {
        authBloc.add(OnConfirmEvent(code: authBloc.confirmationCode));
      },
      onBack: () {
        authBloc.add(OnNotVerifiedEvent(isNewUser: authBloc.isNewUser));
      },
      loading: state.runtimeType == ConfirmingAuthState,
    );
  }

  Widget formSlide(AuthStateState state) {
    if (state.runtimeType == GettingTokenSuccessAuthState) {
      openMainPage();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 200,
        ),
        if (state.runtimeType == GettingTokenAuthState)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                    child: CustomShimmer(
                  show: true,
                  baseColor: Colors.grey.shade700,
                  highlightColor: Colors.grey.shade300,
                  child: Text(
                    'Wait a moment ...',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                )),
              ),
            ],
          ),
        if (state.runtimeType == GettingTokenSuccessAuthState)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  radius: 30,
                  child: const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 32,
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                    child: Text(
                  'Successfully Signed in!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.grey.shade700),
                )),
              ),
            ],
          ),
        if (state.runtimeType == GettingTokenFailureAuthState)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                    child: Text(
                  (state as GettingTokenFailureAuthState).failure.message ?? '',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Theme.of(context).colorScheme.error),
                )),
              ),
              SizedBox(
                width: 100,
                child: BigTextButton(
                  onClick: () {
                    if (FirebaseAuth.instance.currentUser != null) {
                      authBloc.add(OnConfirmedEvent(
                          user: FirebaseAuth.instance.currentUser!));
                    } else {
                      if (authBloc.phoneNumber.isNotEmpty) {
                        authBloc.add(
                            OnVerifyEvent(phoneNumber: authBloc.phoneNumber));
                      } else {
                        authBloc.add(OnAuthInitialEvent());
                      }
                    }
                  },
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  backgroudColor: Theme.of(context).cardColor,
                  text: 'Retry',
                ),
              )
            ],
          ),
      ],
    );
    // return FillUserForm(
    //   isKeyboardVisible: MediaQuery.of(context).viewInsets.bottom != 0,
    //   //userW: controller.userModel.value,
    //   //userDto: controller.userDto.value,
    //   isLoading: (isLoading) => isLoading = isLoading,
    //   onUpload: (path) => SizedBox(), //TODO,
    //   onNameChange: (name) => SizedBox(), //TODO
    //   onFocus: (bool focus) {
    //     setState(() {
    //       //TODO
    //     });
    //   },
    //   onNext: () {
    //     if (authBloc.user != null) {
    //       authBloc.add(OnConfirmedEvent(user: authBloc.user!));
    //     }
    //   },
    // );
  }
}
