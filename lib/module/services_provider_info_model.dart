import 'package:flutter/material.dart';

Map<String, dynamic> servicesProviderInfo = {
  'itemsServices': [
    {
      'type': 'نجارة',
      'icon': Icons.carpenter_outlined,
    },
    {
      'type': 'حدادة',
      'icon': Icons.hardware_outlined,
    },
    {
      'type': 'صباغ',
      'icon': Icons.format_paint_outlined,
    },
    {
      'type': 'تصليح هواتف',
      'icon': Icons.phonelink_setup_outlined,
    },
    {
      'type': 'تصليح شاشات',
      'icon': Icons.tv_outlined,
    },
    {
      'type': 'تنظيف منازل',
      'icon': Icons.cleaning_services_outlined,
    },
    {
      'type': 'تنصيب برامج الحاسوب',
      'icon': Icons.install_desktop_outlined,
    },
    {
      'type': 'عامل بناء',
      'icon': Icons.construction_rounded,
    },

    // 'نجار قالب': Icons.agriculture_outlined,
    // 'صب مسلح': Icons.ac_unit_rounded,
    // 'خياطة': Icons.app_blocking_outlined,
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
  final List<ItemsServices>? itemsServices;
  // final List<String>? itemsServices;
  final List<String>? itemsYearsOfExperience;
  final List<String>? itemsStartOfWorkingDays;
  final List<String>? itemsAddress;

  ServicesProviderInfoModel({
    this.itemsServices,
    this.itemsYearsOfExperience,
    this.itemsStartOfWorkingDays,
    this.itemsAddress,
  });

  factory ServicesProviderInfoModel.fromJson(Map<String, dynamic> json) {
    List<ItemsServices>? itemsServicesList = [];
    if (json['itemsServices'] != null) {
      itemsServicesList = List<ItemsServices>.from(json['itemsServices'].map(
        (service) => ItemsServices.fromJson(service),
      ));
    }

    return ServicesProviderInfoModel(
      itemsServices: itemsServicesList,
      itemsAddress: json['itemsAddress'],
      itemsYearsOfExperience: json['itemsYearsOfExperience'],
      itemsStartOfWorkingDays: json['itemsStartOfWorkingDays'],
    );
  }

  ServicesProviderInfoModel fillServicesProviderInfo() {
    return ServicesProviderInfoModel.fromJson(servicesProviderInfo);
  }
}

class ItemsServices {
  final String type;
  final IconData icon;

  ItemsServices({
    required this.type,
    required this.icon,
  });

  factory ItemsServices.fromJson(Map<String, dynamic> json) {
    return ItemsServices(
      type: json['type'],
      icon: json['icon'],
    );
  }
}
