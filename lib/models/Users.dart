class Users {
  String email;
  String firstName;
  String lastName;
  List<String> roles;
  AvatarUrls avatarUrls;
  String username;
  String password;
  Billing billing;
  Shipping shipping;
  List<MetaData> metaData;

  Users({this.email, this.firstName, this.lastName, this.roles, this.avatarUrls, this.username, this.password, this.billing, this.shipping, this.metaData});

  Users.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    roles = json['roles'].cast<String>();
    avatarUrls = json['avatar_urls'] != null ? new AvatarUrls.fromJson(json['avatar_urls']) : null;
    username = json['username'];
    password = json['password'];
    billing = json['billing'] != null ? new Billing.fromJson(json['billing']) : null;
    shipping = json['shipping'] != null ? new Shipping.fromJson(json['shipping']) : null;
    if (json['meta_data'] != null) {
      metaData = new List<MetaData>();
      json['meta_data'].forEach((v) {
        metaData.add(new MetaData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['roles'] = this.roles;
    if (this.avatarUrls != null) {
      data['avatar_urls'] = this.avatarUrls.toJson();
    }
    data['username'] = this.username;
    data['password'] = this.password;
    if (this.billing != null) {
      data['billing'] = this.billing.toJson();
    }
    if (this.shipping != null) {
      data['shipping'] = this.shipping.toJson();
    }
    if (this.metaData != null) {
      data['meta_data'] = this.metaData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AvatarUrls {
  String s24;

  AvatarUrls({this.s24});

  AvatarUrls.fromJson(Map<String, dynamic> json) {
    s24 = json['24'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['24'] = this.s24;
    return data;
  }
}

class Billing {
  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String postcode;
  String country;
  String state;
  String email;
  String phone;

  Billing({this.firstName, this.lastName, this.company, this.address1, this.address2, this.city, this.postcode, this.country, this.state, this.email, this.phone});

  Billing.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    postcode = json['postcode'];
    country = json['country'];
    state = json['state'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['company'] = this.company;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['postcode'] = this.postcode;
    data['country'] = this.country;
    data['state'] = this.state;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

class Shipping {
  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String postcode;
  String country;
  String state;

  Shipping({this.firstName, this.lastName, this.company, this.address1, this.address2, this.city, this.postcode, this.country, this.state});

  Shipping.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    postcode = json['postcode'];
    country = json['country'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['company'] = this.company;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['postcode'] = this.postcode;
    data['country'] = this.country;
    data['state'] = this.state;
    return data;
  }
}

class MetaData {
  String key;
  Value value;

  MetaData({this.key, this.value});

  MetaData.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    if (this.value != null) {
      data['value'] = this.value.toJson();
    }
    return data;
  }
}

class Value {
  String userName;
  String userEmail;
  String firstName;
  String lastName;
  String storeName;
  String storeSlug;
  String storeEmail;
  String phone;
  String vendorId;
  int gravatar;
  String bannerType;
  String banner;
  String bannerVideo;
  List<BannerSlider> bannerSlider;

  Value(
      {this.userName,
      this.userEmail,
      this.firstName,
      this.lastName,
      this.storeName,
      this.storeSlug,
      this.storeEmail,
      this.phone,
      this.vendorId,
      this.gravatar,
      this.bannerType,
      this.banner,
      this.bannerVideo,
      this.bannerSlider});

  Value.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userEmail = json['user_email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    storeName = json['store_name'];
    storeSlug = json['store_slug'];
    storeEmail = json['store_email'];
    phone = json['phone'];
    vendorId = json['vendor_id'];
    gravatar = json['gravatar'];
    bannerType = json['banner_type'];
    banner = json['banner'];
    bannerVideo = json['banner_video'];
    if (json['banner_slider'] != null) {
      bannerSlider = new List<BannerSlider>();
      json['banner_slider'].forEach((v) {
        bannerSlider.add(new BannerSlider.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['store_name'] = this.storeName;
    data['store_slug'] = this.storeSlug;
    data['store_email'] = this.storeEmail;
    data['phone'] = this.phone;
    data['vendor_id'] = this.vendorId;
    data['gravatar'] = this.gravatar;
    data['banner_type'] = this.bannerType;
    data['banner'] = this.banner;
    data['banner_video'] = this.bannerVideo;
    if (this.bannerSlider != null) {
      data['banner_slider'] = this.bannerSlider.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerSlider {
  String image;
  String link;

  BannerSlider({this.image, this.link});

  BannerSlider.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['link'] = this.link;
    return data;
  }
}
