$("#new_wished_product").submit(function() {
  selected_variant_id = $("#product-variants input[type=radio]:checked").val();
  if (selected_variant_id)
  {
    $("#wished_product_variant_id").val(selected_variant_id);
  }
});
