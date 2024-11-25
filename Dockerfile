# 基于 Ubuntu 镜像构建 Docker 镜像
FROM ubuntu:20.4


EXPOSE 22

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install openssh-server ssh curl git vim wget  && \
    mkdir /var/run/sshd && \
    echo 'root:root' | chpasswd && \
    sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -ri 's/^#?PasswordAuthentication\s+.*/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -ri 's/^#?X11Forwarding\s+.*/X11Forwarding yes/' /etc/ssh/sshd_config && \
    sed -ri 's/^#?X11UseLocalhost\s+.*/X11UseLocalhost no/' /etc/ssh/sshd_config && \
    sed -ri 's/^#?UsePAM\s+.*/UsePAM no/' /etc/ssh/sshd_config && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean


# # 设置环境变量
# ENV MY_ENV_VAR=test

# # 设置工作目录
# WORKDIR /app

# # 复制本地文件到容器中
# COPY . .


# # 运行命令
# CMD ["echo", "Hello, world!"]
CMD ["/usr/sbin/sshd", "-D"]
