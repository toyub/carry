var Associating={
	init : function(){
		$(window.document).on("click",".checktoggle",Associating.CarPartsAssociation);
	},

	CarPartsAssociation : function(){
		console
		if(this.dataset.checked){
			this.checked=false;
			this.dataset.checked = '';
			$("[data-id='"+this.dataset.targetnode+"']").parents("li").hide();
		}else{
		this.checked = true;
    this.dataset.checked = 'checked';
		$("[data-id='"+this.dataset.targetnode+"']").parents("li").show();
		}
	},
}

Associating.init();
