# Centos系统镜像初始化配置
FROM centos:7.6.1810

MAINTAINER Base Image Centos <haixiang.dai@ssxingshou.com>

#定义时区变量
ENV TZ=Asia/Shanghai
ENV LC_ALL en_US.UTF-8

# 设置时区
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo '$TZ' > /etc/timezone \
    #设置终端提示符
    && cp /etc/skel/.bashrc /root/ \
	&& cp /etc/skel/.bash_profile /root/ \
	#设置终端颜色
	&& echo 'export PS1="\[\e]0;\a\]\n\[\e[1;32m\]\[\e[1;33m\]\H\[\e[1;35m\]<\$(date +\"%Y-%m-%d %T\")> \[\e[32m\]\w\[\e[0m\]\n\u>\\$ "' >> /etc/profile \
	&& source /etc/profile
	
# 更换Aliyun的镜像源 
# 常用命令安装
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak \
    && curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo \
    && yum makecache \
    && yum -y update \
    && yum install -y wget vim telnet less net-tools
