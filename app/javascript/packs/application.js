import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap"
import "jquery";
Rails.start()
Turbolinks.start()
ActiveStorage.start()
window.jQuery = window.$ = require("jquery")
import I18n from "i18n-js"
window.I18n = I18n;

$( document ).on('turbolinks:load', function() {
  $("#micropost_image").on("change", function() {
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      var alertMsg = I18n.translation["text"]["file_size_alert"];
      alert(alertMsg);
    };
  });
})
