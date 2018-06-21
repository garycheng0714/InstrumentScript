count=$1
test_case=$2
result_file=$HOME/Desktop/important/Espresso_script/result.text

if [ -f $result_file ]
then
    rm $result_file
fi

for((i=1;i<=$count;i++))
do
    adb shell am instrument -w -r -e debug false -e class com.kkbox.tests.e2e.$test_case com.skysoft.kkbox.android.test/android.support.test.runner.AndroidJUnitRunner >> $result_file
done

cat $result_file | grep Failure > /dev/null

if [ $? -eq 1 ]
then
    printf "\033[32m"
    echo Success
    printf "\033[0m"
else
    printf "\033[31m"
    echo Fail
    printf "\033[0m"
    cat $result_file | less
fi

