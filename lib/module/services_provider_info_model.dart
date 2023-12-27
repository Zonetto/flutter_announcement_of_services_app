Map<String, dynamic> servicesProviderInfo = {
  'itemsServices': [
    'نجارة',
    'حدادة',
    'صباغ',
    'تصليح هواتف',
    'تصليح شاشات',
    'نجار قالب',
    'صب مسلح',
    'خياطة',
    'عامل بناء',
  ],
  'itemsYearsOfExperience': [
    'سنة واحدة',
    'سنتين',
    'ثلاث سنوات',
    'اربعة سنوات',
    'خمسة سنوات',
    'ستة سنوات',
    '7 سنوات',
    '8 سنوات',
    'اكثر من 9 سنوات',
  ],
  'itemsStartOfWorkingDays': [
    'الإحد',
    'الأثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
  ],
  'itemsAddress': [
    'القادسية',
    'حي الامير',
    'حي الحرفيين',
    'حي النفط',
    'شارع المطار',
    'حي العسكري',
    'المهندسين',
  ],
};

class ServicesProviderInfoModel {
  final List<String>? itemsServices;
  final List<String>? itemsYearsOfExperience;
  final List<String>? itemsStartOfWorkingDays;
  final List<String>? itemsAddress;

  ServicesProviderInfoModel({
     this.itemsServices,
     this.itemsYearsOfExperience,
     this.itemsStartOfWorkingDays,
     this.itemsAddress,
  });

  factory ServicesProviderInfoModel.formJson(Map<String, dynamic> json) {
    return ServicesProviderInfoModel(
      itemsAddress: json['itemsAddress'],
      itemsYearsOfExperience: json['itemsYearsOfExperience'],
      itemsServices: json['itemsServices'],
      itemsStartOfWorkingDays: json['itemsStartOfWorkingDays'],
    );
  }

  ServicesProviderInfoModel fillServicesProviderInfo() {
    return ServicesProviderInfoModel.formJson(servicesProviderInfo);
  }
}
