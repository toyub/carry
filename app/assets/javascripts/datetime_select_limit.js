function getMonthNumber(month) {
  switch (month) {
    case 'Jan': return 1;
    case 'Feb': return 2;
    case 'Mar': return 3;
    case 'Apr': return 4;
    case 'May': return 5;
    case 'Jun': return 6;
    case 'Jul': return 7;
    case 'Aug': return 8;
    case 'Sep': return 9;
    case 'Oct': return 10;
    case 'Nov': return 11;
    case 'Dec': return 12;
  }
}

$(function(){
  var date = new Date();
  var maxDate = date.getFullYear() + '-' + (date.getMonth()+1) + '-' + date.getDate();
  var maxTime = date.getHours() + ':' + date.getMinutes();
  $('.datetimepicker').datetimepicker({
    thiz: $(this),
    lang: 'ch',
    maxDate: '0',
    maxTime: maxTime,
    onSelectTime: function(date, thiz){
      var flag = 0;
      flag = date <= date.getFullYear() ? 1 : 0;
      if(flag){
        flag = date <= (date.getMonth() + 1) ? 1 : 0;
        if(flag){
          flag = date <= date.getDate() ? 1 : 0;
        }
      }
      if(!flag){
        thiz.val(maxDate + ' ' + maxTime);
      }
    }
  });

  $('.datepicker').datetimepicker({
    thiz: $(this),
    lang: 'ch',
    maxDate: '0',
    maxTime: maxTime,
    validateOnBlur: false,
    onSelectDate: function(date, thiz){
      var year = date.toString().split(" ")[3];
      var month = date.toString().split(" ")[1];
      var day = date.toString().split(" ")[2];
      thiz.val(year+'-'+getMonthNumber(month)+'-'+day);
    },

    onSelectTime: function(date, thiz){
      var year = date.toString().split(" ")[3];
      var month = date.toString().split(" ")[1];
      var day = date.toString().split(" ")[2];
      var flag = 0;
      flag = year <= date.getFullYear() ? 1 : 0;
      if(flag){
        flag = month <= (date.getMonth() + 1) ? 1 : 0;
        if(flag){
          flag = day <= date.getDate() ? 1 : 0;
        }
      }
      if(!flag){
        thiz.val(maxDate);
      }else{
        thiz.val(year + '-' + getMonthNumber(month) + '-' + day);
      }
    }
  });
});
