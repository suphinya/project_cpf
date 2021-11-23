$(document).ready(function() {
  $('#date_in_date_in').on('change', function() {
     document.getElementById('submit-btn').click()
     var date = document.getElementById("date_in_date_in").value;
     var varDate = new Date(date); //dd-mm-YYYY
     var today = new Date();

     if(varDate >= today) {
       document.getElementById("date_out_date_out").value = document.getElementById("date_in_date_in").value;
       document.getElementById("date_out_date_out").show()
     }
     else{
       document.getElementById("date_out_date_out").hide()
     }
  });
});

var date = document.getElementById("date_in_date_in").value;
var varDate = new Date(date); //dd-mm-YYYY
var today = new Date();

if(varDate > today.getDate()) {
  document.getElementById("date_out_date_out").value = document.getElementById("date_in_date_in").value;
  document.getElementById("to-div").style.display = "grid";
}
else{
  document.getElementById("to-div").style.display = "none";
}




//$(function () {
        //$("#chkPassport").click(function () {
            //if ($(this).is(":checked")) {
                //$("#multiple").show();
            //} else {
                //$("#multiple").hide();
            //}
        //});
//});
