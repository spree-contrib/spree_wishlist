class Spree::WishedVariantsController < Spree::StoreController
  respond_to :html

  def create
    @wished_variant = Spree::WishedVariant.new(wished_variant_attributes)
    @wishlist = spree_current_user.wishlist

    if @wishlist.include? params[:wished_variant][:variant_id]
      @wished_variant = @wishlist.wished_variants.detect { |wp| wp.variant_id == params[:wished_variant][:variant_id].to_i }
    else
      @wished_variant.wishlist = spree_current_user.wishlist
      @wished_variant.save
    end

    respond_with(@wished_variant) do |format|
      format.html { redirect_to wishlist_url(@wishlist) }
    end
  end

  def update
    @wished_variant = Spree::WishedVariant.find(params[:id])
    @wished_variant.update_attributes(wished_variant_attributes)

    respond_with(@wished_variant) do |format|
      format.html { redirect_to wishlist_url(@wished_variant.wishlist) }
    end
  end

  def destroy
    @wished_variant = Spree::WishedVariant.find(params[:id])
    @wished_variant.destroy

    respond_with(@wished_variant) do |format|
      format.html { redirect_to wishlist_url(@wished_variant.wishlist) }
    end
  end

  private

  def wished_variant_attributes
    params.require(:wished_variant).permit(:variant_id, :wishlist_id, :remark, :quantity)
  end
end
