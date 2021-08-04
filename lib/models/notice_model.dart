class NoticeModel {
  final String title, noticeId;
  final String? attachmentLink, describtion;

  NoticeModel(
      {required this.title,
      this.describtion,
      required this.noticeId,
      this.attachmentLink});
  factory NoticeModel.fromMap(Map<String, dynamic> mapedValue) {
    String? getAttachmentLink(String tempString) =>
        tempString == 'No' ? null : tempString;
    return NoticeModel(
        title: mapedValue['Title'],
        describtion: mapedValue['Describtion'],
        attachmentLink: getAttachmentLink(mapedValue['Attachment Link']),
        noticeId: mapedValue['NoticeId']);
  }

  static Map<String, dynamic> toMap(NoticeModel noticeModel) {
    return {
      'Title': noticeModel.title,
      'Describtion': noticeModel.describtion ?? '',
      'Attachment Link': noticeModel.attachmentLink ?? 'No',
      'NoticeId': noticeModel.noticeId
    };
  }
}
