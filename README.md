# Тестовое задание
Развернуть с помощью Terraform 3 виртуалки в GCP и с помощью Ansible развернуть там кластер из трёх инстансов mongo. Доступ к SSH и mongo должен контролироваться файрволлом.

## Используемые инструменты
* Terraform v0.12.8
* Ansible 2.9.6
* Python 2.7.17

## Terraform
### Описание
* main.tf - Манифест для развертывания 3-х виртуалок на ubuntu 16.04, создание правила в firewall для доступа по ssh, генерация hosts файла для Ansible
* terraform.tfvars.example
* - project - ID проекта GCP
* - public_key_path - Путь до публичного ключа
* - private_key_path - Путь до приватного ключа
* - source_ranges - Один или пул IP адресов для доступа к 22 порту
* variables.tf - Описание переменных
```Выбор Ubuntu 16.04 обусловлен тем, что для работы роли mongodb с python3 необходим pip3 и модуль ConfigParser, который в pip3 был переименован в configparser (я пробовал сначала все поднять на 18.04 (не хотелось затягивать с решением))```  

## Ansible
### Описание
* ansible.cfg - Конфигурационный файл Ansible. При желании, можно поменять ssh пользователей.
* hosts.example - Пример инвентаризационного файла Ansible. Terraform сам генерирует и копирует рабочую копию под именем hosts.
* requirements.yml - Список используемых ролей Ansible
* tasks/main.yml - Плейбук для подготовки хостов и запуска ролей.
* group_vars/mongo.yml - Переменные группы хостов
* hosts_vars - Переменные хостов

## Запуск
1. В папке terraform проводим инициализацию (на примере GCP, необходимо сделать gcloud auth application-default login либо предоставить credentials Terraform'y)
```terraform init```
2. Запускаем
```terraform apply -auto-approve```
3. В папке ansible скачиваем роли
```ansible-galaxy install -r requirements.yml```
4. Запускаем
```ansible-playbook tasks/main.yml```

## Пруфы
![Первый](https://i.ibb.co/wYjDFs1/proof.jpg)
![Второй](https://i.ibb.co/ccRZccW/proof2.jpg)

## Послесловие
Если не видели, посмотрите, пожалуйста, мой проект OTUS (используется своё микросервисное приложение): https://github.com/bambarambambum/VisualOffice  