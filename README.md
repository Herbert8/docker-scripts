
# 🐳 Docker Inspect Web Viewer

轻量级 Bash + HTML 工具，用于以**交互式网页方式展示 Docker 镜像与容器的详细信息**。
无需任何后端依赖，直接在浏览器中查看 `docker inspect` 的结果，支持过滤、排序、展开、折叠等功能。

---

## 📦 功能特性

* 🔍 **图形化展示**

  * 以表格形式展示镜像或容器的关键信息。
  * 支持展开详情（如挂载卷、标签等）。

* 🧭 **交互式操作**

  * 点击列头可排序（升序 / 降序切换）。
  * 输入关键字实时过滤并高亮匹配。

* 🧩 **纯本地执行**

  * 生成的 HTML 页面可离线打开，无需 HTTP 服务。
  * 无外部依赖，100% 纯 Bash + HTML + JavaScript 实现。

---

## 🚀 使用方法

### 1. 查看镜像信息

```bash
./dkimgw.sh
```

执行后会：

* 调用 `docker inspect $(docker images -qa)` 获取所有镜像信息；
* 将结果注入到 `img-viewer.template`；
* 生成临时 HTML 文件并自动用浏览器打开。

### 2. 查看容器信息

```bash
./dkpsw.sh
```

执行后会：

* 调用 `docker inspect $(docker ps -qa)` 获取所有容器信息；
* 使用 `container-viewer.template` 生成对应网页；
* 自动在浏览器中打开。

---

## 🧠 原理简介

* 两个 Bash 脚本 (`dkimgw.sh`、`dkpsw.sh`) 负责调用 Docker CLI：

  * 使用 `docker inspect` 获取完整 JSON；
  * 读取对应模板文件；
  * 将 JSON 内容替换模板中的占位符：

    * `__DOCKER_INSPECT_JSON_PLACEHOLDER__`
    * `__DOCKER_CONTAINER_INSPECT_PLACEHOLDER__`
  * 输出临时 HTML 文件并通过 `open` 命令打开浏览器。

* 模板文件中包含纯前端逻辑（HTML + JavaScript）：

  * 自动解析 JSON；
  * 渲染成可排序、可搜索、可展开的表格。

---

## ⚙️ 依赖

* 运行环境：

  * `bash` (>= 4.0)
  * `docker` (可正常执行 `docker inspect`)
  * `gmktemp`（GNU coreutils 的 `mktemp` 变体）
  * `open`（macOS 默认命令；Linux 可改为 `xdg-open`）

---

## 🧰 自定义

你可以修改模板中的：

* 样式（CSS）
* 表格列
* 展开详情的逻辑
* 默认排序或搜索行为

模板中的占位符：

```html
<script id="embeddedJson" type="application/json">__DOCKER_CONTAINER_INSPECT_PLACEHOLDER__</script>
```

或：

```html
<script id="embeddedJson" type="application/json">__DOCKER_IMAGE_INSPECT_PLACEHOLDER__</script>
```

执行脚本时会被替换成实际 JSON。

---

## 🧑‍💻 贡献

欢迎 PR：

* 新字段展示
* 交互优化
* 移动端兼容
* Docker Compose 支持

