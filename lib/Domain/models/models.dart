class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}

class HomeViewData{
  List<BannerAds> banners;
  List<Store> stores;
  List<Service> services;
  HomeViewData({required this.banners,required this.services,required this.stores});
}

// login
class Customer {
  String id;
  String name;
  int numOfNotifications;

  Customer(this.id, this.name, this.numOfNotifications);
}

class Contacts {
  String phone;
  String email;
  String link;

  Contacts(this.phone, this.email, this.link);
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer, this.contacts);
}


class Service {
  int? id;
  String? title;
  String? image;
  Service(this.id, this.title, this.image);
}

class BannerAds {
  int? id;
  String? title;
  String? image;
  BannerAds(this.id, this.title, this.image);
  
}

class Store {
  int? id;
  String? title;
  String? image;
  Store(this.id, this.title, this.image);
}

class HomeData {
  List<Service> services;
  List<BannerAds> banners;
  List<Store> stores;

  HomeData(
      this.banners, this.services, this.stores);
}

class HomeObject{
  HomeData data;

  HomeObject(
      this.data);
}

class StoreDetails {
String image;
String title;
String details;
String services;
String about;
StoreDetails({required this.about,required this.title,required this.services,required this.image,required this.details});
}
