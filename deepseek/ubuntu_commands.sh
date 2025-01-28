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
    echo -e "${BLUE}7. Docker Compose${NC}"
    echo -e "${BLUE}8. Управление пользователями${NC}"
    echo -e "${BLUE}9. Управление дисками${NC}"
    echo -e "${BLUE}10. Работа с процессами${NC}"
    echo -e "${BLUE}11. SSH${NC}"
    echo -e "${BLUE}12. Git${NC}"
    echo -e "${BLUE}13. Python${NC}"
    echo -e "${BLUE}14. Firewall (UFW)${NC}"
    echo -e "${BLUE}15. Базы данных${NC}"
    echo -e "${BLUE}16. Выход${NC}"
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
    echo -e "${BLUE}6. Показать uptime системы${NC}"
    echo -e "${BLUE}7. Показать версию ядра${NC}"
    echo -e "${BLUE}8. Вернуться в главное меню${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -n -e "${YELLOW}Выберите команду: ${NC}"
    read choice
    case $choice in
        1) sudo reboot; log_action "Перезагрузка системы" ;;
        2) sudo shutdown -h now; log_action "Выключение системы" ;;
        3) neofetch; log_action "Просмотр информации о системе" ;;
        4) df -h; log_action "Проверка использования диска" ;;
        5) htop; log_action "Просмотр запущенных процессов" ;;
        6) uptime; log_action "Просмотр uptime системы" ;;
        7) uname -r; log_action "Просмотр версии ядра" ;;
        8) return ;;
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
    echo -e "${BLUE}6. Показать маршрут${NC}"
    echo -e "${BLUE}7. Вернуться в главное меню${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -n -e "${YELLOW}Выберите команду: ${NC}"
    read choice
    case $choice in
        1) ip a; log_action "Просмотр IP-адреса" ;;
        2) ping -c 4 google.com; log_action "Проверка интернет-соединения" ;;
        3) sudo netstat -tuln; log_action "Просмотр открытых портов" ;;
        4) ifconfig; log_action "Просмотр сетевых интерфейсов" ;;
        5) echo -n "Введите хост: "; read host; ping -c 4 $host; log_action "Проверка доступности хоста: $host" ;;
        6) route -n; log_action "Просмотр маршрута" ;;
        7) return ;;
        *) echo -e "${RED}Неверный выбор. Попробуйте снова.${NC}" ;;
    esac
    read -p "Нажмите Enter, чтобы продолжить..."
}

# Функция для работы с Docker
docker_commands() {
    clear
    echo -e "${GREEN}====================================${NC}"
    echo -e "${GREEN} Docker ${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -e "${BLUE}1. Запустить контейнер${NC}"
    echo -e "${BLUE}2. Остановить контейнер${NC}"
    echo -e "${BLUE}3. Показать запущенные контейнеры${NC}"
    echo -e "${BLUE}4. Показать все контейнеры${NC}"
    echo -e "${BLUE}5. Удалить контейнер${NC}"
    echo -e "${BLUE}6. Показать образы${NC}"
    echo -e "${BLUE}7. Очистить неиспользуемые данные Docker${NC}"
    echo -e "${BLUE}8. Вернуться в главное меню${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -n -e "${YELLOW}Выберите команду: ${NC}"
    read choice
    case $choice in
        1) echo -n "Введите имя образа: "; read image; docker run -d $image; log_action "Запуск контейнера: $image" ;;
        2) echo -n "Введите ID контейнера: "; read id; docker stop $id; log_action "Остановка контейнера: $id" ;;
        3) docker ps; log_action "Просмотр запущенных контейнеров" ;;
        4) docker ps -a; log_action "Просмотр всех контейнеров" ;;
        5) echo -n "Введите ID контейнера: "; read id; docker rm $id; log_action "Удаление контейнера: $id" ;;
        6) docker images; log_action "Просмотр образов Docker" ;;
        7) docker system prune -f; log_action "Очистка неиспользуемых данных Docker" ;;
        8) return ;;
        *) echo -e "${RED}Неверный выбор. Попробуйте снова.${NC}" ;;
    esac
    read -p "Нажмите Enter, чтобы продолжить..."
}

# Функция для работы с Docker Compose
docker_compose_commands() {
    clear
    echo -e "${GREEN}====================================${NC}"
    echo -e "${GREEN} Docker Compose ${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -e "${BLUE}1. Запустить сервисы${NC}"
    echo -e "${BLUE}2. Остановить сервисы${NC}"
    echo -e "${BLUE}3. Перезапустить сервисы${NC}"
    echo -e "${BLUE}4. Показать логи сервисов${NC}"
    echo -e "${BLUE}5. Показать статус сервисов${NC}"
    echo -e "${BLUE}6. Вернуться в главное меню${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -n -e "${YELLOW}Выберите команду: ${NC}"
    read choice
    case $choice in
        1) docker-compose up -d; log_action "Запуск сервисов Docker Compose" ;;
        2) docker-compose down; log_action "Остановка сервисов Docker Compose" ;;
        3) docker-compose restart; log_action "Перезапуск сервисов Docker Compose" ;;
        4) echo -n "Введите имя сервиса: "; read service; docker-compose logs $service; log_action "Просмотр логов сервиса: $service" ;;
        5) docker-compose ps; log_action "Просмотр статуса сервисов Docker Compose" ;;
        6) return ;;
        *) echo -e "${RED}Неверный выбор. Попробуйте снова.${NC}" ;;
    esac
    read -p "Нажмите Enter, чтобы продолжить..."
}

# Функция для управления пользователями
user_commands() {
    clear
    echo -e "${GREEN}====================================${NC}"
    echo -e "${GREEN} Управление пользователями ${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -e "${BLUE}1. Добавить пользователя${NC}"
    echo -e "${BLUE}2. Удалить пользователя${NC}"
    echo -e "${BLUE}3. Изменить пароль пользователя${NC}"
    echo -e "${BLUE}4. Добавить пользователя в группу${NC}"
    echo -e "${BLUE}5. Показать список пользователей${NC}"
    echo -e "${BLUE}6. Вернуться в главное меню${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -n -e "${YELLOW}Выберите команду: ${NC}"
    read choice
    case $choice in
        1) echo -n "Введите имя пользователя: "; read user; sudo adduser $user; log_action "Добавление пользователя: $user" ;;
        2) echo -n "Введите имя пользователя: "; read user; sudo deluser $user; log_action "Удаление пользователя: $user" ;;
        3) echo -n "Введите имя пользователя: "; read user; sudo passwd $user; log_action "Изменение пароля пользователя: $user" ;;
        4) echo -n "Введите имя пользователя: "; read user; echo -n "Введите имя группы: "; read group; sudo usermod -aG $group $user; log_action "Добавление пользователя $user в группу $group" ;;
        5) cut -d: -f1 /etc/passwd; log_action "Просмотр списка пользователей" ;;
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
        7) docker_compose_commands ;;
        8) user_commands ;;
        9) disk_commands ;;
        10) process_commands ;;
        11) ssh_commands ;;
        12) git_commands ;;
        13) python_commands ;;
        14) firewall_commands ;;
        15) database_commands ;;
        16) break ;;
        *) echo -e "${RED}Неверный выбор. Попробуйте снова.${NC}" ;;
    esac
    read -p "Нажмите Enter, чтобы продолжить..."
done

echo -e "${GREEN}Выход из меню.${NC}"