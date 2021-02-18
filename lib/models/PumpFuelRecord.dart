import 'dart:convert';

class PumpFuelRecord {

  int pump_id;
  String start_hour;
  String finish_hour;
  String start_m3;
  String finish_m3;
  String pressure_gauge;
  String start_amp;
  String end_amp;

  PumpFuelRecord({
    this.pump_id,
    this.start_hour,
    this.finish_hour,
    this.start_m3,
    this.finish_m3,
    this.end_amp,
    this.pressure_gauge,
    this.start_amp
  });
  factory PumpFuelRecord.fromJson(Map<String, dynamic> json) {
    return PumpFuelRecord(
      pump_id: json['pump_id'],
      start_hour: json['start_hour'],
      finish_hour: json['finish_hour'],
      start_m3: json['start_m3'],
      finish_m3: json['finish_m3'],
      pressure_gauge: json['pressure_gauge'],
      start_amp: json['start_amp'],
      end_amp: json['end_amp'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
        "pump_id": pump_id,
        "start_hour": start_hour,
        "finish_hour": finish_hour,
        "start_m3":start_m3,
        "finish_m3":finish_m3,
        "pressure_gauge":pressure_gauge,
        "start_amp":start_amp,
        "end_amp":end_amp
    };
  }

  @override
  String toString() {
    return 'Post{'
        'pump_id:$pump_id,'
        'start_hour:$start_hour,'
        'finish_hour:$finish_hour ,'
        'start_m3:$start_m3,'
        'finish_m3:$finish_m3,'
        'pressure_gauge:$finish_m3,'
        'start_amp:$start_amp,'
        'end_amp:$end_amp,'
        '}';
  }
}

List<PumpFuelRecord> dataFromJson(String strJson) {
  final str = json.decode(strJson);
  return List<PumpFuelRecord>.from(str.map((item) {
    return PumpFuelRecord.fromJson(item);
  }));
}

String dataToJson(PumpFuelRecord data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
