class PengajuanSeminar {
  final String nama;
  final String nim;
  final String judul;
  final String dosenPembimbing;
  final DateTime tanggalSeminar;
  final String ruangan;
  final bool berkasLengkap;

  const PengajuanSeminar({
    required this.nama,
    required this.nim,
    required this.judul,
    required this.dosenPembimbing,
    required this.tanggalSeminar,
    required this.ruangan,
    required this.berkasLengkap,
  });

  PengajuanSeminar copyWith({
    String? nama,
    String? nim,
    String? judul,
    String? dosenPembimbing,
    DateTime? tanggalSeminar,
    String? ruangan,
    bool? berkasLengkap,
  }) {
    return PengajuanSeminar(
      nama: nama ?? this.nama,
      nim: nim ?? this.nim,
      judul: judul ?? this.judul,
      dosenPembimbing: dosenPembimbing ?? this.dosenPembimbing,
      tanggalSeminar: tanggalSeminar ?? this.tanggalSeminar,
      ruangan: ruangan ?? this.ruangan,
      berkasLengkap: berkasLengkap ?? this.berkasLengkap,
    );
  }
}