class Admin::ProductController < AdminController

  # def new
  #   @product = Product.new
  # end
  #
  # def edit
  # end
  #
  # def update
  #   @product = Product.find params[:id]
  #   respond_to do |u|
  #     if @product.update(prd_params)
  #       u.html {redirect_to @product, notice: 'Product was updated'}
  #       u.json {render :show, status: :ok, location: @product}
  #     else
  #       u.html {render :edit}
  #       u.json {render json: @product.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # def create 
  #   @product = Product.new(prd_params)
  #   respond_to do |c|
  #     if @product.save
  #       c.html {redirect_to @product, notice: 'Product has successfully created.'}
  #       c.json {render :show, status: created, location: @product}
  #     else
  #       c.html {render :new}
  #       c.json {render json: @product.errors, status: :unproccessable_entity}
  #     end
  #   end
  # end
  #
  # private
  #
  # def prd_params
  #   params.require(:product).permit(:title, :desc, :img_url, :price)
  # end

end