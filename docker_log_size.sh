#!/bin/bash

# 获取所有正在运行的容器ID
containers=$(docker ps -q)

# 打印表头
printf "%-30s %-15s %s\n" "容器名称" "日志文件大小" "日志文件路径"
echo "-----------------------------------------------------------"

# 循环遍历每个容器ID
for container in $containers; do
    # 获取容器名称
    container_name=$(docker inspect --format='{{.Name}}' $container | sed 's/^\///')

    # 获取容器的日志文件路径
    log_path=$(docker inspect --format='{{.LogPath}}' $container)

    # 获取日志文件大小
    log_size=$(du -h $log_path 2>/dev/null | awk '{print $1}')

    # 输出容器名称、日志文件大小和路径
    if [ -n "$log_size" ]; then
        printf "%-30s %-15s %s\n" "$container_name" "$log_size" "$log_path"
    fi
done | sort -k2 -hr

