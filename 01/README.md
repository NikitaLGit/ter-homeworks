## Подготовка

Скачал `terraform` версии `1.9.8`. `Docker` есть. Сделал fork репозитория

## Задача 1

1. Выполним `terraform init` в папке `/src`
2. Хранить переменные можно в файле `*.tfvars` или автоматическом `*.auto.tfvars`
3. Выполним код прописав
```bash
terraform apply
```

В появившемся файле `terraform.tfstate` результат всех операций. Найдем в
```yaml
"resources":
    ...
    "instances":
         ...
         "result": "TAB7M4MQCAlqmm2z"
```

![image](https://github.com/user-attachments/assets/1e3464f1-21f5-408e-8666-724ce136da50)

4. в ресурсе с типом `"docker_image"` должен быть `label`. добавим его = `"nginx"`

```yaml
resource "docker_image" "nginx" {...}
```

В ресурсе `"docker_container"` был неправильынй `label`. изменим с `"1nginx"` на `"nginx"`:

```yaml
resource "docker_container" "nginx" {...}
```

В `name` ресурса `"docker_container"` ошибки. Поправим:

```yaml
name  = "example_${random_password.random_string.result}"
```

5. после поправок запустим `terraform validate` и получик инфу, что все ок.

Запустим `docker ps` на новой машине, где подняли конейтнере `mysql`:

<img src="https://github.com/user-attachments/assets/776fec67-cd12-4f17-b27e-14b9bcb04815" width="900">

6. Заменим название контейнера на `hello_world`:

![image](https://github.com/user-attachments/assets/c6debda2-1240-487f-8546-8c4454cc3857)

<img src="https://github.com/user-attachments/assets/38c64c97-b2a2-4d60-8b16-22fabab86b9d" width="900">

> [!WARNING]
> Использовать ключ `-auto-approve` опасно, поскольку `terraform apply` применится сразу же после запуска. Это грозит серьезными последствиями, если до этого код не был проверен на 100%.

7. Введем `terraform destroy`. Согласимся.

```bash
docker ps
```

<img src="https://github.com/user-attachments/assets/3372a099-b381-48bb-88f9-0e4833e455aa" width="600">

Файл `terraform.tfstate`:

![image](https://github.com/user-attachments/assets/db86622d-6989-49bd-b103-dd38c0c0f713)

8. Image не удалился из-за пункта:

```yaml
keep_locally = true
```

Инфа из офиицальной документации:

<img src="https://github.com/user-attachments/assets/bfbb0629-baf9-4f26-9d69-fe351e431358" width="600">

## Задача 2

Создадим машину:

![image](https://github.com/user-attachments/assets/37ba9317-1531-4830-b5f6-05a54acb28c7)

В локальной папке (на сервере) клонируем fork репозитория. Код в `/ter-homeworks/01/src2`.

![image](https://github.com/user-attachments/assets/74859aeb-3c88-422c-b4c3-b3aa9af51dce)

В нем файлы: `.gitignore` `main.tf` `personal.auto.tfvars`.
Запустим

```bash
terraform apply
```

Получим сообщение об успешном завершении. Зайдем на нашу новую машину и посмотрим конейтнеры:

```bash
docker ps
```

![image](https://github.com/user-attachments/assets/09752760-288a-401d-8a12-6588a29dc3d5)

Зайдем в контейнер и посмотрим все `env` в системе:

![image](https://github.com/user-attachments/assets/40694f4b-a68f-42e2-88f4-cd2c59d0d70a)


> [!WARNING]
> КАК ПЕРЕДАТЬ ЗНАЧЕНИЕ СГЕНЕРИРОВАННЫХ ПАРОЛЕЙ, НИЧЕГО НЕ ПОМОГЛО.
> 
> Создал отдельный файл `passcreate.tf` в котором 2 ресурса на пароль для `user` и `root`.
> 
> Куда бы не вставлял (`*.tfvars` ; `main.tf` сразу в значение `env = []`)
> 
> ```yaml
> "MYSQL_ROOT_PASSWORD=${random_password.super_user.result}"
> "MYSQL_PASSWORD=${random_password._user.result}"
> ```
> 
> Ничего. Как это сделать? 
