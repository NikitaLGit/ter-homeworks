data "yandex_compute_image" "yandextoolbox" {
  image_id = "fd8stsue5rim479kphah"
  family = "toolbox"
}

# data "template_file" "instance_userdata" {
#   template = file("linux.tpl")
#   vars = {
#     env        = "perf"
#     username   = "nikita"
#     ssh_public = file("public.key")
#   }
# }