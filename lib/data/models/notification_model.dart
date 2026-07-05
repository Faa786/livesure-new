class NotificationModel {
  final String id;
  final String userId;
  final String title;
  final String body;
  final String type;
  final String priority;
  final bool isRead;
  final DateTime? readAt;
  final String? actionUrl;
  final String? imageUrl;
  final Map<String, dynamic>? metadata;
  final DateTime? scheduledFor;
  final DateTime? sentAt;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.type,
    required this.priority,
    required this.isRead,
    this.readAt,
    this.actionUrl,
    this.imageUrl,
    this.metadata,
    this.scheduledFor,
    this.sentAt,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      type: json['type'] ?? 'system',
      priority: json['priority'] ?? 'normal',
      isRead: json['is_read'] ?? false,
      readAt: json['read_at'] != null ? DateTime.parse(json['read_at']) : null,
      actionUrl: json['action_url'],
      imageUrl: json['image_url'],
      metadata: json['metadata'],
      scheduledFor: json['scheduled_for'] != null ? DateTime.parse(json['scheduled_for']) : null,
      sentAt: json['sent_at'] != null ? DateTime.parse(json['sent_at']) : null,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}
