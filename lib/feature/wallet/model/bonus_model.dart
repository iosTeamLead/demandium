class BonusModel {
  String? id;
  String? bonusTitle;
  String? shortDescription;
  String? bonusAmountType;
  String? bonusAmount;
  String? minimumAddAmount;
  String? maximumBonusAmount;
  String? startDate;
  String? endDate;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  BonusModel(
      {this.id,
        this.bonusTitle,
        this.shortDescription,
        this.bonusAmountType,
        this.bonusAmount,
        this.minimumAddAmount,
        this.maximumBonusAmount,
        this.startDate,
        this.endDate,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  BonusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bonusTitle = json['bonus_title'];
    shortDescription = json['short_description'];
    bonusAmountType = json['bonus_amount_type'];
    bonusAmount = json['bonus_amount'];
    minimumAddAmount = json['minimum_add_amount'];
    maximumBonusAmount = json['maximum_bonus_amount'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bonus_title'] = bonusTitle;
    data['short_description'] = shortDescription;
    data['bonus_amount_type'] = bonusAmountType;
    data['bonus_amount'] = bonusAmount;
    data['minimum_add_amount'] = minimumAddAmount;
    data['maximum_bonus_amount'] = maximumBonusAmount;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
