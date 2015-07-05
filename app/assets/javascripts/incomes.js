$(function () {
  $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
    $("select#income_brand_shop_id").val("");
    $("select#income_truck_route_id").val("");
    $("select#income_driver_id").val("");
    $("select#income_external_shop_id").val("");
  });      
});
function edit(id) {
  $('#' + id + '_driver_disabled').prop('disabled', false);
  $('#' + id + '_value_disabled').prop('disabled', false);
  $('#' + id + '_link_disabled').hide();
}
