<script language="javascript">
	$(function() {
		$('.delete').click(function(){
			if ( confirm("Are you sure want to delete this text?") ) {
				return true;
			} else {
				return false;
			}
		});
		
		$('.cancel').click(function(){
			window.location.reload();	
		});
	});
</script>