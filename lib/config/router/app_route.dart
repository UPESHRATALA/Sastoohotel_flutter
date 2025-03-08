import 'package:flutter/widgets.dart';
import 'package:room_finder_app/fetures/auth/presentation/view/login.dart';
import 'package:room_finder_app/fetures/auth/presentation/view/register.dart';
import 'package:room_finder_app/fetures/home/presentation/view/dashboard.dart';
import 'package:room_finder_app/fetures/room/domain/entity/room_entity.dart';
import 'package:room_finder_app/fetures/room/presentation/view/update_rooms.dart';
import 'package:room_finder_app/fetures/room/presentation/view/upload_image_view.dart';
import 'package:room_finder_app/fetures/splash/presentation/view/splash_view.dart';

//sasto-hotel
class AppRoute {
  AppRoute._();

  static const String splashRoute = '/splash';
  static const String dashboardRoute = '/home';
  static const String signInRoute = '/signIn';
  static const String singUpRoute = '/signUp';
  static const String uploadViews = '/upload';
  static const String updateRoom = '/update';

  static getApplicationRoute() {
    return {
      splashRoute: (context) => const SplashView(),
      signInRoute: (context) => const LogIn(),
      singUpRoute: (context) => const Register(),
      dashboardRoute: (context) => const DashBoard(),
      uploadViews: (context) => const UploadView(),
      updateRoom: (context) {
        final room = ModalRoute.of(context)!.settings.arguments as RoomEntity;
        return UpdateView(room: room);
      },
    };
  }
}
