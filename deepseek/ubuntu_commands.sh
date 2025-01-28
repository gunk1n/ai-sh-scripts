#!/bin/bash

# Цвета для оформления
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Логирование действий
log_action() {
    echo -e "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> script.log
}

# Функция для отображения главного меню
show_menu() {
    clear
    echo -e "${GREEN}===========================================${NC}"
    echo -e "${GREEN} Меню полезных команд Ubuntu 22.04 ${NC}"
    echo -e "${GREEN}===========================================${NC}"
    echo -e "${BLUE}1. Системные команды${NC}"
    echo -e "${BLUE}2. Сетевые команды${NC}"
    echo -e "${BLUE}3. Управление пакетами${NC}"
    echo -e "${BLUE}4. Управление файлами${NC}"
    echo -e "${BLUE}5. Мониторинг системы${NC}"
    echo -e "${BLUE}6. Docker${NC}"
    echo -e "${BLUE}7. SSH${NC}"
    echo -e "${BLUE}8. Git${NC}"
    echo -e "${BLUE}9. Python${NC}"
    echo -e "${BLUE}10. Firewall (UFW)${NC}"
    echo -e "${BLUE}11. Базы данных${NC}"
    echo -e "${BLUE}12. Выход${NC}"
    echo -e "${GREEN}===========================================${NC}"
    echo -n -e "${YELLOW}Выберите категорию: ${NC}"
}

# Функция для отображения системных команд
system_commands() {
    clear
    echo -e "${GREEN}====================================${NC}"
    echo -e "${GREEN} Системные команды ${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -e "${BLUE}1. Перезагрузить систему${NC}"
    echo -e "${BLUE}2. Выключить систему${NC}"
    echo -e "${BLUE}3. Показать информацию о системе${NC}"
    echo -e "${BLUE}4. Проверить использование диска${NC}"
    echo -e "${BLUE}5. Показать запущенные процессы${NC}"
    echo -e "${BLUE}6. Вернуться в главное меню${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -n -e "${YELLOW}Выберите команду: ${NC}"
    read choice
    case $choice in
        1) sudo reboot; log_action "Перезагрузка системы" ;;
        2) sudo shutdown -h now; log_action "Выключение системы" ;;
        3) neofetch; log_action "Просмотр информации о системе" ;;
        4) df -h; log_action "Проверка использования диска" ;;
        5) htop; log_action "Просмотр запущенных процессов" ;;
        6) return ;;
        *) echo -e "${RED}Неверный выбор. Попробуйте снова.${NC}" ;;
    esac
    read -p "Нажмите Enter, чтобы продолжить..."
}

# Функция для отображения сетевых команд
network_commands() {
    clear
    echo -e "${GREEN}====================================${NC}"
    echo -e "${GREEN} Сетевые команды ${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -e "${BLUE}1. Показать IP-адрес${NC}"
    echo -e "${BLUE}2. Проверить соединение с интернетом${NC}"
    echo -e "${BLUE}3. Показать открытые порты${NC}"
    echo -e "${BLUE}4. Показать сетевые интерфейсы${NC}"
    echo -e "${BLUE}5. Проверить доступность хоста${NC}"
    echo -e "${BLUE}6. Вернуться в главное меню${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -n -e "${YELLOW}Выберите команду: ${NC}"
    read choice
    case $choice in
        1) ip a; log_action "Просмотр IP-адреса" ;;
        2) ping -c 4 google.com; log_action "Проверка интернет-соединения" ;;
        3) sudo netstat -tuln; log_action "Просмотр открытых портов" ;;
        4) ifconfig; log_action "Просмотр сетевых интерфейсов" ;;
        5) echo -n "Введите хост: "; read host; ping -c 4 $host; log_action "Проверка доступности хоста: $host" ;;
        6) return ;;
        *) echo -e "${RED}Неверный выбор. Попробуйте снова.${NC}" ;;
    esac
    read -p "Нажмите Enter, чтобы продолжить..."
}

# Функция для отображения команд управления пакетами
package_commands() {
    clear
    echo -e "${GREEN}====================================${NC}"
    echo -e "${GREEN} Управление пакетами ${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -e "${BLUE}1. Обновить список пакетов${NC}"
    echo -e "${BLUE}2. Установить пакет${NC}"
    echo -e "${BLUE}3. Удалить пакет${NC}"
    echo -e "${BLUE}4. Обновить все пакеты${NC}"
    echo -e "${BLUE}5. Поиск пакета${NC}"
    echo -e "${BLUE}6. Очистить кэш пакетов${NC}"
    echo -e "${BLUE}7. Вернуться в главное меню${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -n -e "${YELLOW}Выберите команду: ${NC}"
    read choice
    case $choice in
        1) sudo apt update; log_action "Обновление списка пакетов" ;;
        2) echo -n "Введите имя пакета: "; read pkg; sudo apt install $pkg; log_action "Установка пакета: $pkg" ;;
        3) echo -n "Введите имя пакета: "; read pkg; sudo apt remove $pkg; log_action "Удаление пакета: $pkg" ;;
        4) sudo apt upgrade; log_action "Обновление всех пакетов" ;;
        5) echo -n "Введите имя пакета для поиска: "; read pkg; apt search $pkg; log_action "Поиск пакета: $pkg" ;;
        6) sudo apt clean; log_action "Очистка кэша пакетов" ;;
        7) return ;;
        *) echo -e "${RED}Неверный выбор. Попробуйте снова.${NC}" ;;
    esac
    read -p "Нажмите Enter, чтобы продолжить..."
}

# Функция для работы с Git
git_commands() {
    clear
    echo -e "${GREEN}====================================${NC}"
    echo -e "${GREEN} Git ${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -e "${BLUE}1. Клонировать репозиторий${NC}"
    echo -e "${BLUE}2. Показать статус репозитория${NC}"
    echo -e "${BLUE}3. Добавить файлы в коммит${NC}"
    echo -e "${BLUE}4. Создать коммит${NC}"
    echo -e "${BLUE}5. Отправить изменения в удаленный репозиторий${NC}"
    echo -e "${BLUE}6. Вернуться в главное меню${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -n -e "${YELLOW}Выберите команду: ${NC}"
    read choice
    case $choice in
        1) echo -n "Введите URL репозитория: "; read url; git clone $url; log_action "Клонирование репозитория: $url" ;;
        2) git status; log_action "Просмотр статуса репозитория" ;;
        3) echo -n "Введите файлы для добавления: "; read files; git add $files; log_action "Добавление файлов: $files" ;;
        4) echo -n "Введите сообщение коммита: "; read msg; git commit -m "$msg"; log_action "Создание коммита: $msg" ;;
        5) git push; log_action "Отправка изменений в удаленный репозиторий" ;;
        6) return ;;
        *) echo -e "${RED}Неверный выбор. Попробуйте снова.${NC}" ;;
    esac
    read -p "Нажмите Enter, чтобы продолжить..."
}

# Функция для работы с Python
python_commands() {
    clear
    echo -e "${GREEN}====================================${NC}"
    echo -e "${GREEN} Python ${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -e "${BLUE}1. Запустить Python скрипт${NC}"
    echo -e "${BLUE}2. Установить Python пакет${NC}"
    echo -e "${BLUE}3. Создать виртуальное окружение${NC}"
    echo -e "${BLUE}4. Активировать виртуальное окружение${NC}"
    echo -e "${BLUE}5. Деактивировать виртуальное окружение${NC}"
    echo -e "${BLUE}6. Вернуться в главное меню${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -n -e "${YELLOW}Выберите команду: ${NC}"
    read choice
    case $choice in
        1) echo -n "Введите путь к скрипту: "; read script; python3 $script; log_action "Запуск Python скрипта: $script" ;;
        2) echo -n "Введите имя пакета: "; read pkg; pip install $pkg; log_action "Установка Python пакета: $pkg" ;;
        3) echo -n "Введите имя окружения: "; read env; python3 -m venv $env; log_action "Создание виртуального окружения: $env" ;;
        4) echo -n "Введите путь к окружению: "; read env; source $env/bin/activate; log_action "Активация виртуального окружения: $env" ;;
        5) deactivate; log_action "Деактивация виртуального окружения" ;;
        6) return ;;
        *) echo -e "${RED}Неверный выбор. Попробуйте снова.${NC}" ;;
    esac
    read -p "Нажмите Enter, чтобы продолжить..."
}

# Основной цикл меню
while true; do
    show_menu
    read choice
    case $choice in
        1) system_commands ;;
        2) network_commands ;;
        3) package_commands ;;
        4) file_commands ;;
        5) monitoring_commands ;;
        6) docker_commands ;;
        7) ssh_commands ;;
        8) git_commands ;;
        9) python_commands ;;
        10) firewall_commands ;;
        11) database_commands ;;
        12) break ;;
        *) echo -e "${RED}Неверный выбор. Попробуйте снова.${NC}" ;;
    esac
    read -p "Нажмите Enter, чтобы продолжить..."
done

echo -e "${GREEN}Выход из меню.${NC}"