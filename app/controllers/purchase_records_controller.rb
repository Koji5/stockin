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
    @product = Product.find(@purchase_record.product_id)
    @product.stock +=  @purchase_record.quantity.to_i
    if @purchase_record.save && @product.save
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
    product_name_match_type = params[:product_name_match_type] == 'partial' ? '%' : ''
    supplier_name_match_type = params[:supplier_name_match_type] == 'partial' ? '%' : ''
    
    conditions = []
    values = []
    if params[:purchase_date].present?
      conditions << "purchase_records.purchase_date = ?"
      values << params[:purchase_date]
    end
    
    if params[:product_name].present?
      conditions << "products.name LIKE ?"
      values << "#{product_name_match_type}#{params[:product_name]}"
    end
    
    if params[:supplier_name].present?
      conditions << "suppliers.name LIKE ?"
      values << "#{supplier_name_match_type}#{params[:supplier_name]}"
    end
    
    if params[:product_stock].present?
      conditions << "products.stock > ?"
      values << params[:product_stock]
    end
    
      @purchase_records = PurchaseRecord
      .joins("LEFT OUTER JOIN products ON purchase_records.product_id = products.id")
      .joins("LEFT OUTER JOIN suppliers ON purchase_records.supplier_id = suppliers.id")
      .select('purchase_records.*, products.name as product_name, suppliers.name as supplier_name')
      .where(conditions.join(" AND "), *values)
    
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
##sourcetreeテスト用