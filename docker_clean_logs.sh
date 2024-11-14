#!/bin/bash

# 显示菜单选项
echo "请选择操作："
echo "1. 全量清理所有容器日志"
echo "2. 清理指定容器日志（输入容器ID或名称，多个容器间用逗号隔开）"
read -p "输入选项编号（1或2）： " choice

# 清理日志的函数
clean_logs() {
    for container in $1; do
        # 获取容器的日志文件路径
        log_path=$(docker inspect --format='{{.LogPath}}' $container 2>/dev/null)

        # 判断日志路径是否存在
        if [ -f "$log_path" ]; then
            echo "清理容器日志：$container (路径: $log_path)"
            cat /dev/null > "$log_path"  # 清空日志文件内容
        else
            echo "无法找到容器 $container 的日志文件，跳过..."
        fi
    done
}

if [ "$choice" -eq 1 ]; then
    # 选项1：清理所有容器日志
    containers=$(docker ps -q)
    clean_logs "$containers"
elif [ "$choice" -eq 2 ]; then
    # 选项2：清理指定容器日志
    read -p "请输入容器ID或名称（多个容器间用逗号隔开）： " input
    # 将输入的容器名称或ID转换为数组
    IFS=',' read -ra container_array <<< "$input"

    # 清理指定容器的日志
    clean_logs "${container_array[@]}"
else
    echo "无效的选项编号，请重新运行脚本并选择正确的选项。"
fi

