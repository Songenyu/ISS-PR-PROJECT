from django.db import models
# BigAutoField


class User(models.Model):
    id = models.BigAutoField(primary_key=True)
    # Field name made lowercase.
    username = models.CharField(db_column='userName', max_length=20)
    # Field name made lowercase.
    password = models.CharField(db_column='passWord', max_length=20)
    email = models.CharField(max_length=200, blank=True, null=True)
    # Field name made lowercase.
    roleid = models.IntegerField(db_column='roleId', blank=True, null=True)
    # Field name made lowercase.
    inwhitelist = models.IntegerField(db_column='inWhiteList')
    is_deleted = models.IntegerField(blank=True, null=True)
    # Field name made lowercase.
    createtime = models.DateTimeField(
        db_column='createTime', blank=True, null=True)
    # Field name made lowercase.
    updatetime = models.DateTimeField(
        db_column='updateTime', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'user'


class Content(models.Model):
    id = models.BigAutoField(primary_key=True)
    # Field name made lowercase.
    typeid = models.IntegerField(db_column='typeId')
    # Field name made lowercase.
    userid = models.ForeignKey('User', models.DO_NOTHING, db_column='userId')
    # Field name made lowercase.
    fromresource = models.CharField(db_column='fromResource', max_length=200)
    # Field name made lowercase.
    mediatitle = models.CharField(
        db_column='mediaTitle', max_length=200, blank=True, null=True)
    # Field name made lowercase.
    checkresult = models.IntegerField(db_column='checkResult')
    # Field name made lowercase.
    lablefrommodel = models.IntegerField(
        db_column='lableFromModel', blank=True, null=True)
    url = models.CharField(max_length=200, blank=True, null=True)
    # Field name made lowercase.
    frameurl = models.CharField(
        db_column='frameUrl', max_length=200, blank=True, null=True)
    strings = models.CharField(max_length=400, blank=True, null=True)
    # Field name made lowercase.
    createtime = models.DateTimeField(
        db_column='createTime', blank=True, null=True)
    # Field name made lowercase.
    updatetime = models.DateTimeField(
        db_column='updateTime', blank=True, null=True)
    is_deleted = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'content'


class Audithistory(models.Model):
    id = models.BigAutoField(primary_key=True)
    # Field name made lowercase.
    userid = models.ForeignKey(
        'User', models.DO_NOTHING, db_column='userId', blank=True, null=True)
    # Field name made lowercase.
    contentid = models.ForeignKey(
        'Content', models.DO_NOTHING, db_column='contentId', blank=True, null=True)
    method = models.IntegerField(blank=True, null=True)
    # Field renamed because it was a Python reserved word.
    pass_field = models.IntegerField(db_column='pass', blank=True, null=True)
    reason = models.IntegerField(blank=True, null=True)
    # Field name made lowercase.
    createtime = models.DateTimeField(
        db_column='createTime', blank=True, null=True)
    # Field name made lowercase.
    updatetime = models.DateTimeField(
        db_column='updateTime', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'audithistory'
