#!/bin/bash

# Цвета для оформления
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Логирование действий
log_action() {
    echo -e "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> script.log
}

# Проверка зависимостей
check_dependencies() {
    if ! command -v dig &> /dev/null; then
        sudo apt install -y dnsutils
    fi
    if ! command -v jq &> /dev/null; then
        sudo apt install -y jq
    fi
}

# Главное меню
show_menu() {
    clear
    echo -e "${GREEN}===========================================${NC}"
    echo -e "${MAGENTA} Ultimate DevOps Helper - Ubuntu 22.04 ${NC}"
    echo -e "${GREEN}===========================================${NC}"
    echo -e "${CYAN} 1. Системные команды"
    echo -e " 2. Сетевые команды"
    echo -e " 3. Управление пакетами"
    echo -e " 4. Управление файлами"
    echo -e " 5. Мониторинг системы"
    echo -e " 6. Docker"
    echo -e " 7. Docker Compose"
    echo -e " 8. Управление пользователями"
    echo -e " 9. Управление дисками"
    echo -e "10. Работа с процессами"
    echo -e "11. SSH"
    echo -e "12. Git"
    echo -e "13. Python"
    echo -e "14. Firewall (UFW)"
    echo -e "15. Базы данных"
    echo -e "16. Управление хостами и DNS"
    echo -e "17. DevOps Tools Installation"
    echo -e "18. Выход${NC}"
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

# Управление хостами и DNS
host_dns_commands() {
    clear
    echo -e "${GREEN}====================================${NC}"
    echo -e "${GREEN} Управление хостами и DNS ${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -e "${BLUE}1. Показать DNS-записи домена${NC}"
    echo -e "${BLUE}2. Добавить запись в /etc/hosts${NC}"
    echo -e "${BLUE}3. Проверить доступность порта${NC}"
    echo -e "${BLUE}4. Изменить DNS-серверы${NC}"
    echo -e "${BLUE}5. Показать текущие DNS-серверы${NC}"
    echo -e "${BLUE}6. Вернуться в главное меню${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -n -e "${YELLOW}Выберите команду: ${NC}"
    read choice
    
    case $choice in
        1)  echo -n "Введите домен: "; read domain
            dig $domain ANY +noall +answer
            log_action "Проверка DNS-записей для $domain" ;;
            
        2)  echo -n "Введите IP: "; read ip
            echo -n "Введите домен: "; read host
            echo "$ip $host" | sudo tee -a /etc/hosts
            log_action "Добавлена запись в /etc/hosts: $ip $host" ;;
            
        3)  echo -n "Введите хост: "; read host
            echo -n "Введите порт: "; read port
            nc -zv $host $port
            log_action "Проверка порта $port на $host" ;;
            
        4)  echo -n "Введите DNS-серверы (через пробел): "; read dns_servers
            sudo resolvectl dns eth0 $dns_servers
            log_action "Изменены DNS-серверы: $dns_servers" ;;
            
        5)  resolvectl status | grep "DNS Servers"
            log_action "Просмотр текущих DNS-серверов" ;;
            
        6)  return ;;
        
        *)  echo -e "${RED}Неверный выбор!${NC}" ;;
    esac
    read -p "Нажмите Enter, чтобы продолжить..."
}

# Установка DevOps инструментов
devops_tools_installation() {
    clear
    echo -e "${GREEN}====================================${NC}"
    echo -e "${GREEN} Установка DevOps инструментов ${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -e "${BLUE}1. Установить базовые утилиты${NC}"
    echo -e "${BLUE}2. Установить Docker и Docker Compose${NC}"
    echo -e "${BLUE}3. Установить Kubernetes tools${NC}"
    echo -e "${BLUE}4. Установить Terraform${NC}"
    echo -e "${BLUE}5. Установить Ansible${NC}"
    echo -e "${BLUE}6. Установить Python Dev Tools${NC}"
    echo -e "${BLUE}7. Установить Go${NC}"
    echo -e "${BLUE}8. Установить Node.js${NC}"
    echo -e "${BLUE}9. Вернуться в главное меню${NC}"
    echo -e "${GREEN}====================================${NC}"
    echo -n -e "${YELLOW}Выберите опцию: ${NC}"
    read choice
    
    case $choice in
        1)  sudo apt install -y curl wget jq tmux htop tree
            log_action "Установлены базовые утилиты" ;;
            
        2)  sudo apt install -y docker.io
            sudo systemctl enable --now docker
            sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
            sudo chmod +x /usr/local/bin/docker-compose
            log_action "Установлены Docker и Docker Compose" ;;
            
        3)  sudo apt install -y kubectl helm minikube
            log_action "Установлены Kubernetes инструменты" ;;
            
        4)  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
            echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
            sudo apt update && sudo apt install -y terraform
            log_action "Установлен Terraform" ;;
            
        5)  sudo apt install -y ansible
            log_action "Установлен Ansible" ;;
            
        6)  sudo apt install -y python3-venv python3-pip python3-dev build-essential
            log_action "Установлены Python Dev Tools" ;;
            
        7)  wget https://go.dev/dl/go1.20.4.linux-amd64.tar.gz
            sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.20.4.linux-amd64.tar.gz
            echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
            source ~/.bashrc
            log_action "Установлен Go" ;;
            
        8)  curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
            sudo apt install -y nodejs
            log_action "Установлен Node.js" ;;
            
        9)  return ;;
        
        *)  echo -e "${RED}Неверный выбор!${NC}" ;;
    esac
    read -p "Нажмите Enter, чтобы продолжить..."
}

# Основной цикл
check_dependencies
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
        16) host_dns_commands ;;
        17) devops_tools_installation ;;
        18) break ;;
        *) echo -e "${RED}Неверный выбор!${NC}" ;;
    esac
done

echo -e "${GREEN}До новых встреч!${NC}"