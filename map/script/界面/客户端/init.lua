ac.ui = {}
ac.ui.client = {}
ac.ui.server = {}
require '界面.客户端.控制台'
--覆盖整个屏幕的面板
ac.ui.client.panel = class.panel.create('', 0, 0, 1920, 1080)

require '界面.客户端.提示框'
--商店和物品的提示

require '界面.客户端.菜单'
require '界面.客户端.全屏提醒'
require '界面.客户端.属性面板'
require '界面.客户端.英雄属性'
require '界面.客户端.存档信息'
require '界面.客户端.动态边框'
