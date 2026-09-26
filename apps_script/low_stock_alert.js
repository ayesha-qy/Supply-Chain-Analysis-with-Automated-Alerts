// Apps Script: Daily Low Stock Email Alert
// Install in Google Sheets → Extensions → Apps Script

function sendLowStockAlert() {
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  var data = sheet.getDataRange().getValues();
  var email = Session.getActiveUser().getEmail();
  
  var alertMessage = "⚠️ LOW STOCK ALERT ⚠️\n\n";
  var hasLowStock = false;
  
  for (var i = 1; i < data.length; i++) {
    var productName = data[i][0];
    var stockQty = data[i][1];
    var reorderPoint = data[i][2];
    var status = data[i][3];
    
    if (stockQty <= reorderPoint) {
      alertMessage += "📦 " + productName + "\n";
      alertMessage += "   Current Stock: " + stockQty + "\n";
      alertMessage += "   Reorder Point: " + reorderPoint + "\n";
      alertMessage += "   Status: " + status + "\n\n";
      hasLowStock = true;
    }
  }
  
  if (hasLowStock) {
    MailApp.sendEmail({
      to: email,
      subject: "🚨 Low Stock Alert - " + new Date().toLocaleDateString(),
      body: alertMessage
    });
    Logger.log("Alert email sent!");
  } else {
    Logger.log("No low stock items. No email sent.");
  }
}
