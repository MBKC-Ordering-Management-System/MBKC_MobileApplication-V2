import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user_model.dart';

final authProvider = StateProvider<UserModel?>((ref) => null);
