/// rajaongkir : {"query":{"city":"39"},"status":{"code":200,"description":"OK"},"results":[{"subdistrict_id":"537","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Bambang Lipuro"},{"subdistrict_id":"538","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Banguntapan"},{"subdistrict_id":"539","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Bantul"},{"subdistrict_id":"540","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Dlingo"},{"subdistrict_id":"541","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Imogiri"},{"subdistrict_id":"542","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Jetis"},{"subdistrict_id":"543","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Kasihan"},{"subdistrict_id":"544","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Kretek"},{"subdistrict_id":"545","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Pajangan"},{"subdistrict_id":"546","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Pandak"},{"subdistrict_id":"547","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Piyungan"},{"subdistrict_id":"548","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Pleret"},{"subdistrict_id":"549","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Pundong"},{"subdistrict_id":"550","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Sanden"},{"subdistrict_id":"551","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Sedayu"},{"subdistrict_id":"552","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Sewon"},{"subdistrict_id":"553","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Srandakan"}]}

class SubDistrict {
  RajaongkirBean rajaongkir;

  static SubDistrict fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SubDistrict subDistrictBean = SubDistrict();
    subDistrictBean.rajaongkir = RajaongkirBean.fromMap(map['rajaongkir']);
    return subDistrictBean;
  }

  Map toJson() => {
        "rajaongkir": rajaongkir,
      };
}

/// query : {"city":"39"}
/// status : {"code":200,"description":"OK"}
/// results : [{"subdistrict_id":"537","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Bambang Lipuro"},{"subdistrict_id":"538","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Banguntapan"},{"subdistrict_id":"539","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Bantul"},{"subdistrict_id":"540","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Dlingo"},{"subdistrict_id":"541","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Imogiri"},{"subdistrict_id":"542","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Jetis"},{"subdistrict_id":"543","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Kasihan"},{"subdistrict_id":"544","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Kretek"},{"subdistrict_id":"545","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Pajangan"},{"subdistrict_id":"546","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Pandak"},{"subdistrict_id":"547","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Piyungan"},{"subdistrict_id":"548","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Pleret"},{"subdistrict_id":"549","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Pundong"},{"subdistrict_id":"550","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Sanden"},{"subdistrict_id":"551","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Sedayu"},{"subdistrict_id":"552","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Sewon"},{"subdistrict_id":"553","province_id":"5","province":"DI Yogyakarta","city_id":"39","city":"Bantul","type":"Kabupaten","subdistrict_name":"Srandakan"}]

class RajaongkirBean {
  QueryBean query;
  StatusBean status;
  List<ResultsBeanSubdistrict> results;

  static RajaongkirBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RajaongkirBean rajaongkirBean = RajaongkirBean();
    rajaongkirBean.query = QueryBean.fromMap(map['query']);
    rajaongkirBean.status = StatusBean.fromMap(map['status']);
    rajaongkirBean.results = List()..addAll((map['results'] as List ?? []).map((o) => ResultsBeanSubdistrict.fromMap(o)));
    return rajaongkirBean;
  }

  Map toJson() => {
        "query": query,
        "status": status,
        "results": results,
      };
}

/// subdistrict_id : "537"
/// province_id : "5"
/// province : "DI Yogyakarta"
/// city_id : "39"
/// city : "Bantul"
/// type : "Kabupaten"
/// subdistrict_name : "Bambang Lipuro"

class ResultsBeanSubdistrict {
  String subdistrictId;
  String provinceId;
  String province;
  String cityId;
  String city;
  String type;
  String subdistrictName;

  static ResultsBeanSubdistrict fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ResultsBeanSubdistrict resultsBean = ResultsBeanSubdistrict();
    resultsBean.subdistrictId = map['subdistrict_id'];
    resultsBean.provinceId = map['province_id'];
    resultsBean.province = map['province'];
    resultsBean.cityId = map['city_id'];
    resultsBean.city = map['city'];
    resultsBean.type = map['type'];
    resultsBean.subdistrictName = map['subdistrict_name'];
    return resultsBean;
  }

  Map toJson() => {
        "subdistrict_id": subdistrictId,
        "province_id": provinceId,
        "province": province,
        "city_id": cityId,
        "city": city,
        "type": type,
        "subdistrict_name": subdistrictName,
      };
}

/// code : 200
/// description : "OK"

class StatusBean {
  int code;
  String description;

  static StatusBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    StatusBean statusBean = StatusBean();
    statusBean.code = map['code'];
    statusBean.description = map['description'];
    return statusBean;
  }

  Map toJson() => {
        "code": code,
        "description": description,
      };
}

/// city : "39"

class QueryBean {
  String city;

  static QueryBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    QueryBean queryBean = QueryBean();
    queryBean.city = map['city'];
    return queryBean;
  }

  Map toJson() => {
        "city": city,
      };
}
