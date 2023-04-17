class PurchaseRecordsController < ApplicationController
  def index
    @purchase_records = PurchaseRecord.includes(:product, :supplier).all
  end

  def show
  end

  def new
    @purchase_record = PurchaseRecord.new
  end

  def edit
  end

  def create
    @purchase_record = PurchaseRecord.new(purchase_record_params)
    if @purchase_record.save
      redirect_to @purchase_record, notice: '作成しました。'
    else
      render :new
    end
  end

  def update
    if @purchase_record.update(purchase_record_params)
      redirect_to @purchase_record, notice: '更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @purchase_record.destroy
    redirect_to purchase_records_url, notice: '削除しました。'
  end

  def get_suppliers
    #@suppliers = Supplier.where(product_id: params[:product_id])
    @product = Product.find(params[:product_id])
    @suppliers = @product.suppliers
    respond_to do |format|
      get_suppliers.js
    end
  end

  private
    def set_purchase_record
      @purchase_record = PurchaseRecord.includes(:product, :supplier).find(params[:id])
    end

    def purchase_record_params
      params.require(:purchase_record).permit(:purchase_date, :quantity, :product_id, :supplier_id)
    end
end