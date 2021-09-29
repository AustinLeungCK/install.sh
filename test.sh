echo "🟡🟡🟡 README.txt 🟡🟡🟡"

user=${SUDO_USER:-${USER}}
    #Xcode 12.5.1
    if [ ! -d "/Applications/Xcode.app" ]; then
      #echo "🟡🟡🟡 Installing Xcode 12.5.1 🟡🟡🟡"
      #xip -x 
	  pathX="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
	  #pathX=${0:a:h}
	  cd "${pathX}"
	  pwd
	  #echo $pathX
	  #echo "${pathX}/Xcode_12.5.1.xip"
    else
      echo "🟡🟡🟡 Xcode already installed 🟡🟡🟡"
    fi
#cd $0:A
#pwd
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
#	mv /Users/$user/Desktop/web.txt /Users/$user/Desktop/README.txt
#    ;;
#
#  ios)
#    cp readme/ios.txt /Users/$user/Desktop/
#	mv /Users/$user/Desktop/ios.txt /Users/$user/Desktop/README.txt
#    ;;
#
#  android)
#    cp readme/android.txt /Users/$user/Desktop/
#	mv /Users/$user/Desktop/android.txt /Users/$user/Desktop/README.txt
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

#if [ "$1" = "design" ]  ; then
#    echo "design"
#fi

#if [ "$1" == "design" ] && [ ! -d "/Applications/Google\ Chrome.app/" ] ; then
#    echo "design true, need install chrome"
#elif [ ! -d "/Applications/Google\ Chrome.app/" ] ; then
#    echo "no chrome"
#else 
#    echo "WTF"
#fi