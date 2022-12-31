# Инструкция по сборке и запуску `Docker` контейнера с `Jupyterhub`

Установка `Docker`
----------------------
Для сборки контейнера вам понадобится установать `Docker` - ПО, 
предназначенное для работы с технологиями контейнеризации

Если вы используете Windows, вам поможет [эта](https://docs.docker.com/desktop/installwindows-install/) инструкция по установке

Если вы используете Linux, то вам поможет [эта](https://docs.docker.com/engine/install/ubuntu/) инструкция по установке

Копирование файлов
----------------------
Если вы знакомы с системой контроля версий `git` или знакомы с поддерживаемыми ею 
консольными командами, вы можете скачать код репозитория при помощи команды
    
    git clone https://github.com/i80287/lab-docker.git

Также вы можете скачать `zip` архив c файлами проекта в 2 шага, как это показано ниже:
<h1 align="center">
<img src="https://i.ibb.co/jRk35YK/rep-download-instr.png" style="width:451px;height:553px;">
</h1><br>

После скачивания архива его нужно распаковать

Сборка и запуск контейнера
----------------------
> Если вы используете Linux, то написанные далее команды надо вызывать
> либо от имени суперюзера `root` (или юзера с соответствующими правами), 
> либо с указанием модификатора права доступа `sudo` перед каждой командой

На этом шаге будет проиcходить сборка и запуск контейнера:

**1.** Перейдите в скачанную папку (директорию)

**2.** Запустите консольную команду 
    
    docker compose up

Так вы запустите исполнение файла docker-compose.yml и будут выполнены действия:

- Создастся образ контейнера с именем `jupyterhub_lab` и тегом `1.0`

- Создастся `volume` `home-volume` (или будет использоваться существующий, если уже есть), который 
будет указывать на папку, в которой будут храниться данные папки `/home` файловой системы контейнера

- Из созданного образа будет создан и запущен контейнер. Все запросы с порта `80`, на котором будет поднят 
сервер `Jupyterhub` внути контейнера, будут ретранслированы на порт `8088` на хосте (вашем компьютере)

**3.** В браузере перейдите по ссылке http://127.0.0.1:8088/

Перед вами откроется окно входа в аккаунт в системе `Jupyterhub`

Введите пару логин-пароль `admin` - `admin`

<h1 align="center">
<img src="https://i.ibb.co/f4d0bjW/log-in-preview.png" style="width:381px;height:391px;">
</h1><br>

Для вас будет создан сервер, на который вы сможете загружать свои файлы

Т.к. данные пользователя `admin` хранятся в `/home/admin`, то загруженные

вами файлы не будут потеряны даже при удалении контейнера (доступ к ним можно получить через `volume`)

**4.** Также могут быть полезными эти команды:

- Если вам нужно посмотреть список всех контейнеров, вызовите консольную команду

```sh
docker ps -a
```

- Если вам нужно остановить контейнер, вызовите консольную команду

```sh
docker stop имя_контейнера
```

- Если вам нужно запусить существующий контейнер, вызовите консольную команду

```sh
docker start имя_контейнера
```

- Если вам нужно удалить контейнер, вызовите консольную команду

```sh
docker rm имя_контейнера
```

Загрузка своих ноутбуков
----------------------
Для загрузки своих `Jupyter ноутбуков` (файлы `Jupyter Notebook` с расширением `.ipynb`) нужно:

**1.** Открыть в редакторе файл `Dockerfile` и раскомментировать (убрать `# `) перед 3 строками, как на фото:
<h1 align="center">
<img src="https://i.ibb.co/mvmBsw5/file-uncomment.png" style="width:954px;height:199px;">
</h1><br>

Здесь переменная `NOTEBOOKS_FROM` отвечает за расположение файлов в вашей системе (`source`) <br />
переменная `HUB_PATH` отвечает за расположение файлов в файловой системе контейнера (`destination`) <br />
Команда `COPY ${NOTEBOOKS_FROM} ${HUB_PATH}` выполняет копирование из `NOTEBOOKS_FROM` в `HUB_PATH` <br />

Вы можете не менять значения переменных и просто скопировать свои файлы в папку проекта, тогда файлы 
с расширением `.ipynb` будут искаться в папке проекта, на одном уровне с `Dockerfile`, и при 
пересборке проекта (шаги 1-3) будет запущен новый `Jupyterhub` сервер, и пользователю `admin` 
будут скопированы все ноутбуки, которые вы переместили в папку проекта

Если вы хотите указать свой путь до ноутбуков или изменить место их хранения внути файловой 
системы контейнера (внутри контейнера развёрнута своя операционная система, в данном 
случае - `Ubuntu`, со своей фаловой системой), то пути можно указать, изменив 
переменные `NOTEBOOKS_FROM` и `HUB_PATH` в `Dockerfile`.

При указании путей стоит учитывать, что в `Unix` подобных системах, к которым относится и `Ubuntu`, 
(т.к. является дистрибутивом ос `Debian`), файлы в пути разделяются символом `/`, а не `\`, как в `Windows` и `Dos`

- **Документация по Docker:** https://docs.docker.com/
- **Документация по модификатору sudo в Linux:** https://linux.die.net/man/8/sudo
- **Документация по Jupyterhub:** https://jupyterhub.readthedocs.io/en/stable/
