function updateSuppliers() {
  $.ajax({
    type: "GET",
    url: "/purchase_records/get_suppliers",
    data: { product_id: $('#purchase_record_product_id').val() },
    dataType: "json",
    success: function(response) {
      var select = $('#purchase_record_supplier_id');
      select.empty(); // select要素内のoption要素を全て削除
      $.each(response, function(index, supplier) {
        select.append($('<option></option>').val(supplier.id).html(supplier.name));
      });
    },
    error: function(xhr, status, error) {
      console.log("Ajaxエラー発生");
      console.log("xhr: " + xhr);
      console.log("status: " + status);
      console.log("error: " + error);
    }
  });
}

$('#purchase_record_product_id').on('change', updateSuppliers);

// 最初に実行する
updateSuppliers();