class WhatsAppTemplate {
  const WhatsAppTemplate({
    required this.name,
    required this.language,
    required this.bodyPlaceholders,
    this.buttonPlaceholders = const [],
  });

  final String name;
  final String language;
  final List<String> bodyPlaceholders;
  final List<String> buttonPlaceholders;

  Map<String, dynamic> buildPayload({
    required String recipient,
    Map<String, String>? values,
  }) {
    final components = <Map<String, dynamic>>[];
    if (bodyPlaceholders.isNotEmpty) {
      components.add({
        'type': 'body',
        'parameters': bodyPlaceholders
            .map(
              (placeholder) => {
                'type': 'text',
                'text': values?[placeholder] ?? '',
              },
            )
            .toList(),
      });
    }

    if (buttonPlaceholders.isNotEmpty) {
      components.add({
        'type': 'button',
        'sub_type': 'quick_reply',
        'parameters': buttonPlaceholders
            .map(
              (placeholder) => {
                'type': 'payload',
                'payload': values?[placeholder] ?? '',
              },
            )
            .toList(),
      });
    }

    return {
      'messaging_product': 'whatsapp',
      'to': recipient,
      'type': 'template',
      'template': {
        'name': name,
        'language': {'code': language},
        if (components.isNotEmpty) 'components': components,
      },
    };
  }
}

final Map<String, WhatsAppTemplate> whatsappTemplates = {
  'paymentReminder': const WhatsAppTemplate(
    name: 'payment_reminder',
    language: 'en',
    bodyPlaceholders: ['memberName', 'dueDate', 'planName', 'amount'],
  ),
  'renewalReminder': const WhatsAppTemplate(
    name: 'renewal_reminder',
    language: 'en',
    bodyPlaceholders: ['memberName', 'expiryDate', 'planName'],
  ),
  'welcomeMessage': const WhatsAppTemplate(
    name: 'welcome_message',
    language: 'en',
    bodyPlaceholders: ['memberName', 'planName'],
  ),
  'attendanceSuccess': const WhatsAppTemplate(
    name: 'attendance_success',
    language: 'en',
    bodyPlaceholders: ['memberName', 'checkInTime'],
  ),
};
