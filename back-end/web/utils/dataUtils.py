from calendar import isleap
from web import models
from django.db.models.fields import DateTimeField, DateField, TimeField
from django.db.models.fields.related import ManyToManyField, ForeignKey
from AdudittingSystem.utils.AuditUtils import faceAndPornDetection, vedioDetection, sensitiveWordDetection
from datetime import datetime
from web.utils.obsUtils import downloadFromObs, IMGFOLDER, VEDIOFOLDER
from AdudittingSystem.video_slide import VIDEO_SLIDE, get_time, merge

userModel=models.User.objects
contentModel=models.Content.objects
AudithistoryModel=models.Audithistory.objects

# 可以但没用
def QuerySet2ModelList (queryset):
    list=[]
    for item in queryset:
        list.append(item)
    return list

# 将query中的单独的一个对象转化成前端可以接收的json的格式、字典
def model2dict(obj, fields=None, exclude=None):
    """
    将 Model 对象 obj 转化为字典格式返回
    :param obj: 通过 model.objects.filter().first() 、model.objects.get() 或者 for i in QuerySet 获取的对象
    :param fields: 要选择性呈现的字段
    :param exclude: 排除呈现的字段
    :return: 返回字典 {'id': 1, 'field1': 'field1_data'}
    """
    data = {}
    for f in getattr(obj, '_meta').concrete_fields + getattr(obj, '_meta').many_to_many:
        value = f.value_from_object(obj)

        if fields and f.name not in fields:
            continue

        if exclude and f.name in exclude:
            continue

        if isinstance(f, ManyToManyField):
            value = [i.id for i in value] if obj.pk else None

        elif isinstance(f, DateTimeField):
            value = value.strftime('%Y-%m-%d %H:%M:%S') if value else None

        elif isinstance(f, DateField):
            value = value.strftime('%Y-%m-%d') if value else None

        elif isinstance(f, TimeField):
            value = value.strftime('%H:%M:%S') if value else None

        # elif isinstance(f, DecimalField):
        #     value = float_value(f)

        # ForeignKey 特殊处理
        if isinstance(f, ForeignKey):
            data[f.column] = value
            data[f.name] = value
        else:
            data[f.name] = value

    # # 获取 property 里面的数据
    # for p in getattr(getattr(obj, '_meta'), '_property_names'):
    #     value = getattr(obj, p)
    #     if isinstance(value, (str, int, Decimal)):
    #         data[p] = value
    return data

# 前端只需要一个元素，将一个元素转化成一个字典
def Query2Dict(queryset):
    modelList = QuerySet2ModelList(queryset)
    if len(modelList)==1:
        dict=model2dict(modelList[0])
    return dict

# 前端需要多个元素，将所有元素转化为字典过后进行包装，包装成一个字典列表
def Query2DictList(queryset):
    modelList = QuerySet2ModelList(queryset)
    dictList = []
    for model in modelList:
        a = model2dict(model)
        dictList.append(a)
    return dictList


def myResponseDict(message, data, status=True, code=0):
    res = {"status": status, "code": code, "message": message,"data": data}
    return res

# content与user表进行关联
def contentWithUser_Query2DictList(contentsQuery):
    contents= Query2DictList(contentsQuery)
    print(type(contents))
    if type(contents)==dict:        
        contents=letContentWithUser(contents)
        
    if type(contents)==list:
        for i in range(0,len(contents)):
            contents[i]=letContentWithUser(contents[i])
    return contents   


def contentWithUser_Query2Dict(contentsQuery):
    contents = Query2Dict(contentsQuery)
    print(type(contents))
    if type(contents) == dict:
        contents = letContentWithUser(contents)

    if type(contents) == list:
        for i in range(0, len(contents)):
            contents[i] = letContentWithUser(contents[i])
    return contents
        
def letContentWithUser(content):
    #这里的content是个字典类型
        userid = content['userid']
        userQuery = userModel.filter(id=userid).values(
            'username', 'email', 'roleid', 'inwhitelist')
        # user=Query2DictOrDictList(userQuery)
        print(type(userQuery),userQuery)
        user = userQuery[0]
        content['username']=user['username']
        content['email']=user['email']
        content['roleid']=user['roleid']
        content['inwhitelist']=user['inwhitelist']
        return content

# 将auditHistory与user以及content进行关联
def auditWithUserContent_Query2DictList(auditQuery):
    audits=Query2DictList(auditQuery)
    for i in range(0,len(audits)):
        audits[i] = letAuditWithUserContentAndModifyField(audits[i])
    return audits
        

def letAuditWithUserContentAndModifyField(audit):
    # 这里audit是个字典类型
    userid=audit['userid']
    userQuery=userModel.filter(id=userid).values('username')
    user=userQuery[0]
    
    contentid=audit['contentid']
    contentQuery=contentModel.filter(id=contentid).values('mediatitle')
    content = contentQuery[0]
    
    audit['username']=user['username']
    audit['mediatitle']=content['mediatitle']
    # 修改 method，pass_field, reason
    if(audit['method']==0):
        audit['method']='manual audit'
    else:
        audit['method'] = 'model audit'
        
    if (audit['pass_field'] == 0):
        audit['pass_field'] = 'NO'
    else:
        audit['pass_field'] = 'YES'
        
    if (audit['reason'] == 0):
        audit['reason'] = ''
    elif (audit['reason'] == 1):
        audit['reason'] = 'porn'
    elif(audit['reason'] == 2):
        audit['reason'] = 'banned face'
    elif(audit['reason']==3):
        audit['reason'] = 'banned face and porn'
    else:
        audit['reason'] = 'sensitive'

    return audit

# 为了批量审核的batch做准备
def numOfModelUnaudit(contentsDictList):
    num=0
    for contentDict in contentsDictList:
        if contentDict['lablefrommodel']==-2:
            num+=1
    return num

# 根据query和type对内容进行审核
# 分类-审核-改content /如果有确定的结果，audit增加一条数据
# 改content需要checkresult，lablefrommodel，updatetime，id,reason
def Audit1Content(contentQuery,typeid):
    now = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    contentDict = Query2Dict(contentQuery)

    result={'checkresult':1,'lablefrommodel':1,'updatetime':now,
            'reason':0,'pass_field':1}

    if typeid == '0':
        data = sensitiveWordDetection(contentDict['strings'])
        if len(data)!=0:
            result['lablefrommodel']=0
            result['checkresult']=-1
            result['reason']=4
            result['pass_field']=0
    if typeid=='1':
        path = downloadFromObs(contentDict['url'], IMGFOLDER)
        data=faceAndPornDetection(path)
        if len(data['face'])!=0:
            result['checkresult']=-1
            result['lablefrommodel'] = 0
            result['pass_field'] = 0
            if data['porn']>=0.95:
                result['reason'] =3
            else:
                result['reason'] =2
        if len(data['face']) == 0:
            if data['porn']>=0.95:
                result['checkresult']=-1
                result['lablefrommodel']=0
                result['reason']=1
                result['pass_field'] = 0
            if data['porn']<0.95 and data['porn']>=0.75:
                result['lablefrommodel']=-1
                result['checkresult']=0
            if data['porn']<0.75:
                result['lablefrommodel'] = 1
                result['checkresult']=1
                result['reason']=0
                result['pass_field']=1
    if typeid=='2':
        path = downloadFromObs(contentDict['url'], VEDIOFOLDER)
        pathdir = VIDEO_SLIDE(path)
        data=vedioDetection(pathdir)
        if len(data['face'])!=0:
            result['checkresult']=-1
            result['lablefrommodel'] = 0
            result['pass_field'] = 0
            if data['porn']>=0.95:
                result['reason'] =3
            else:
                result['reason'] =2
        if len(data['face']) == 0:
            if data['porn']>=0.95:
                result['checkresult']=-1
                result['lablefrommodel']=0
                result['reason']=1
                result['pass_field'] = 0
            if data['porn']<0.95 and data['porn']>=0.75:
                result['lablefrommodel']=-1
            if data['porn']<0.75:
                result['lablefrommodel'] = 1
                result['checkresult']=1
                result['reason']=0
                result['pass_field']=1
    return result

# now = datetime.now()
def now2FromEnd(now,deltaYear=0,deltaMonth=0,deltaDay=0,type=0):
    year=now.year
    month=now.month
    day=now.day
    
    fromYear=year-deltaYear
    fromMonth=month-deltaMonth
    fromDay=day-deltaDay   
    fromHour = 0
    fromMinute = 0
    fromSecond=0
 
    toYear=year
    toMonth=month
    toDay=day 
    toHour=23
    toMinute=59
    toSecond=59
    
    if fromDay <= 0:
        fromMonth -= 1
        if fromMonth == 0:
            fromDay+=31
        if fromMonth== 2:
            if isleap(fromYear):
                fromDay+=29
        if fromMonth<=7  and fromMonth!=2:
            if fromMonth%2==0:
                fromDay+=30
            else:
                fromDay+=31
        if fromMonth>=8 :
            if toMonth %2==0:
                fromDay+=31
            else:
                fromDay+=30

    
    if (fromMonth <= 0 and fromMonth>=-11):
        fromMonth += 12
        fromYear -= 1
    fromTime = datetime(fromYear, fromMonth, fromDay,
                        fromHour, fromMinute, fromSecond)
    toTime = datetime(toYear,toMonth,toDay,toHour,toMinute,toSecond)
    
    if type!=0:
        toTime = datetime(fromYear, fromMonth, fromDay,
                          toHour, toMinute, toSecond)
    return fromTime,toTime

        
        
