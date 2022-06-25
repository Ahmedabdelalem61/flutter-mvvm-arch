import 'package:dartz/dartz.dart';
import 'package:flutter_mvvm_app/Data/network/faiure.dart';
import 'package:flutter_mvvm_app/Domain/models/models.dart';

import '../requests.dart';

abstract class Repository{
  // we will implement it in the data layer
  /// so that apiServices -> remoteDataSource -> repositoryImplementer to come up only with the toDomain model so it works as a black box
  Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure,String>> forgotPassword(String email);
  Future<Either<Failure,Authentication>> register(RegisterRequest registerRequest);
  Future<Either<Failure,HomeObject>> getHomeData();
  Future<Either<Failure,StoreDetails>> getStoreDetailsData();
}