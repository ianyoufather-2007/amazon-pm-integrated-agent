# Example: Quick Opportunity Triage

## User Prompt

```text
我在看 coffee capsule holder 这个方向，现在只有几个关键词和一些竞品印象。请先判断有没有必要进入完整 QYPM 漏斗。
```

## Expected Agent Behavior

1. 判断资料不足，不直接做产品定义或 ROI。
2. 使用 PM Triage 路线。
3. 输出是否值得进入 QYPM 深挖。
4. 给出最小补数据清单。

## Output Structure

```text
## 结论摘要

当前只能做机会初判，不足以进入产品定义或 ROI。

## 当前阶段判断

PM Triage / QYPM 000 快筛前置。

## 已有事实

- 关键词：...
- 竞品印象：...

## 信号判读

## 风险与不可逆项

## 数据缺口

| 优先级 | 缺口 | 下一步 |
| --- | --- | --- |
| P0 | BSR Top100 / 主关键词数据 | 补齐后进入 001-003 |
| P0 | 竞品 ASIN 列表 | 补齐后进入 004 |
| P1 | Review 痛点样本 | 补齐后进入 005 |

## 下一步动作

## 待会议裁定问题
```

