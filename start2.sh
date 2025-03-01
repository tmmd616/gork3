#!/bin/bash
# 启动虚拟显示
Xvfb :99 -screen 0 1024x768x16 &
export DISPLAY=:99

# 启动您的Node.js应用
node server.js