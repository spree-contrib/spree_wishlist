(($) ->
  $('#new_wished_product').on 'submit', ->
    selected_variant_id = $('#product-variants input[type=radio]:checked').val()
    $('#wished_product_variant_id').val selected_variant_id if selected_variant_id

  $('form#change_wishlist_accessibility').on 'submit', ->
    $.post $(this).prop('action'), $(this).serialize(), null, 'script'
    false

  $('form#change_wishlist_accessibility input[type=radio]').on 'click', ->
    $(this).parent().submit()

) jQuery
