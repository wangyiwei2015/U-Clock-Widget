# UClock 小组件

[Click here](https://github.com/wangyiwei2015/U-Clock-Widget/blob/master/README_EN.md) if you prefer **english**.

---

产品页面: [~~App Store~~ TestFlight ↗](https://testflight.apple.com/join/K2gzBf4e)

技术支持与反馈: [Issues ↗](https://github.com/wangyiwei2015/U-Clock-Widget/issues) or [发邮件 ↗](mailto:wangyw.dev@outlook.com)

---

本项目使用的开源代码

- [yamoridon/ColorThiefSwift](https://github.com/yamoridon/ColorThiefSwift)：提取壁纸颜色，作为库引入项目

- [zhangyu1818/clocks-widget](https://github.com/zhangyu1818/clocks-widget)：制作透明背景，嵌入了裁剪相关代码

---

！已知问题：

BackgroudClip.swift - 获取 device type 对 iPhone 13 系列无效，原因未知；临时解决办法：通过 Screen size 判断设备。