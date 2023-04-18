class SuppliersController < ApplicationController

  def index
    @suppliers = Supplier.all
  end

  def show
    @supplier = Supplier.find(params[:id])
    @products = @supplier.products
    end

  def new
    @supplier = Supplier.new
    @products = Product.all # 商品のリストを取得
  end

  def edit
    @supplier = Supplier.find(params[:id])
    @products = Product.all # 商品のリストを取得
  end

  def create
    @supplier = Supplier.new(supplier_params)
    product_ids = params[:supplier][:product_ids].reject(&:empty?)
    @supplier.products << Product.find(product_ids)
    if @supplier.save
      redirect_to @supplier, notice: '業者を登録しました。'
    else
      render :new
    end
  end

  def update
    @supplier = Supplier.find(params[:id])
    product_ids = params[:supplier][:product_ids].reject(&:empty?)
    @supplier.products = Product.find(product_ids)
    if @supplier.update(supplier_params)
      redirect_to @supplier, notice: '業者を更新しました。'
    else
      render :edit
    end
  end
  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.products.each do |product|
      product.suppliers.destroy(@supplier) # 関連する商品から業者を削除
    end
    @supplier.destroy # 業者を削除
    redirect_to suppliers_url, notice: '業者を削除しました。'
  end

  private
  def supplier_params
    params.require(:supplier).permit(:name, :tel)
  end
end
