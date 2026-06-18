# Example: Anonymized Opportunity Review

This example shows the intended behavior with anonymized, incomplete inputs. It is not a market recommendation.

## User Prompt

```text
市场：Amazon US
方向：coffee capsule holder
已有资料：
- 主关键词：coffee capsule holder, k cup holder, coffee pod organizer
- 初步观察：头部竞品评分高，但造型相似；部分评论提到占空间、抽屉卡顿、容量不匹配
- 暂无：完整 BSR Top100、ABA、CPC、Keepa、供应商报价、专利检索

目标：判断这个方向是否值得进入完整阶段门工作流。
```

## Expected Routing

当前资料不足以进入产品定义、ROI 或供应链判断。应走 `PM Triage / Stage 000`，输出机会初判和补数据清单。

## Expected Output

```text
## 结论摘要

当前只能做机会初判。这个方向可能存在“收纳体验”和“空间效率”的改良机会，但缺少 BSR、关键词容量、竞品结构和价格带数据，不能直接进入产品定义或 ROI。

## 当前阶段判断

PM Triage / Stage 000 快筛。

## 已有事实

- 用户关注 Amazon US 的 coffee capsule holder 方向。
- 已有关键词和部分竞品印象。
- 已观察到潜在 Review 痛点：占空间、抽屉卡顿、容量不匹配。
- 暂无完整 BSR、ABA/CPC、Keepa、供应链、合规、专利信息。

## 信号判读

- 如果 Review 痛点集中且高频，可能存在产品体验改良空间。
- 如果头部竞品高度同质化，新进入者需要明确差异点，不能只做外观微调。
- 如果关键词 CPC 高、头部品牌强、评分壁垒高，后续获客成本可能压缩利润。

## 风险与不可逆项

- 类目可能存在价格战和同质化风险。
- 结构改良可能涉及模具成本，过早开模会带来不可逆投入。
- 若涉及滑轨、旋转、折叠等结构，需要提前做专利和稳定性检查。

## 数据缺口

| 优先级 | 缺口 | 为什么重要 | 下一步 |
| --- | --- | --- | --- |
| P0 | BSR Top100 和价格带 | 判断市场容量和头部集中度 | 下载并分层统计 |
| P0 | 主关键词搜索量/ABA/CPC | 判断需求强度和获客压力 | 拉取关键词数据 |
| P0 | 20-30 个竞品 ASIN | 判断形态、卖点和评论痛点 | 建立竞品池 |
| P1 | Review/Q&A 痛点样本 | 验证体验改良是否真实高频 | 进入阶段 005 |
| P1 | 初步专利风险 | 避免结构方案踩雷 | 检索重点结构词 |
| P2 | 供应商报价和包装尺寸 | 后续 ROI 需要 | 进入阶段 006 前补齐 |

## 下一步动作

1. 先补 BSR Top100、主关键词和 20-30 个竞品 ASIN。
2. 将竞品按形态、价格、容量、评分、Review 痛点分层。
3. 若需求和竞争结构仍有空间，再进入阶段 001-004。

## 待会议裁定问题

- 公司是否愿意接受收纳类产品可能偏低客单、强同质化的竞争环境？
- 是否有能力做结构差异化，而不是只做外观或颜色变化？
- 若需要开模，前期验证预算和样品验证周期是否可接受？
```
