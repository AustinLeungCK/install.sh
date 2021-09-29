#!/bin/zsh
# caffeinate -d curl
# $1: team name

user=${SUDO_USER:-${USER}}

#----------------Xcode CLI installation----------------
echo "🟡🟡🟡 Checking Xcode CLI tools 🟡🟡🟡 "
# Only run if the tools are not installed yet
# To check that try to print the SDK path
xcode-select -p &> /dev/null
if [ $? -ne 0 ]; then
  echo "🟡🟡🟡 Xcode CLI tools not found. Installing them... 🟡🟡🟡"
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
  PROD=$(softwareupdate -l |
    grep "\*.*Command Line" |
    head -n 1 | awk -F"*" '{print $2}' | 
    sed -e 's/^ *//' |
    sed 's/Label: //g' | tr -d '\n' |
    tr -d '\n')
  softwareupdate -i "$PROD" --verbose
  softwareupdate --all --install --force
  rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  echo "✅ Xcode CLI tools OK ✅"
else
  echo "✅ Xcode CLI tools OK ✅"
fi

#----------------homebrew installation----------------
if [ ! -f "/Users/$user/homebrew/bin/brew" ];then
  cd /Users/$user/
  mkdir -p homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
  chown -R $user /Users/$user/homebrew
  echo "eval $(/Users/$user/homebrew/bin/brew shellenv)" >> /Users/$user/.zprofile
  eval $(/Users/$user/homebrew/bin/brew shellenv)
  #echo "export PATH=/Users/$user/homebrew/bin:$PATH" >> /Users/$user/.zshrc
  echo "✅ homebrew install successfully. ✅ "

else
  echo "✅ homebrew already exists, skipping download.... ✅ "
fi

#----------------NewEmployeeOnboardGuide.url----------------
cd /Users/$user/Desktop/
touch NewEmployeeOnboardGuide.url
echo "[InternetShortcut]" >> NewEmployeeOnboardGuide.url
echo "URL=https://shelves.gtomato.com/books/gt-onboarding-user-guide/page/new-employee-onboarding-guide" >> NewEmployeeOnboardGuide.url
echo "IconIndex=0" >> NewEmployeeOnboardGuide.url

#----------------Essentials installation----------------
cd /Users/$user/homebrew/bin

echo "🟡🟡🟡 Installing Essentials software 🟡🟡🟡 "
if [ "$1" = "design" ] && [ ! -d "/Applications/Google Chrome.app" ] ; then
  ./brew install --cask --force google-chrome firefox zoom-for-it-admins slack chrome-remote-desktop-host notion rectangle
elif [ ! -d "/Applications/Google Chrome.app" ] ; then
  ./brew install --cask --force adobe-acrobat-reader google-chrome firefox zoom-for-it-admins iterm2 visual-studio-code slack chrome-remote-desktop-host notion rectangle
  ./brew install openjdk@8

  sudo ln -sfn /Users/$user/homebrew/opt/openjdk@8/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-8.jdk
  pathJ="/Users/${user}/homebrew/opt/openjdk@8/bin:$PATH"
  sudo sh -c "echo 'export PATH=${pathJ}' >> ~/.zshrc"
else
  echo "🟡🟡🟡 Essentials software is already in this machine 🟡🟡🟡 "
fi

echo "✅ Essentials done ✅ "

#---------------Team tools installation-----------------
echo "🟡🟡🟡 Installing Team specific software 🟡🟡🟡 "
pathX="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
case $1 in
  qa)
    ./brew install --cask --force appium sourcetree intellij-idea-ce android-studio postman charles vmware-fusion
    ./brew install node@14 jmeter
    pathN="/Users/${user}/homebrew/opt/node@14/bin:$PATH"
    sudo sh -c "echo 'export PATH=${pathN}' >> ~/.zshrc"
    ;;
  
  backend)
    ./brew install --cask --force sourcetree intellij-idea-ce postman docker pgadmin4 oracle-jdk mysqlworkbench cyberduck docker
    ./brew install git gradle node@14 docker
    pathN="/Users/${user}/homebrew/opt/node@14/bin:$PATH"
    sudo sh -c "echo 'export PATH=${pathN}' >> ~/.zshrc"
    brew link --overwrite docker
    ;;

  ios)
    ./brew install --cask --force sourcetree postman sublime-text charles zeplin
    sudo gem install cocoapods applocale

    #RVM installation
    ./brew install gnupg
    gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    sudo \curl -sSL https://get.rvm.io | bash

    sudo sh -c "echo \"export PATH='$PATH:$HOME/.rvm/bin'\" >> /Users/$user/.zshrc"

    #Xcode 12.5.1
    #if [ ! -d "/Applications/Xcode.app" ]; then
    #  echo "🟡🟡🟡 Installing Xcode 12.5.1 🟡🟡🟡"
    #  xip -x "${pathX}/Xcode_12.5.1.xip"
    #else
    #  echo "🟡🟡🟡 Xcode already installed 🟡🟡🟡"
    #fi
    ;;

  android)
    ./brew install --cask --force jetbrains-toolbox sourcetree postman sublime-text charles zeplin android-studio
    ./brew install --force openjdk@11

    gem install applocale
    
    #RVM installation
    ./brew install gnupg
    gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    sudo \curl -sSL https://get.rvm.io | bash

    sudo sh -c "echo "export PATH='$PATH:$HOME/.rvm/bin'" >> /Users/$user/.zshrc"

    #Xcode 12.5.1
    #if [ ! -d "/Applications/Xcode.app" ]; then
    #  echo "🟡🟡🟡 Installing Xcode 12.5.1 🟡🟡🟡"
    #  xip -x "${pathX}/Xcode_12.5.1.xip"
    #else
    #  echo "🟡🟡🟡 Xcode already installed 🟡🟡🟡"
    #fi
    ;;

  web)
    ./brew install --cask --force sourcetree postman sublime-text charles zeplin
    ./brew install node@14

    npm install --global yarn
  ;;

  design)
    ./brew install --cask --force zeplin adobe-creative-cloud sketch figma craftmanager
    ;;

  itba)
    ./brew install --cask --force microsoft-office
  ;;

  *)
    echo "🔴 No team selected 🔴"
    ;;
esac
echo "✅ Team specific software done ✅ "
sleep 1

#---------------Readme for user-----------------
#echo "🟡🟡🟡 README.txt 🟡🟡🟡"
#cd "${pathX}"
#case $1 in
#  qa)
#    cp readme/qa.txt /Users/$user/Desktop/
#    mv /Users/$user/Desktop/qa.txt /Users/$user/Desktop/README.txt
#    ;;
#  
#  backend)
#    cp readme/backend.txt /Users/$user/Desktop/
#    mv /Users/$user/Desktop/backend.txt /Users/$user/Desktop/README.txt
#    ;;
#
#  web)
#    cp readme/web.txt /Users/$user/Desktop/
#	  mv /Users/$user/Desktop/web.txt /Users/$user/Desktop/README.txt
#    ;;
#
#  ios)
#    cp readme/ios.txt /Users/$user/Desktop/
#	  mv /Users/$user/Desktop/ios.txt /Users/$user/Desktop/README.txt
#    ;;
#
#  android)
#    cp readme/android.txt /Users/$user/Desktop/
#	  mv /Users/$user/Desktop/android.txt /Users/$user/Desktop/README.txt
#    ;;
#
#  design)
#    cp readme/design.txt /Users/$user/Desktop/
#    mv /Users/$user/Desktop/design.txt /Users/$user/Desktop/README.txt
#    ;;
#
#  itba)
#    cp readme/itba.txt /Users/$user/Desktop/
#    mv /Users/$user/Desktop/itba.txt /Users/$user/Desktop/README.txt
#  ;;
#
#  *)
#    echo "🔴 No team selected 🔴"
#    ;;
#esac
#echo "✅ README.txt done ✅ "
#
#-----------------Remove Admin-------------------
sudo dseditgroup -o edit -d $user -t user admin

echo "🟡🟡🟡 Installation done. Please reboot the machine..... 🟡🟡🟡"
exit