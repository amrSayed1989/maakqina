String replaceFarsiNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(arabic[i], english[i]);
  }
  return input;
}

  String getFormedDateFrom({required DateTime dateTime}){
    var dd = dateTime.day;
    var mm = dateTime.month;
    var yy = dateTime.year;

    var day = '$dd';
    if(dd < 10){
      day = '0$day';
    }
    var mon = '$mm';
    if(mm < 10){
      mon = '0$mon';
    }
    return '$yy-$mon-$day';
  }