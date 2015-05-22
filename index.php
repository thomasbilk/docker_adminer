<?php
function adminer_object() {
  class AdminerSoftware extends Adminer {
    function permanentLogin() {
      return "super secret";
    }
  }
  return new AdminerSoftware;
}
include "adminer.php";
?>
