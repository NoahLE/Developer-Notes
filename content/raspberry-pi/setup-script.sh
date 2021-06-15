# WORK IN PROGRESS

# Variables
USERNAME = ""
RASPBERRY_
SSH_PORT = ""
SSH_KEY = ""
WARNING_MESSAGE = "WARNING: Unauthorized access to this system is forbidden and will be prosecuted by law. By accessing this system, you agree that your actions may be monitored if unauthorized usage is suspected."

# Helpers
function add_variable () {
    stringToAdd = $1
    inputFile = $2

    echo "$stringToAdd" >> $inputFile
}

function add_or_change_variable () {
    searchString = $1
    replacementString = $2
    inputFile = $3

    if grep -q $searchString $inputFile; then 
        sed -i "/$searchString/s/.*/$replacementString/" $inputFile
    else
        add_variable $replacementString $inputFile
    fi    
}

function replace_file_contents () {
    content = $1
    inputFileName = $2
    inputFile = $3

    echo $content | sudo tee $inputFileName > $inputFile
}

# -- On host system --
# Login pi@ip
# tip: Add ssh folder to boot drive to enable ssh

# Add ip of your raspberry-pi
# vi /etc/resolvconf/resolv.conf.d/head
# 192.168.0.2
# Log out and back in
# In the router, set the DNS server to your raspberry pi

function update_system () {
    add_variable "alias update-all='sudo apt-get update && sudo apt-get --with-new-pkgs upgrade -y && sudo apt-get autoremove -y && sudo apt-get autoclean -y'" ~/.bashrc
    source ~/.bashrc
    update-all
}

function create_new_account () {
    useradd $USERNAME
    # enter password

    # Add to sudo group
    usermod -aG sudo $USERNAME

    # Switch users and delete olc account
    su - $USERNAME
    deluser -remove-home -f pi
}

function add_ssh_key () {
    mkdir ~/.ssh/
    touch ~/.ssh/authorized_keys
    chmod 644 ~/.ssh/authorized_keys
    echo "$SSH_KEY" >> ~/.ssh/authorized_keys
}

function harden_logins () {
    add_or_change_variable \
        "PASS_MIN_DAYS" \
        "PASS_MIN_DAYS 3" \
        /etc/login.defs

    add_or_change_variable \
        "PASS_MAX_DAYS" \
        "PASS_MAX_DAYS 60" \
        /etc/login.defs

    # add_or_change_variable \
    #     "SHA_CRYPT_MIN_ROUNDS" \
    #     "SHA_CRYPT_MIN_ROUNDS 640000" \
    #     /etc/login.defs

    # add_or_change_variable \
    #     "SHA_CRYPT_MAX_ROUNDS" \
    #     "SHA_CRYPT_MAX_ROUNDS 640000" \
    #     /etc/login.defs

    umask 027 /etc/login.defs

    apt-get install 
}

function harden_sshd_config () {
    add_or_change_variable \
        "ChallengeResponseAuthentication" \
        "ChallengeResponseAuthentication no" \
        /etc/sshd_config

    add_or_change_variable \
        "PasswordAuthentication" \
        "PasswordAuthentication no" \
        /etc/sshd_config

    add_or_change_variable \
        "UsePAM" \
        "UsePAM no" \
        /etc/sshd_config

    add_or_change_variable \
        "PermitRootLogin" \
        "PermitRootLogin no" \
        /etc/sshd_config

    add_or_change_variable \
        "AllowUsers" \
        "AllowUsers $USERNAME" \
        /etc/sshd_config

        add_or_change_variable \
        "AllowTcpForwarding" \
        "AllowTcpForwarding no" \
        /etc/sshd_config

    add_or_change_variable \
        "ClientAliveCountMax" \
        "ClientAliveCountMax 2" \
        /etc/sshd_config

    add_or_change_variable \
        "Compression" \
        "Compression no" \
        /etc/sshd_config

    add_or_change_variable \
        "LogLevel" \
        "LogLevel verbose" \
        /etc/sshd_config

    add_or_change_variable \
        "MaxAuthTries" \
        "MaxAuthTries 3" \
        /etc/sshd_config

        add_or_change_variable \
        "MaxSessions" \
        "MaxSessions 2" \
        /etc/sshd_config

    add_or_change_variable \
        "Port" \
        "Port $SSH_PORT" \
        /etc/sshd_config

    add_or_change_variable \
        "TCPKeepAlive" \
        "TCPKeepAlive no" \
        /etc/sshd_config

    add_or_change_variable \
        "X11Forwarding" \
        "X11Forwarding no" \
        /etc/sshd_config

    add_or_change_variable \
        "AllowAgentForwarding" \
        "AllowAgentForwarding no" \
        /etc/sshd_config

    service ssh reload
    systemctl restart ssh
}

function add_firewall () {
    apt install ufw
    ufw allow ssh http https 53
    ufw enable

    apt install fail2ban
    cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
    echo "
        [ssh]
        enabled  = true
        port     = ssh
        filter   = sshd
        logpath  = /var/log/auth.log
        maxretry = 3
        " >> /etc/fail2ban/jail.local
}

# Security
function misc_hardening () {
    # Add AV
    apt-get install clamav clamav-daemon

    # Secure file
    chmod 750 /etc/sudoers.d

    # stops core dump
    add_variable "* hard core 0" /etc/security/limits.conf

    # Add warning message to ssh
    replace_file_contents $WARNING_MESSAGE "issue" /etc/issue
    replace_file_contents $WARNING_MESSAGE "issue.net" /etc/issue.net

    # Harden PHP
    add_or_change_variable \
        "allow_url_fopen" \ 
        "allow_url_fopen = Off" \
        /etc/php/7.3/cli/php.ini

    add_or_change_variable \
        "allow_url_include" \ 
        "allow_url_include = Off" \
        /etc/php/7.3/cli/php.ini

    add_or_change_variable \
        "allow_url_fopen" \ 
        "allow_url_fopen = Off" \
        /etc/php/7.3/cgi/php.ini

    add_or_change_variable \
        "allow_url_include" \ 
        "allow_url_include = Off" \
        /etc/php/7.3/cgi/php.ini        

    # Add unattended upgrades
    apt-get install unattended-upgrades apt-listchanges
    echo unattended-upgrades unattended-upgrades/enable_auto_updates boolean true | debconf-set-selections
    dpkg-reconfigure -f noninteractive unattended-upgrades
}

# Audit
function lynis_audit_system () {
    apt-get install git apt-show-versions debsums
    git clone https://github.com/CISOfy/lynis
    cd lynis; ./lynis audit system
}

main () {
    echo "=== Running setup script ==="
    # update_system
    # create_new_account
    # add_ssh_key
    # harden_sshd_config
    # add_firewall
    # misc_hardening

    # Restart
    # shutdown now -r
    echo "=== Done running ==="
}

main ()