Spree.ready(function($) {
  $('#new_wished_product').on('submit', function() {
    var selected_variant_id = $('#product-variants input[type=radio]:checked').val()
    if (selected_variant_id) {
      $('#wished_product_variant_id').val(selected_variant_id)
    }
    var cart_quantity = $('.add-to-cart #quantity').val()
    if (cart_quantity) {
      return $('#wished_product_quantity').val(cart_quantity)
    }
  })
  $('form#change_wishlist_accessibility').on('submit', function() {
    $.post($(this).prop('action'), $(this).serialize(), null, 'script')
    return false
  })
  $('form#change_wishlist_accessibility input[type=radio]').on('click', function() {
      $(this).parent().submit()
    }
  )
})
