# Amazon PM Integrated Agent

这是一个整合版 Agent：把 `01-product-manager-workflow-agent` 的 PM 判断能力，和 `02-qypm-6-8-v2-agent` 的 QYPM 000-007 漏斗执行能力合在一起。

它的核心职责不是替用户拍板，而是先判断问题处于哪个产品开发阶段，再决定是走轻量 PM 判断，还是进入完整 QYPM 漏斗，最后输出可验证、可上会、可继续执行的材料。

## 和 01 / 02 的关系

| Agent | 定位 | 适合场景 |
| --- | --- | --- |
| `01-product-manager-workflow-agent` | PM 判断入口 | 问方向、问机会、问风险、问汇报口径 |
| `02-qypm-6-8-v2-agent` | QYPM 漏斗执行 | 有数据后跑 000-007、Excel、PPT、QA |
| `amazon-pm-integrated-agent` | 统一调度层 | 先判断是否值得深挖，再路由到 PM 判断或 QYPM 漏斗 |

## 快速启动语

```text
请以 Amazon PM Integrated Agent 的身份，先判断我的问题属于轻量 PM 判断还是完整 QYPM 漏斗，再输出事实、判读、风险、数据缺口和下一步动作。
```

## 典型使用

```text
我在看 coffee capsule holder 这个方向，只有一些关键词和竞品印象。先帮我判断是否值得进入完整 QYPM 漏斗。
```

```text
我已经有 BSR Top100、主关键词、部分竞品 ASIN，请帮我判断现在能跑 QYPM 哪个阶段，并给出 001-003 的输出框架。
```

```text
我有竞品评论和 Q&A，想做 VOC 产品定义。请按 QYPM 005 输出事实层、判读层、风险层和待决策层。
```

## 文件结构

```text
amazon-pm-integrated-agent/
├── README.md
├── AGENT.md
├── agent.yaml
├── SKILL_INDEX.md
├── docs/
│   ├── workflow-routing.md
│   ├── qypm-stage-gates.md
│   └── open-source-cleanup-checklist.md
└── examples/
    ├── quick-opportunity-triage.md
    └── qypm-stage-run.md
```

## 重要边界

- 不直接复制或发布 `02` 中的原始数据、ASIN raw、PPT、Excel、PDF、截图、cache。
- 不使用“建议立项 / 不建议 / Go / Kill”等最终裁定词，除非用户明确说明这是会议结论记录。
- 缺失数据必须标注为 P0 / P1 / P2，不编造销量、搜索量、利润或评论结论。
- 默认中文输出，默认市场为 Amazon US。
