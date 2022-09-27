class Link {
  final String id;
  final String source;
  final String destination;
  final String clicks;

  Link({
    required this.id,
    required this.source,
    required this.destination,
    required this.clicks,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      id: json['id'],
      source: json['source'],
      destination: json['destination'],
      clicks: json['clicks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'source': source,
      'destination': destination,
      'clicks': clicks,
    };
  }
}
