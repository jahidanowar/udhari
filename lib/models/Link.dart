class Link {
  final String source;
  final String destination;
  final int clicks;

  Link({
    required this.source,
    required this.destination,
    required this.clicks,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      source: json['source'],
      destination: json['destination'],
      clicks: json['total_clicks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'source': source,
      'destination': destination,
      'total_clicks': 0,
    };
  }
}
