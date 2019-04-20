# *FROM 基础镜像
FROM centos:6

# *MAINTAINER 维护者信息
MAINTAINER Milo <heminlong@qfun.com>

# *RUN 构建镜像时执行的命令
# 修改root密码
RUN echo "root:root" | chpasswd

# 安装 Python 2.7
# *ADD 添加文件
# 可以添加网络资源。如果使用 wget 下载，就不需要添加了
# ADD https://www.python.org/ftp/python/2.7.16/Python-2.7.16.tgz /root/
ADD Python-2.7.16.tar /root/
RUN cd /root/ && \ 
    # 安装编译 Python 需要的包
    yum groupinstall -y "Development tools" && \ 
    yum install -y zlib* bzip2-devel openssl-devel ncurses-devel sqlite-devel tcl-devel tk-devel && \ 
    # yum 没有兼容 Python2.7 ，需要使用 Python 2.6.*
    cp /usr/bin/python /usr/bin/python2.6.6 && sed -i '/python/ s/$/2.6.6/' /usr/bin/yum && \ 
    # 下载 Python 2.7 源码，用 ADD 就不用下载
    # wget --no-check-certificate https://www.python.org/ftp/python/2.7.16/Python-2.7.16.tgz && tar -zxvf Python-2.7.16.tgz && \ 
    # 安装
    cd /root/Python-2.7.16 && ./configure --prefix=/usr/local/ && make && make install

# 安装 pip
ADD get-pip.py /root/
RUN cd /root/ && \ 
    # 下载 get-pip.py，用 ADD 就不用下载
    # curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \ 
    python get-pip.py

# *WORKDIR 工作目录
# 创建并进入/data目录
# WORKDIR /data

# 创建user_00用户
# RUN useradd user_00 -g users
# 把/data目录的拥有者改为user_00
# RUN chown -R user_00:users /data

# *USER 制定运行用户
# USER user_00

