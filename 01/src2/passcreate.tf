resource "random_password" "super_user" {
  length      = 8
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "user" {
  length      = 8
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}