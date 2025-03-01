FROM mcr.microsoft.com/playwright:v1.46.1-jammy

# 设置工作目录
WORKDIR /app

# 设置非交互式安装和时区
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
# 复制 package.json 和 package-lock.json
COPY package*.json ./

# 安装项目依赖
RUN npm install

# 强制安装与项目匹配的 Playwright 浏览器
RUN PLAYWRIGHT_BROWSERS_PATH=/ms-playwright npx playwright install chromium

# 安装必要的X11和虚拟显示包
RUN apt-get update && apt-get install -y \
    xvfb \
    x11vnc \
    && rm -rf /var/lib/apt/lists/*


# 复制项目文件
COPY . .

# 设置启动脚本
COPY start2.sh /start2.sh
RUN chmod +x /start2.sh

# Change permissions (optional, if needed)
RUN chmod -R 777 /app

# 暴露应用端口
EXPOSE 3333

# 启动命令
CMD ["/start2.sh"]


