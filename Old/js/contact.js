
$(function() {
   $("#contact-form").submit(function() {
  
     $.ajax({
          method: this.method,
          url: this.action,
          data: $(this).serialize(),
          dataType: "json",
          success: function(json) {
              alert(json.message);
          },
          error: function(xhr, status, error) {
              alert("Failed: " + status + " " + error);
          }
      });
      return false;
   });
});
