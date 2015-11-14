function calc_delay(delay, delay_unit){
  var one_minute = 60;
  var one_hour = 3600;
  var one_day = one_hour * 24;
  switch(delay_unit){
    case 'minutes': return delay * one_minute;
    case 'hours'  : return delay * one_hour;
    case 'days'   : return delay * one_day;
    case 'weeks'  : return delay * one_day * 7;
    case 'months' : return delay * one_day * 30;
    case 'years'  : return delay * one_day * 365;
    default: throw new Error('argument "delay_unit" must be one of ["minutes", "hours", "days", "weeks", "months", "years", but get '+delay_unit);
  }
}


function human_readable_time(time_in_seconds){
  var d1 = new Date(2000, 0, 1, 0, 0, time_in_seconds);
  var d2 = new Date(2000, 0, 1, 0, 0, 0);
  var year = d1.getFullYear() - d2.getFullYear();
  var month = d1.getMonth() - d2.getMonth();
  var day = d1.getDate() - d2.getDate();
  var hour = d1.getHours() - d2.getHours();
  var minute = d1.getMinutes() - d2.getMinutes();
  var str = "";
  if(year > 0){
    str = str + year + '年';
  }
  if(month > 0){
    str = str + month + '月';
  }
  if(day > 0){
    str = str + day + '日';
  }
  if(hour > 0){
    str = str + hour + '时';
  }
  if(minute > 0){
    str = str + minute + '分';
  }
  return str;
}

Summary = {
  tracking_section: function(attrs){
    return $("<div>").addClass('list_content list_tr')
              .html(JST['kucun/trackings/new/summary'](attrs));

  }
}
