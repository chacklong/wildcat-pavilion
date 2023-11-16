# 使用Node官方镜像作为构建环境
FROM node:20-alpine

# 设置工作目录
WORKDIR /usr/src/wildcat-pavilion

# 复制package.json和yarn.lock文件
COPY package*.json ./

# 安装依赖
RUN npm install

# 复制所有源代码到工作目录
COPY . .

# 构建应用
RUN npm run build

# 应用启动命令
CMD ["npm","run","develop"]

# 暴露的端口
EXPOSE 1337
