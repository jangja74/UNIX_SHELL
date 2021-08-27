#!/bin/sh

echo "\n"
#입력 파라미터 개수 체크 
if [ $# -gt 1 ]; then
    echo "입력하신 파라미터가 $#개 입니다."
    echo "허용된 파라미터는 1개 이하 입니다. 다시 진행하시기 바랍니다."
    echo "예) $0"
    echo "예) $0 [대상일자(yyyymmdd)]"
    exit
elif [ $# -eq 1 ]; then
    INPUT_DATE=$1 
    if [ ${#INPUT_DATE} -ne 8 ]; then
	echo "대상일자 형식이 잘 못되었습니다. 다시 입력해 주십시요"
	echo "대상일자(YYYYMMDD)"
	exit
    fi
    JOB_DATE=$1 
else 
    JOB_DATE=`date +%Y%m%d`
fi


#작업일자 설정
PART_JOB_DATE=`echo $JOB_DATE | cut -c3-8`

#파일명 설정
EDI_FILE_NAME=HDMOBISPG1-RSEND.$PART_JOB_DATE
REPLY_FILE_NAME=HDMOBISPG1-SSEND.$PART_JOB_DATE
echo "=========파일 다운로드를 대상======================"
echo "대상일자:$JOB_DATE"
echo "청구파일:$EDI_FILE_NAME"
echo "입금반송파일:$REPLY_FILE_NAME"
echo "==================================================="
echo "\n"

echo "==========[파일다운로드][시작]======================"

#=========사용자설정===================
#사용자 변수 수정
#테스트 서버 IP
#HOST=203.233.72.57
#운영 서버 IP
HOST=203.233.72.11
#SFTP 접속 계정
USER=HDMOBISPG1
#SFTP 접속 암호
PASSWD=t5*heKbm
#파일 다운로드 위치
LOCAL_DIR=/root/temp/
#======================================

#SFTP 접속 및 파일 가져오기
lftp<<END_SCRIPT
open sftp://$HOST
user $USER $PASSWD
cd RECV
lcd $LOCAL_DIR
get $EDI_FILE_NAME
get $REPLY_FILE_NAME
bye
END_SCRIPT

echo "==========[파일다운로드][종료]======================"
echo "\n"
