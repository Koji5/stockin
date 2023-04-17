class PurchaseRecordsController < ApplicationController
  before_action :set_purchase_record, only: [:destroy, :update, :edit, :show]

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

  def search
    conditions = ["purchase_records.purchase_date = ? OR products.name = ? OR suppliers.name = ? OR products.stock = ?", params[:purchase_date], params[:product_name], params[:supplier_name], params[:product_stock]]
    @purchase_records = PurchaseRecord.joins(:product, :supplier).select('purchase_records.*, products.name as product_name, suppliers.name as supplier_name').where(conditions)
    render :index
  end

  def get_suppliers
    product = Product.find_by(id: params[:product_id])
    if product.nil?
      render json: []
    else
      @suppliers = product.suppliers.map do |supplier|
        {
          id: supplier.id,
          name: supplier.name
        }
      end
      render json: @suppliers
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