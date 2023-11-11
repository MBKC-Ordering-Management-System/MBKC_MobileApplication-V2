enum StatusTypeEnum {
  active('Hoạt động'),
  inactive('Không hoạt động'),
  deactive('Xóa vĩnh viễn');

  final String type;
  const StatusTypeEnum(this.type);
}

extension ConvertToStatus on String {
  StatusTypeEnum toStatusTypeEnum() {
    switch (this) {
      case 'Active':
        return StatusTypeEnum.active;
      case 'Inactive':
        return StatusTypeEnum.inactive;
      case 'Deactive':
        return StatusTypeEnum.deactive;
      default:
        return StatusTypeEnum.active;
    }
  }
}
