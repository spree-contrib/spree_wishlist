(function() {
  Spree.ready(function($) {
    $('#new_wished_product').on('submit', function() {
      var cart_quantity, selected_variant_id;
      selected_variant_id = $('#product-variants input[type=radio]:checked').val();
      if (selected_variant_id) {
        $('#wished_product_variant_id').val(selected_variant_id);
      }
      cart_quantity = $('.add-to-cart #quantity').val();
      if (cart_quantity) {
        return $('#wished_product_quantity').val(cart_quantity);
      }
    });
    $('form#change_wishlist_accessibility').on('submit', function() {
      $.post($(this).prop('action'), $(this).serialize(), null, 'script');
      return false;
    });
    return $('form#change_wishlist_accessibility input[type=radio]').on('click', function() {
      return $(this).parent().submit();
    });
  });

}).call(this);
