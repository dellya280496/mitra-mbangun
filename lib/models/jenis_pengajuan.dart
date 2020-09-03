class JenisPengajuan {
	String jenispengajuanid;
	String jenispengajuannama;
	String jenispengajuanthumbnail;
	String jenispengajuanaktif;

	JenisPengajuan({this.jenispengajuanid, this.jenispengajuannama, this.jenispengajuanthumbnail, this.jenispengajuanaktif});

	JenisPengajuan.fromJson(Map<String, dynamic> json) {
		jenispengajuanid = json['jenispengajuanid'];
		jenispengajuannama = json['jenispengajuannama'];
		jenispengajuanthumbnail = json['jenispengajuanthumbnail'];
		jenispengajuanaktif = json['jenispengajuanaktif'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['jenispengajuanid'] = this.jenispengajuanid;
		data['jenispengajuannama'] = this.jenispengajuannama;
		data['jenispengajuanthumbnail'] = this.jenispengajuanthumbnail;
		data['jenispengajuanaktif'] = this.jenispengajuanaktif;
		return data;
	}
}
