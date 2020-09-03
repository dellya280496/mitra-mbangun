/// rajaongkir : {"query":{"origin":"501","originType":"city","destination":"574","destinationType":"subdistrict","weight":1700,"courier":"wahana"},"status":{"code":200,"description":"OK"},"origin_details":{"city_id":"501","province_id":"5","province":"DI Yogyakarta","type":"Kota","city_name":"Yogyakarta","postal_code":"55111"},"destination_details":{"subdistrict_id":"574","province_id":"10","province":"Jawa Tengah","city_id":"41","city":"Banyumas","type":"Kabupaten","subdistrict_name":"Banyumas"},"results":[{"code":"wahana","name":"Wahana Prestasi Logistik","costs":[{"service":"Normal","description":"Normal Service","cost":[{"value":20000,"etd":"","note":""}]}]}]}

class CostRajaOngkir {
  RajaongkirBean rajaongkir;

  static CostRajaOngkir fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CostRajaOngkir costRajaOngkirBean = CostRajaOngkir();
    costRajaOngkirBean.rajaongkir = RajaongkirBean.fromMap(map['rajaongkir']);
    return costRajaOngkirBean;
  }

  Map toJson() => {
        "rajaongkir": rajaongkir,
      };
}

/// query : {"origin":"501","originType":"city","destination":"574","destinationType":"subdistrict","weight":1700,"courier":"wahana"}
/// status : {"code":200,"description":"OK"}
/// origin_details : {"city_id":"501","province_id":"5","province":"DI Yogyakarta","type":"Kota","city_name":"Yogyakarta","postal_code":"55111"}
/// destination_details : {"subdistrict_id":"574","province_id":"10","province":"Jawa Tengah","city_id":"41","city":"Banyumas","type":"Kabupaten","subdistrict_name":"Banyumas"}
/// results : [{"code":"wahana","name":"Wahana Prestasi Logistik","costs":[{"service":"Normal","description":"Normal Service","cost":[{"value":20000,"etd":"","note":""}]}]}]

class RajaongkirBean {
  QueryBean query;
  StatusBean status;
  Origin_detailsBean originDetails;
  Destination_detailsBean destinationDetails;
  List<ResultsBean> results;

  static RajaongkirBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RajaongkirBean rajaongkirBean = RajaongkirBean();
    rajaongkirBean.query = QueryBean.fromMap(map['query']);
    rajaongkirBean.status = StatusBean.fromMap(map['status']);
    rajaongkirBean.originDetails = Origin_detailsBean.fromMap(map['origin_details']);
    rajaongkirBean.destinationDetails = Destination_detailsBean.fromMap(map['destination_details']);
    rajaongkirBean.results = List()..addAll((map['results'] as List ?? []).map((o) => ResultsBean.fromMap(o)));
    return rajaongkirBean;
  }

  Map toJson() => {
        "query": query,
        "status": status,
        "origin_details": originDetails,
        "destination_details": destinationDetails,
        "results": results,
      };
}

/// code : "wahana"
/// name : "Wahana Prestasi Logistik"
/// costs : [{"service":"Normal","description":"Normal Service","cost":[{"value":20000,"etd":"","note":""}]}]

class ResultsBean {
  String code;
  String name;
  List<CostsBean> costs;

  static ResultsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ResultsBean resultsBean = ResultsBean();
    resultsBean.code = map['code'];
    resultsBean.name = map['name'];
    resultsBean.costs = List()..addAll((map['costs'] as List ?? []).map((o) => CostsBean.fromMap(o)));
    return resultsBean;
  }

  Map toJson() => {
        "code": code,
        "name": name,
        "costs": costs,
      };
}

/// service : "Normal"
/// description : "Normal Service"
/// cost : [{"value":20000,"etd":"","note":""}]

class CostsBean {
  String service;
  String description;
  List<CostBean> cost;

  static CostsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CostsBean costsBean = CostsBean();
    costsBean.service = map['service'];
    costsBean.description = map['description'];
    costsBean.cost = List()..addAll((map['cost'] as List ?? []).map((o) => CostBean.fromMap(o)));
    return costsBean;
  }

  Map toJson() => {
        "service": service,
        "description": description,
        "cost": cost,
      };
}

/// value : 20000
/// etd : ""
/// note : ""

class CostBean {
  int value;
  String etd;
  String note;

  static CostBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CostBean costBean = CostBean();
    costBean.value = map['value'];
    costBean.etd = map['etd'];
    costBean.note = map['note'];
    return costBean;
  }

  Map toJson() => {
        "value": value,
        "etd": etd,
        "note": note,
      };
}

/// subdistrict_id : "574"
/// province_id : "10"
/// province : "Jawa Tengah"
/// city_id : "41"
/// city : "Banyumas"
/// type : "Kabupaten"
/// subdistrict_name : "Banyumas"

class Destination_detailsBean {
  String subdistrictId;
  String provinceId;
  String province;
  String cityId;
  String city;
  String type;
  String subdistrictName;

  static Destination_detailsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Destination_detailsBean destination_detailsBean = Destination_detailsBean();
    destination_detailsBean.subdistrictId = map['subdistrict_id'];
    destination_detailsBean.provinceId = map['province_id'];
    destination_detailsBean.province = map['province'];
    destination_detailsBean.cityId = map['city_id'];
    destination_detailsBean.city = map['city'];
    destination_detailsBean.type = map['type'];
    destination_detailsBean.subdistrictName = map['subdistrict_name'];
    return destination_detailsBean;
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

/// city_id : "501"
/// province_id : "5"
/// province : "DI Yogyakarta"
/// type : "Kota"
/// city_name : "Yogyakarta"
/// postal_code : "55111"

class Origin_detailsBean {
  String cityId;
  String provinceId;
  String province;
  String type;
  String cityName;
  String postalCode;

  static Origin_detailsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Origin_detailsBean origin_detailsBean = Origin_detailsBean();
    origin_detailsBean.cityId = map['city_id'];
    origin_detailsBean.provinceId = map['province_id'];
    origin_detailsBean.province = map['province'];
    origin_detailsBean.type = map['type'];
    origin_detailsBean.cityName = map['city_name'];
    origin_detailsBean.postalCode = map['postal_code'];
    return origin_detailsBean;
  }

  Map toJson() => {
        "city_id": cityId,
        "province_id": provinceId,
        "province": province,
        "type": type,
        "city_name": cityName,
        "postal_code": postalCode,
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

/// origin : "501"
/// originType : "city"
/// destination : "574"
/// destinationType : "subdistrict"
/// weight : 1700
/// courier : "wahana"

class QueryBean {
  String origin;
  String originType;
  String destination;
  String destinationType;
  int weight;
  String courier;

  static QueryBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    QueryBean queryBean = QueryBean();
    queryBean.origin = map['origin'];
    queryBean.originType = map['originType'];
    queryBean.destination = map['destination'];
    queryBean.destinationType = map['destinationType'];
    queryBean.weight = map['weight'];
    queryBean.courier = map['courier'];
    return queryBean;
  }

  Map toJson() => {
        "origin": origin,
        "originType": originType,
        "destination": destination,
        "destinationType": destinationType,
        "weight": weight,
        "courier": courier,
      };
}
