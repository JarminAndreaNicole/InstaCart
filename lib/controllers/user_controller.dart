import 'package:get/get.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/user_repo.dart';
import '../models/response_model.dart';
import '../models/signup_body_model.dart';
import '../models/user_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({
    required this.userRepo,
  });

  bool _isLoading = false;
  late UserModel _usermodel;

  bool get isLoading => _isLoading;
  UserModel get userModel => _usermodel;

  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _usermodel = UserModel.fromJson(response.body);
      _isLoading=true;
      responseModel = ResponseModel(true, "Successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }
}