#yum repository 파일 다운로드 
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
#yum repository 설치 -> epel.repo가 새로 설치됨
rpm -Uvh epel-release-6-8.noarch.rpm
 
#repository 중복방지편집 -> 기본사용되지 않도록 enabled=1 -> 0 으로 변경
sed -i "6s/.*/enabled=0/g" /etc/yum.repos.d/epel.repo
#저장소 중복방지 설정후 yum 을 이용하여 관련패키지 설치
yum -y install gcc make rpm build autoconf automake flex bison libpcap-devel pcre-devel libdnet libdnet-devel zlib-devel
 #저장소 중복방지 설정후 yum 을 이용하여 관련패키지 설치 -> 다른 저장소를 사용하여 설치
yum -y install --enablerepo=epel libdnet libdnet-devel 

