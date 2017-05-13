# -*- coding: utf-8 -*-
import MySQLdb
import sys
reload(sys)
sys.setdefaultencoding('utf8')
path = '/home/nico/树蛙/MySQL上课文件/作业/university/'
if __name__ == '__main__':

    # 连接数据库
    conn = MySQLdb.connect(
        host='localhost',
        port=3306,
        user='root',
        passwd='52025nico',
        charset="utf8",
        db='text',
    )

    # 获取数据库执行游标
    cur = conn.cursor()

    # 将文件按行读取并写入数据库
    with open(path + 'department.txt', 'r') as f:
        for line in f.readlines():
            l = line.split(' ')
            cur.execute("insert into department values('"+l[0]+"','"+l[1]+"','"+l[2]+"')")

    with open(path + 'student.txt', 'r') as f:
        for line in f.readlines():
            l = line.split(' ')
            cur.execute("insert into students values('"+l[0]+"','"+l[1]+"','"+l[2]+"','"+l[3]+"','"+l[4]+"','"+l[5]+"')"
                        )

    with open(path + 'exam.txt', 'r') as f:
        for line in f.readlines():
            l = line.split(' ')
            cur.execute("insert into exam values('"+l[0]+"','"+l[1]+"','"+l[2]+"')")

    # 打印执行结果
    print cur.fetchall()
    cur.close()
    conn.commit()
    conn.close()
