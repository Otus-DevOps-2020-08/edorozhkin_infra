# edorozhkin_infra
edorozhkin Infra repository

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


