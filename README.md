# docker_log_cleaner

简单可选的docker日志清理脚本。上传它们到Linux服务器的任意位置，并赋予可执行权限。

- **docker_log_size.sh** 显示每个容器日志的磁盘占用情况，按照占用空间大小倒序排序
- **docker_clean_logs.sh** 运行它会弹出选项：1. 全量清理所有容器日志 2. 清理指定容器日志
