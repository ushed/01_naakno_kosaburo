//model/wether_response
/*
{"publishingOffice":"福岡管区気象台",
"reportDatetime":"2025-02-18T10:33:00+09:00",
"targetArea":"福岡県","headlineText":"",
"text":"　福岡県は、・・・・でしょう。"}
辞書型*/

class WeatherResponse {
  // パラメータ定義
  final String publishingOffice;
  final DateTime reportDatetime;
  final String targetArea;
  final String headlineText;
  final String text;

  // コンストラクタ（正しいクラス名に修正）
  WeatherResponse({
    required this.publishingOffice,
    required this.reportDatetime,
    required this.targetArea,
    required this.headlineText,
    required this.text,
  });

  // JSONデータを WeatherResponse クラスに変換
  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      publishingOffice: json['publishingOffice'] as String,
      reportDatetime:
          DateTime.parse(json['reportDatetime'] as String), // 文字列を DateTime に変換
      targetArea: json['targetArea'] as String,
      headlineText: json['headlineText'] as String? ?? '', // `null` の場合は空文字
      text: json['text'] as String,
    );
  }
}
