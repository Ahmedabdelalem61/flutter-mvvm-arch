import 'package:flutter_mvvm_app/App/extensions.dart';

import '../../App/constants.dart';
import '../../Domain/models/models.dart';
import '../responses/responses.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id.orEmpty() ?? Constants.empty,
        this?.name.orEmpty() ?? Constants.empty,
        this?.numOfNotifications.orZero() ?? Constants.zero);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
        this?.phone.orEmpty() ?? Constants.empty,
        this?.email.orEmpty() ?? Constants.empty,
        this?.link.orEmpty() ?? Constants.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this?.customer.toDomain(), this?.contacts.toDomain());
  }
}
extension ForgotPasswordResponseMApper on ForgotPasswordResponse? {
  String toDomain(){
    return this?.support.orEmpty() ?? Constants.empty;
  }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain(){
    return Service(this?.id ?? Constants.empty, this?.title ?? Constants.empty, this?.image ?? Constants.empty);
  }
}

extension BannerResponseMapper on BannerResponse? {
  Banner toDomain(){
    return Banner(this?.id ?? Constants.empty, this?.title ?? Constants.empty, this?.image ?? Constants.empty);
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain(){
    return Store(this?.id ?? Constants.empty, this?.title ?? Constants.empty, this?.image ?? Constants.empty);
  }
}

extension HomeResponseMapper on HomeResponse?{
  HomeObject toDomain(){
  List<Banner> banners = (this?.data.bannersResponse.map((bannerResponse) => bannerResponse.toDomain())?? const Iterable.empty()).cast<Banner>().toList();
  List<Service> services = (this?.data.servicesResponse.map((servicesResponse) => servicesResponse.toDomain())?? const Iterable.empty()).cast<Service>().toList();
  List<Store> stores = (this?.data.storesResponse.map((storesResponse) => storesResponse.toDomain())?? const Iterable.empty()).cast<Store>().toList();
  HomeData data = HomeData(banners,services,stores);
    
    return HomeObject(data);
  }
} 