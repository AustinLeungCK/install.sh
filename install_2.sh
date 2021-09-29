#!/bin/zsh

user=${SUDO_USER:-${USER}}

#----------------Essentials installation----------------
cd /Users/$user/homebrew/bin

echo "🟡🟡🟡 Installing Essentials software 🟡🟡🟡 "
if [[ "$1" == "design" ] && [ ! -d "Google\ Chrome.app" ]] ; then
  brew install --cask --force google-chrome firefox zoom-for-it-admins slack chrome-remote-desktop-host notion rectangle
else if [ ! -d "Google\ Chrome.app" ] ; then
  brew install --cask --force adobe-acrobat-reader google-chrome firefox zoom-for-it-admins iterm2 visual-studio-code slack chrome-remote-desktop-host notion rectangle
  brew install openjdk@8

  sudo ln -sfn /Users/$user/homebrew/opt/openjdk@8/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-8.jdk
  pathJ="/Users/${user}/homebrew/opt/openjdk@8/bin:$PATH"
  sudo sh -c "echo 'export PATH=${pathJ}' >> ~/.zshrc"
fi

echo "✅ Essentials done ✅ "

#---------------Team tools installation-----------------
echo "🟡🟡🟡 Installing Team specific software 🟡🟡🟡 "
case $1 in
  qa)
    brew install --cask --force appium sourcetree intellij-idea-ce android-studio postman charles vmware-fusion
    brew install node@14 jmeter
    pathN="/Users/${user}/homebrew/opt/node@14/bin:$PATH"
    sudo sh -c "echo 'export PATH=${pathN}' >> ~/.zshrc"
    ;;
  
  backend)
    brew install --cask --force sourcetree intellij-idea-ce postman docker pgadmin4 oracle-jdk mysqlworkbench cyberduck docker
    brew install git gradle node@14 docker
    pathN="/Users/${user}/homebrew/opt/node@14/bin:$PATH"
    sudo sh -c "echo 'export PATH=${pathN}' >> ~/.zshrc"
    ;;

  ios)
    brew install --cask --force sourcetree postman sublime-text charles zeplin
    gem install --user-install cocoapods applocale

    #RVM installation
    brew install gnupg rsync
    gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    sudo \curl -sSL https://get.rvm.io | bash

    sudo sh -c "echo \"export PATH='$PATH:$HOME/.rvm/bin'\" >> /Users/$user/.zshrc"

    #Xcode 12.5.1

	  cd /Applications
    if [ ! -d "Xcode.app" ]; then
      echo "🟡🟡🟡 Installing Xcode 12.5.1 🟡🟡🟡"
      xip -x "/Volumes/xp/Xcode_12.5.1.xip"
    fi
    ;;

  android)
    brew install --cask --force jetbrains-toolbox sourcetree postman sublime-text charles zeplin android-studio
    brew install --force openjdk@11

    gem install --user-install applocale
    
    #RVM installation
    brew install gnupg rsync
    gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    sudo \curl -sSL https://get.rvm.io | bash

    sudo sh -c "echo "export PATH='$PATH:$HOME/.rvm/bin'" >> /Users/$user/.zshrc"

    #Xcode 12.5.1
	  cd /Applications
	  if [ ! -d "Xcode.app" ]; then
      echo "🟡🟡🟡 Installing Xcode 12.5.1 🟡🟡🟡"
      xip -x "/Volumes/xp/Xcode_12.5.1.xip"
    fi
    ;;

  web)
    brew install --cask --force sourcetree postman sublime-text charles zeplin
    brew install node@14

    npm install --global yarn
  ;;

  design)
    brew install --cask --force zeplin adobe-creative-cloud sketch figma craftmanager
    ;;

  *)
    echo "🔴 No team selected 🔴"
    ;;
esac
echo "✅ Team specific software done ✅ "
sleep 1

#---------------Readme for user-----------------
case $1 in
  qa)
    cp readme/qa.txt /Users/$user/Desktop/
    mv /Users/$user/Desktop/qa.txt /Users/$user/Desktop/README.txt
    ;;
  
  backend)
    cp readme/backend.txt /Users/$user/Desktop/
    mv /Users/$user/Desktop/backend.txt /Users/$user/Desktop/README.txt
    ;;

  web)
    cp readme/web.txt /Users/$user/Desktop/
	mv /Users/$user/Desktop/web.txt /Users/$user/Desktop/README.txt
    ;;

  ios)
    cp readme/ios.txt /Users/$user/Desktop/
	mv /Users/$user/Desktop/ios.txt /Users/$user/Desktop/README.txt
    ;;

  android)
    cp readme/android.txt /Users/$user/Desktop/
	mv /Users/$user/Desktop/android.txt /Users/$user/Desktop/README.txt
    ;;

  design)
    cp design.txt /Users/$user/Desktop/
    mv /Users/$user/Desktop/design.txt /Users/$user/Desktop/README.txt
    ;;

  *)
    echo "🔴 No team selected 🔴"
    ;;
esac

#-----------------Remove Admin-------------------
sudo dseditgroup -o edit -d $user -t user admin

echo "🟡🟡🟡 Installation done. Please reboot the machine..... 🟡🟡🟡"
exit