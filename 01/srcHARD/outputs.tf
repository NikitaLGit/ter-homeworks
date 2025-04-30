output "password_root" {
  sensitive = true
  value = random_password.super_user.result
}

output "password" {
  sensitive = true
  value = random_password.user.result
}