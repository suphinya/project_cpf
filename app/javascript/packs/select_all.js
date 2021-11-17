var Selectall = {
	setup: function(){
		$('#check_all').on("click",
			function(){
				//alert("aa");
				if(this.checked) {
		        // Iterate each checkbox
		        $(':checkbox').each(function() {
		            this.checked = true;                        
		        });
			    } else {
			        $(':checkbox').each(function() {
			            this.checked = false;                       
			        });
			    }
			})

		$(':checkbox').change(function(){
			if ($(this).prop("checked")==false) {
				$("#check_all").prop("checked", false)
			}
			if ($(":checkbox:checked").length == $(":checkbox").length) {
				$("#check_all").prop("checked", true)
			}
		})
	}
}

$(Selectall.setup);
