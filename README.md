# edorozhkin_infra
edorozhkin Infra repository

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


