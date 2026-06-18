# Open-Source Cleanup Checklist

如果后续要把这个整合 Agent 开源，先按这个清单处理。

## Do Not Publish

- Raw ASIN JSON
- A+ 页面截图
- Excel / PPT / PDF 产物
- `serving_trays_data.json` 这类真实业务数据
- `__pycache__`
- 本地绝对路径
- 账号、cookie、session、`.env`
- 供应商报价、客户/订单/广告后台数据

## Safe To Publish After Review

- `AGENT.md`
- `agent.yaml`
- `README.md`
- 路由文档
- 阶段门摘要
- 脱敏 examples
- 工具脚本中的通用逻辑
- 不含业务数据的 schema/template

## Refactor Before Publishing

1. 把 `source/` 中的真实数据换成 `examples/anonymized/`。
2. 把本地路径改成相对路径。
3. 将 000-007 stage-gate 拆成干净的 `skills/` 或 `workflow/`。
4. 将工具脚本放到 `tools/`，并补 usage。
5. 添加 LICENSE / SECURITY / CONTRIBUTING。
6. 做敏感词扫描。

