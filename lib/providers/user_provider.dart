import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../services/user_service.dart';

final userProvider = FutureProvider<User?>((ref) async {
  return UserService.getUser();
});