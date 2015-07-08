$(function () {
  $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
    $("select#income_income_source_id").val("");
  });      
});
function edit(id) {
  $('#' + id + '_driver_disabled').prop('disabled', false);
  $('#' + id + '_value_disabled').prop('disabled', false);
  $('#' + id + '_midday_value_disabled').prop('disabled', false);
  $('#' + id + '_link_disabled').hide();
}
