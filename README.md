# edorozhkin_infra
edorozhkin Infra repository

## ДЗ к лекции №13

 - Создан Vagrantfile
 - Доработаны роли app и db.
 - С помощью molecule были проведены тесты

## ДЗ к лекции №12

 - Созданы роли
 - Созданы два окружения prod и stage
 - Интегрирована роль nginx, приложение доступно на 80 порту
 - Использован Ansible Vault для шифрования файлов

## ДЗ к лекции №11

- Написан плейбук для ансибл
- Плейбук разбит на части
- Провижн образов Packer изменён на плейбуки ансибл

## ДЗ к лекции №10

- Установлен ansible
- Создан inventory 
- Написан и запущен плейбук для клонирования git репозитория
- После удаления директории ~/reddit запуск плейбука вернул changed=1, так как изменения были применены из-за отсутствия файлов
```
ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```


## ДЗ к лекции №9

- Инстансы ВМ разделены на DB и APP
- Созданы модули db и app
- Созданы два окружения prod и stage

## ДЗ к лекции №8

- С помощью terraform создана ВМ
- Переменные вынесены в отдельный файл
- Файлы конфигураций отформатированы


## ДЗ к лекции №7

- Создан шаблон  packer для создания образов ВМ
- Построен bake образ ВМ
```
packer build -var-file=variables.json ./immutable.json
```
- Создан скрипт создания ВМ c помощью CLI
```
/config-scripts/create-reddit-vm.sh
```

## ДЗ к лекции №6

testapp_IP = 130.193.50.14
testapp_port = 9292

### Создание ВМ с помощью metadata.yaml

```
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=./reddit_metadata.yaml
```

## ДЗ к лекции №5

bastion_IP = 84.201.134.251
someinternalhost_IP = 10.130.0.20

### Подключение в одну команду
```
ssh -i ~/.ssh/appuser -J appuser@84.201.134.251 appuser@10.130.0.20
```
или
```
ssh -i ~/.ssh/appuser -At appuser@84.201.134.251 ssh appuser@10.130.0.20
```

### Для подключения по алиасу в ~/.ssh/config добавить:
```
Host bastion
        Hostname 84.201.134.251
        IdentityFile ~/.ssh/appuser
        Port 22
        User appuser


Host someinternalhost
        ProxyJump bastion
        HostName 10.130.0.20
        IdentityFile ~/.ssh/appuser
        Port 22
        User appuser
```

### Вход без жалоб на серт

```
https://84.201.134.251.xip.io
```


