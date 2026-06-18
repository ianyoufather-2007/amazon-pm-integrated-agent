# Example: research stage Run

## User Prompt

```text
我已经有 BSR Top100、主关键词、部分 ABA/CPC 数据和 20 个竞品 ASIN。请判断现在能跑到哪个阶段，并输出执行框架。
```

## Expected Agent Behavior

1. 判断可进入 Research Round 1。
2. 路由到 001-003，并准备 004-1 竞品 ASIN 初选。
3. 声明允许输出和禁止输出。
4. 输出 P0/P1/P2 数据缺口。

## Output Structure

```text
## 结论摘要

当前资料足够进入 Research Round 1：001 公司匹配、002 趋势需求、003 市场结构，并可准备 004-1 竞品 ASIN 初选。

## 当前阶段判断

Research Round 1。

## 允许输出

- 市场判读
- 形态拆分
- 主攻形态候选
- 竞品 ASIN 初选
- P0/P1/P2 下载清单

## 禁止输出

- 最终产品定义
- 最终 ROI
- 量产建议

## 事实层

## 判读层

## 风险层

## 数据缺口

## 下一步动作

## 待会议裁定问题
```
