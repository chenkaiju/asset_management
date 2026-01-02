---
description: 結束目前開發階段，同步進度至根目錄並推送到雲端
---

當您準備結束目前的開發工作時，執行此工作流以確保所有進度都已妥善保存：

1. **同步進度至根目錄**：
   將當前對話生成的 Artifacts 同步到專案根目錄，覆蓋舊有文件：
   - `C:\Users\XRSPACE\.gemini\antigravity\brain\0d3bd3a0-4556-4e73-9e5c-0a11fd1e6052\walkthrough.md` -> `d:\antigravity\asset_management\walkthrough.md`
   - `C:\Users\XRSPACE\.gemini\antigravity\brain\0d3bd3a0-4556-4e73-9e5c-0a11fd1e6052\task.md` -> `d:\antigravity\asset_management\task.md`
   - `C:\Users\XRSPACE\.gemini\antigravity\brain\0d3bd3a0-4556-4e73-9e5c-0a11fd1e6052\implementation_plan.md` -> `d:\antigravity\asset_management\implementation_plan.md`

// turbo
2. **自動 Git 提交與推送**：
   執行以下指令將變更推送到 GitHub：
   ```bash
   git add walkthrough.md task.md implementation_plan.md
   git commit -m "Docs: Automated handoff sync"
   git push origin main
   ```

3. **總結報告**：
   簡短報告目前已完成的功能與待辦事項，並告知使用者可以安全關閉對話。
