# Scaffolding generated by Casein v5.1.1.5

module Casein
  class ShopsController < Casein::CaseinController

    ## optional filters for defining usage according to Casein::AdminUser access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]

    def index
      @casein_page_title = 'Shops'
  		@shops = Shop.order(sort_order(:name)).paginate :page => params[:page]
    end

    def show
      @casein_page_title = 'View shop'
      @shop = Shop.find params[:id]
    end

    def new
      @casein_page_title = 'Add a new shop'
    	@shop = Shop.new
    end

    def create
      @shop = Shop.new shop_params

      if @shop.save
        flash[:notice] = 'Shop created'
        redirect_to casein_shops_path
      else
        flash.now[:warning] = 'There were problems when trying to create a new shop'
        render :action => :new
      end
    end

    def update
      @casein_page_title = 'Update shop'

      @shop = Shop.find params[:id]

      if @shop.update_attributes shop_params
        flash[:notice] = 'Shop has been updated'
        redirect_to casein_shops_path
      else
        flash.now[:warning] = 'There were problems when trying to update this shop'
        render :action => :show
      end
    end

    def destroy
      @shop = Shop.find params[:id]

      @shop.destroy
      flash[:notice] = 'Shop has been deleted'
      redirect_to casein_shops_path
    end

    private

      def shop_params
        params.require(:shop).permit(:name, :address, :phone, :website, :image)
      end

  end
end
