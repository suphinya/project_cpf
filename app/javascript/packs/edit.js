$(document).ready(function() {
  $('#date_in_date_in').on('change', function() {
     document.getElementById('submit-btn').click()
  });
});

document.getElementById("date_out_date_out").value = document.getElementById("date_in_date_in").value;


//var date = document.getElementById("date_in_date_in").value;
//var varDate = new Date(date); //dd-mm-YYYY
//var today = new Date();

//if(varDate >= today) {
  //getElementById("mobile-cta").value;
//}

//$(function () {
        //$("#chkPassport").click(function () {
            //if ($(this).is(":checked")) {
                //$("#multiple").show();
            //} else {
                //$("#multiple").hide();
            //}
        //});
//});
