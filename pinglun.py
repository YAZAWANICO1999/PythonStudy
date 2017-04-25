# coding=utf-8
import re

# 路径设置
path = '/home/nico/作业/'
s_path = path + '结果/'
# 词典
js = ['反派', '角色', '角色中的其他', '男主角', '女主角', '配角']
jq = ['发展', '结局', '剧情', '开头', '泪点', '笑点']
st = ['动作', '画面', '镜头', '视听', '试听效果中的其他', '音乐']
zz = ['编剧', '出品公司', '导演', '选景', '制作']
zt = ['风格', '题材内容', '主题']
DIC = [js, jq, st, zz, zt]
name = ['角色', '剧情', '视听', '制作', '主题']


def focus(n, x):
    d = []
    pa = path + '词典/' + n + '/' + x
    if x != '试听效果中的其他':
        pa = pa + '.txt'
    with open(pa, 'r') as p:
        for point in p.readlines():
            if x == '选景':
                point = point.decode('gb2312').encode('utf8')
            if point != '\n':
                point = re.sub('\n', '', point)
                point = re.sub(' ', '', point)
                d.append(point)
                with open(path + '太空旅客.txt', 'r') as f:
                    d.append(len(re.findall(point, f.read())))
    return d


def hot(focus_d):
    hot_level = 0
    for h in focus_d[1::2]:
        hot_level = hot_level + h
    return hot_level


def go(n, x):
    with open(s_path + n, 'a') as f:
        f.write(x + ':' + str(hot(focus(n, x))) + '\n')


for i in range(5):
    na = name[i]
    dic = DIC[i]
    for po in dic:
        go(na, po)
