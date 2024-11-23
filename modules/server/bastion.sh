#!bin/bash
# sudo echo "-----BEGIN RSA PRIVATE KEY-----
">>/home/$USER/key
# sudo chmod 777 /home/$USER/key
#!/bin/bash

# Function to print colorful messages
print_message() {
    echo -e "\e[1;34m>>> $1\e[0m"
}

# Function to check Java version
check_java() {
    if command -v java >/dev/null 2>&1; then
        java_version=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | awk -F. '{print $1}')
        if [ "$java_version" -ge 11 ]; then
            print_message "Compatible Java version found: $(java -version 2>&1 | head -n 1)"
            return 0
        fi
    fi
    return 1
}

# Function to install Java
install_java() {
    case "$OS" in
        "Linux")
            if command -v apt-get >/dev/null 2>&1; then
                print_message "Installing OpenJDK 11 on Ubuntu/Debian"
                sudo apt-get update
                sudo apt-get install -y openjdk-11-jdk
            elif command -v yum >/dev/null 2>&1; then
                print_message "Installing OpenJDK 11 on RHEL/CentOS"
                sudo yum install -y java-11-openjdk-devel
            else
                echo "Unsupported Linux distribution"
                exit 1
            fi
            ;;
        "Darwin")
            print_message "Installing OpenJDK 11 on macOS"
            if ! command -v brew >/dev/null 2>&1; then
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            fi
            brew install openjdk@11
            sudo ln -sfn $(brew --prefix)/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk
            ;;
        "Windows")
            print_message "Installing OpenJDK 11 on Windows"
            # Using chocolatey package manager
            if ! command -v choco >/dev/null 2>&1; then
                powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
            fi
            choco install openjdk11 -y
            ;;
    esac
}

# Function to install Jenkins
install_jenkins() {
    case "$OS" in
        "Linux")
            if command -v apt-get >/dev/null 2>&1; then
                print_message "Installing Jenkins on Ubuntu/Debian"
                curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
                    /usr/share/keyrings/jenkins-keyring.asc > /dev/null
                echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
                    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
                    /etc/apt/sources.list.d/jenkins.list > /dev/null
                sudo apt-get update
                sudo apt-get install -y jenkins
                sudo systemctl enable jenkins
                sudo systemctl start jenkins
            elif command -v yum >/dev/null 2>&1; then
                print_message "Installing Jenkins on RHEL/CentOS"
                sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
                sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
                sudo yum install -y jenkins
                sudo systemctl enable jenkins
                sudo systemctl start jenkins
            fi
            ;;
        "Darwin")
            print_message "Installing Jenkins on macOS"
            brew install jenkins-lts
            brew services start jenkins-lts
            ;;
        "Windows")
            print_message "Installing Jenkins on Windows"
            # Download latest Jenkins.msi
            powershell -Command "Invoke-WebRequest -Uri 'https://get.jenkins.io/windows-stable/latest' -OutFile 'jenkins.msi'"
            # Install Jenkins
            msiexec /i jenkins.msi /qn
            # Start Jenkins service
            net start jenkins
            ;;
    esac
}

# Function to check if script is run as administrator/root
check_privileges() {
    case "$OS" in
        "Linux"|"Darwin")
            if [ "$EUID" -ne 0 ]; then
                echo "Please run as root or with sudo"
                exit 1
            fi
            ;;
        "Windows")
            # Check if running with admin privileges in Windows
            net session >/dev/null 2>&1
            if [ $? -ne 0 ]; then
                echo "Please run as Administrator"
                exit 1
            fi
            ;;
    esac
}

# Main script
main() {
    # Detect operating system
    case "$(uname -s)" in
        Linux*)     OS="Linux";;
        Darwin*)    OS="Darwin";;
        CYGWIN*|MINGW*|MSYS*)    OS="Windows";;
        *)          echo "Unsupported operating system"; exit 1;;
    esac

    print_message "Detected Operating System: $OS"
    
    # Check privileges
    check_privileges

    # Check and install Java if needed
    if ! check_java; then
        print_message "Compatible Java version not found. Installing Java..."
        install_java
    fi

    # Install Jenkins
    print_message "Installing Jenkins..."
    install_jenkins

    # Print success message and initial admin password
    print_message "Jenkins installation completed!"
    
    case "$OS" in
        "Linux")
            print_message "Initial admin password: $(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)"
            print_message "Jenkins is available at: http://localhost:8080"
            ;;
        "Darwin")
            print_message "Initial admin password: $(cat ~/.jenkins/secrets/initialAdminPassword)"
            print_message "Jenkins is available at: http://localhost:8080"
            ;;
        "Windows")
            print_message "Initial admin password: $(type C:\ProgramData\Jenkins\.jenkins\secrets\initialAdminPassword)"
            print_message "Jenkins is available at: http://localhost:8080"
            ;;
    esac
}

# Execute main function
main
