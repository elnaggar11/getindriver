import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:getin_driver/firebase_options.dart';

import 'core/Router/Router.dart';
import 'core/Router/logging_route_observer.dart';
import 'core/Router/navigation_helper.dart';
import 'core/data_source/hive_service.dart';
import 'core/general/general_cubit.dart';
import 'core/localization/generated/app_localizations.dart';
import 'core/localization/localization_helper.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'core/utils/Locator.dart';
import 'core/utils/general_constants.dart';
import 'core/utils/responsive_framework_widget.dart';
import 'core/utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init([GeneralConstants.appBoxName]); // bloc observer
  Bloc.observer = MyBlocObserver();
  // dotenv.load();
  await setupLocator();
  // Utils.getToken();
  await Utils.dataManager.initHive();
  await Utils.getUser();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocProvider(
        create: (context) => locator<GeneralCubit>(),
        child: BlocConsumer<GeneralCubit, GeneralState>(
          listener: (context, state) {},
          // listenWhen: (previous, current)=>cubit. ,
          builder: (context, state) {
            Utils.rebuildAllChildren(context);

            final cubit = GeneralCubit.get(context);
            return MaterialApp(
              title: 'GetIn',
              navigatorObservers: [LoggingRouteObserver()],
              themeAnimationDuration: const Duration(milliseconds: 700),
              themeAnimationCurve: Curves.easeInOutCubic,
              debugShowCheckedModeBanner: false,

              localizationsDelegates: const [
                ...AppLocalizations.localizationsDelegates,
                LocalizationHelper.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              locale: LocalizationHelper.currentLocale,
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale?.languageCode &&
                      supportedLocale.countryCode == locale?.countryCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              navigatorKey: NavigationService.navigatorKey,

              builder: (_, child) {
                final botToastBuilder = BotToastInit();
                final smartDialog = FlutterSmartDialog.init();
                child = smartDialog(context, child);
                child = botToastBuilder(context, child);
                SystemChrome.setSystemUIOverlayStyle(
                  cubit.isLightMode
                      ? SystemUiOverlayStyle.dark
                      : SystemUiOverlayStyle.light,
                );
                return AppResponsiveWrapper(child: child);
              },
              onGenerateRoute: RouteGenerator.getRoute,
              // themeMode: cubit.isLightMode ? ThemeMode.light : ThemeMode.dark,
              // theme: cubit.isLightMode ? LightTheme.getTheme() : DarkTheme.getTheme(),
              themeMode: ThemeMode.light,
              theme: LightTheme.getTheme(),
              darkTheme: DarkTheme.getTheme(),
              initialRoute: Routes.splashScreen,
            );
          },
        ),
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent -- ${bloc.runtimeType} -- $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType} -- $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- ${bloc.runtimeType} -- $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType} -- $error -- $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    print('onClose -- ${bloc.runtimeType}');
    super.onClose(bloc);
  }
}
