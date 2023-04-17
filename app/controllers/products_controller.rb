class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @suppliers = @product.suppliers
  end

  def new
    @product = Product.new
    @suppliers = Supplier.all # 業者のリストを取得
  end

  def edit
    @product = Product.find(params[:id])
    @suppliers = Supplier.all # 業者のリストを取得
  end

  def create
    @product = Product.new(product_params)
    supplier_ids = params[:product][:supplier_ids].reject(&:empty?)
    @product.suppliers << Supplier.find(supplier_ids)
    if @product.save
      redirect_to @product, notice: '商品を登録しました。'
    else
      render :new
    end
  end

  def update
    @product = Product.find(params[:id])
    supplier_ids = params[:product][:supplier_ids].reject(&:empty?)
    @product.suppliers = Supplier.find(supplier_ids)
    if @product.update(product_params)
      redirect_to @product, notice: '商品を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.suppliers.each do |supplier|
      supplier.products.destroy(@product)
    end
    @product.destroy # 商品を削除
    redirect_to products_url, notice: '商品を削除しました。'
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :stock)
  end
end
